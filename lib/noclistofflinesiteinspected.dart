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

class _OfflineSiteInspectionListState extends State<OfflineSiteInspectionList> {
  List<Map<String, dynamic>> _siteInspections = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSiteInspections();
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
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load site inspections: ${error.toString()}';
        _isLoading = false;
      });
    }
  }

  /// Refreshes the site inspection list
  Future<void> _onRefresh() async {
    await _loadSiteInspections();
  }

  /// Shows detailed information for a site inspection
  void _showInspectionDetails(Map<String, dynamic> inspection) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Site Inspection Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Application ID', inspection['app_id']),
              _buildDetailRow('Inspection ID', inspection['id']),
              _buildDetailRow('Location Name', inspection['location_name']),
              _buildDetailRow('Date', inspection['date']),
              // Add more detail rows as needed for other fields
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

  /// Builds a detail row for the inspection details dialog
  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'N/A',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a site inspection list item
  Widget _buildInspectionCard(Map<String, dynamic> inspection) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
            size: 22,
          ),
        ),
        title: Text(
          'App ID: ${inspection['app_id'] ?? 'N/A'}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${inspection['id'] ?? 'N/A'}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              if (inspection['location_name'] != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Location: ${inspection['location_name']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
              if (inspection['date'] != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Date: ${inspection['date']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
        ),
        onTap: () => _showInspectionDetails(inspection),
      ),
    );
  }

  /// Builds the loading state widget
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading site inspections...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No Site Inspections Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'There are no offline site inspections available at the moment.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the error state widget
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.red[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'An unexpected error occurred.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Handle error state
    if (_errorMessage != null && !_isLoading) {
      return _buildErrorState();
    }

    // Handle loading state
    if (_isLoading) {
      return _buildLoadingState();
    }

    // Handle empty state
    if (_siteInspections.isEmpty) {
      return _buildEmptyState();
    }

    // Build the main list
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: _siteInspections.length,
          itemBuilder: (context, index) {
            return _buildInspectionCard(_siteInspections[index]);
          },
        ),
      ),
    );
  }
}
