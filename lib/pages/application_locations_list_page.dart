import 'package:flutter/material.dart';

import '../sqflite/dbhelper.dart';

class ApplicationLocationsListPage extends StatefulWidget {
  const ApplicationLocationsListPage({super.key});

  @override
  _ApplicationLocationsListPageState createState() =>
      _ApplicationLocationsListPageState();
}

class _ApplicationLocationsListPageState
    extends State<ApplicationLocationsListPage> {
  final DbHelper _dbHelper = DbHelper();
  List<Map<String, dynamic>> _locations = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final db = await _dbHelper.database;
      final results = await db.query('application_locations');

      setState(() {
        _locations = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading locations: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLocations,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadLocations,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_locations.isEmpty) {
      return const Center(
        child: Text('No application locations found.'),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadLocations,
      child: ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          final location = _locations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('Location ID: ${location['id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Application ID: ${location['app_form_id']}'),
                  Text('Created: ${location['created_at'] ?? 'N/A'}'),
                  if (location['summary'] != null)
                    Text('Summary: ${location['summary']}'),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                _showLocationDetails(location);
              },
            ),
          );
        },
      ),
    );
  }

  void _showLocationDetails(Map<String, dynamic> location) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Details (ID: ${location['id']})'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem('Application ID', '${location['app_form_id']}'),
              _buildDetailItem(
                  'Created At', '${location['created_at'] ?? 'N/A'}'),
              _buildDetailItem('Summary', '${location['summary'] ?? 'N/A'}'),
              _buildDetailItem(
                  'Log Details', '${location['log_details'] ?? 'N/A'}'),
              const Divider(),
              const Text('Location Images:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDetailItem(
                  'Image 1', '${location['location_img1'] ?? 'None'}'),
              _buildDetailItem(
                  'Image 2', '${location['location_img2'] ?? 'None'}'),
              _buildDetailItem(
                  'Image 3', '${location['location_img3'] ?? 'None'}'),
              _buildDetailItem(
                  'Image 4', '${location['location_img4'] ?? 'None'}'),
              const Divider(),
              const Text('Coordinates:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              _buildDetailItem('Image 1',
                  'Lat: ${location['image1_lat'] ?? 'N/A'}, Long: ${location['image1_log'] ?? 'N/A'}'),
              _buildDetailItem('Image 2',
                  'Lat: ${location['image2_lat'] ?? 'N/A'}, Long: ${location['image2_log'] ?? 'N/A'}'),
              _buildDetailItem('Image 3',
                  'Lat: ${location['image3_lat'] ?? 'N/A'}, Long: ${location['image3_log'] ?? 'N/A'}'),
              _buildDetailItem('Image 4',
                  'Lat: ${location['image4_lat'] ?? 'N/A'}, Long: ${location['image4_log'] ?? 'N/A'}'),
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
}
