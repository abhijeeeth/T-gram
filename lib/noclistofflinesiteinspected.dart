import 'package:flutter/material.dart';

import 'sqflite/dbhelper.dart';

/// A widget that displays a list of offline site inspections
///
/// This widget fetches and displays location images data from the local database
/// and provides an interface for users to view site inspection details.
class OfflineSiteInspectionList extends StatefulWidget {
  const OfflineSiteInspectionList({super.key});

  @override
  State<OfflineSiteInspectionList> createState() =>
      _OfflineSiteInspectionListState();
}

class _OfflineSiteInspectionListState extends State<OfflineSiteInspectionList>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> _siteInspections = [];
  List<Map<String, dynamic>> _filteredInspections = [];
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _loadSiteInspections();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// Fetches site inspection data from the database
  Future<void> _loadSiteInspections() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final dbHelper = DbHelper();
      // Fetch data from application_location_images table
      final inspections = await dbHelper.listAllApplicationLocationImages();

      setState(() {
        _siteInspections = inspections;
        _filteredInspections = inspections;
        _isLoading = false;
      });

      _animationController.forward();
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load site inspections: ${error.toString()}';
        _isLoading = false;
      });
    }
  }

  /// Refreshes the site inspection list
  Future<void> _onRefresh() async {
    _animationController.reset();
    await _loadSiteInspections();
  }

  /// Filters inspections based on search query
  void _filterInspections(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredInspections = _siteInspections;
      } else {
        _filteredInspections = _siteInspections.where((inspection) {
          final appId = inspection['app_id']?.toString().toLowerCase() ?? '';
          final locationName =
              inspection['location_name']?.toString().toLowerCase() ?? '';
          final date = inspection['date']?.toString().toLowerCase() ?? '';
          final searchLower = query.toLowerCase();

          return appId.contains(searchLower) ||
              locationName.contains(searchLower) ||
              date.contains(searchLower);
        }).toList();
      }
    });
  }

  /// Shows detailed information for a site inspection
  void _showInspectionDetails(Map<String, dynamic> inspection) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Site Inspection Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'App ID: ${inspection['app_id'] ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailCard('General Information', [
                      _buildDetailRow(
                          Icons.tag, 'Application ID', inspection['app_id']),
                      _buildDetailRow(
                          Icons.fingerprint, 'Inspection ID', inspection['id']),
                      _buildDetailRow(Icons.location_on, 'Location Name',
                          inspection['location_name']),
                      _buildDetailRow(
                          Icons.calendar_today, 'Date', inspection['date']),
                    ]),
                    const SizedBox(height: 16),
                    // Add more sections as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a detail card with grouped information
  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  /// Builds a detail row with icon for the inspection details
  Widget _buildDetailRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value?.toString() ?? 'Not specified',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the search bar
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterInspections,
        decoration: InputDecoration(
          hintText: 'Search inspections...',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: () {
                    _searchController.clear();
                    _filterInspections('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  /// Builds a site inspection list item with improved styling
  Widget _buildInspectionCard(Map<String, dynamic> inspection, int index) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, (1 - _fadeAnimation.value) * 50),
        child: Opacity(
          opacity: _fadeAnimation.value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Card(
              elevation: 3,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => _showInspectionDetails(inspection),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Status indicator
                      Container(
                        width: 4,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Main content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'ID: ${inspection['app_id'] ?? 'N/A'}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (inspection['location_name'] != null)
                              Text(
                                inspection['location_name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  inspection['date'] ?? 'No date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the loading state widget with improved visuals
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Loading Site Inspections',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we fetch your data...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the empty state widget with improved visuals
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                _searchQuery.isNotEmpty
                    ? Icons.search_off
                    : Icons.assignment_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No Results Found'
                  : 'No Site Inspections',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try adjusting your search criteria'
                  : 'There are no offline site inspections available.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _searchQuery.isNotEmpty
                  ? () {
                      _searchController.clear();
                      _filterInspections('');
                    }
                  : _onRefresh,
              icon: Icon(_searchQuery.isNotEmpty ? Icons.clear : Icons.refresh),
              label: Text(_searchQuery.isNotEmpty ? 'Clear Search' : 'Refresh'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the error state widget with improved visuals
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Something Went Wrong',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _errorMessage ??
                  'An unexpected error occurred while loading data.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Site Inspections',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefresh,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar (only show when not loading and has data)
          if (!_isLoading && _siteInspections.isNotEmpty) _buildSearchBar(),

          // Main content
          Expanded(
            child: () {
              // Handle error state
              if (_errorMessage != null && !_isLoading) {
                return _buildErrorState();
              }

              // Handle loading state
              if (_isLoading) {
                return _buildLoadingState();
              }

              // Handle empty state
              if (_filteredInspections.isEmpty) {
                return _buildEmptyState();
              }

              // Build the main list
              return RefreshIndicator(
                onRefresh: _onRefresh,
                color: Theme.of(context).primaryColor,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: _filteredInspections.length,
                  itemBuilder: (context, index) {
                    return _buildInspectionCard(
                        _filteredInspections[index], index);
                  },
                ),
              );
            }(),
          ),
        ],
      ),
    );
  }
}
