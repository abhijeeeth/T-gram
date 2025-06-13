import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/bloc/main_bloc.dart';

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
      // Fetch data from noc_site_inspection_images table
      final inspections = await dbHelper.listAllNocSiteInspectionImages();

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

  /// Shows detailed information for a site inspection (as dialog, like reference)
  void _showInspectionDetailsDialog(Map<String, dynamic> inspection) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Inspection Details (ID: ${inspection['id']})'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem('Application ID', '${inspection['app_id']}'),
              _buildDetailItem(
                  'Location Name', '${inspection['location_name'] ?? 'N/A'}'),
              _buildDetailItem('Date', '${inspection['date'] ?? 'N/A'}'),
              _buildDetailItem('Summary', '${inspection['summary'] ?? 'N/A'}'),
              const Divider(),
              const Text('Location Images:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDetailItem(
                  'Image 1', '${inspection['location_img1'] ?? 'None'}'),
              _buildDetailItem(
                  'Image 2', '${inspection['location_img2'] ?? 'None'}'),
              _buildDetailItem(
                  'Image 3', '${inspection['location_img3'] ?? 'None'}'),
              _buildDetailItem(
                  'Image 4', '${inspection['location_img4'] ?? 'None'}'),
              const Divider(),
              const Text('Coordinates:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDetailItem('Image 1',
                  'Lat: ${inspection['image1_lat'] ?? 'N/A'}, Long: ${inspection['image1_log'] ?? 'N/A'}'),
              _buildDetailItem('Image 2',
                  'Lat: ${inspection['image2_lat'] ?? 'N/A'}, Long: ${inspection['image2_log'] ?? 'N/A'}'),
              _buildDetailItem('Image 3',
                  'Lat: ${inspection['image3_lat'] ?? 'N/A'}, Long: ${inspection['image3_log'] ?? 'N/A'}'),
              _buildDetailItem('Image 4',
                  'Lat: ${inspection['image4_lat'] ?? 'N/A'}, Long: ${inspection['image4_log'] ?? 'N/A'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  /// Builds a site inspection list item styled like the reference
  Widget _buildInspectionCard(Map<String, dynamic> inspection, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 28, 110, 99),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 28, 110, 99),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.5),
                  topRight: Radius.circular(10.5),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Name: ${inspection['name'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.apps,
                        color: Color.fromARGB(255, 28, 110, 99),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Name: ${inspection['name']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.map,
                        color: Color.fromARGB(255, 28, 110, 99),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Division: ${inspection['division'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  if (inspection['village'] != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.description,
                          color: Color.fromARGB(255, 28, 110, 99),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Village: ${inspection['village'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.upload, size: 18),
                      label: const Text('Upload'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 28, 110, 99),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Map<String, dynamic> data =
                            getFormattedData(inspection);
                        context
                            .read<MainBloc>()
                            .add(OfflineUploadSiteInspection(data: data));
                        _onRefresh();
                      },
                      // onPressed: () => _showInspectionDetailsDialog(inspection),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        backgroundColor: const Color.fromARGB(255, 28, 110, 99),
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
      body: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          // if (state is OfflineUploadSiteInspectionLoaded) {
          //   _onRefresh();
          // }
        },
        builder: (context, state) {
          if (state is OfflineUploadSiteInspectionLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          // if (state is OfflineUploadSiteInspectionLoaded) {
          //   _onRefresh();
          // }
          return Column(
            children: [
              if (!_isLoading && _siteInspections.isNotEmpty) _buildSearchBar(),
              Expanded(
                child: () {
                  if (_errorMessage != null && !_isLoading) {
                    return _buildErrorState();
                  }
                  if (_isLoading) {
                    return _buildLoadingState();
                  }
                  if (_filteredInspections.isEmpty) {
                    return _buildEmptyState();
                  }
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
          );
        },
      ),
    );
  }

  Map<String, dynamic> getFormattedData(Map<String, dynamic> inspection) {
    return {
      "offline": true,
      "app_id": inspection['app_id'],
      "location_img1": inspection['location_img1'],
      "location_img2": inspection['location_img2'],
      "location_img3": inspection['location_img3'],
      "location_img4": inspection['location_img4'],
      "image1_lat": inspection['image1_lat'],
      "image2_lat": inspection['image2_lat'],
      "image3_lat": inspection['image3_lat'],
      "image4_lat": inspection['image4_lat'],
      "image1_log": inspection['image1_log'],
      "image2_log": inspection['image2_log'],
      "image3_log": inspection['image3_log'],
      "image4_log": inspection['image4_log'],
      "context": context,
    };
  }
}
