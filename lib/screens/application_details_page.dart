import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tigramnks/sqflite/localstorage.dart';

class ApplicationDetailsPage extends StatefulWidget {
  final String applicationId;

  const ApplicationDetailsPage({super.key, required this.applicationId});

  @override
  _ApplicationDetailsPageState createState() => _ApplicationDetailsPageState();
}

class _ApplicationDetailsPageState extends State<ApplicationDetailsPage> {
  bool _isLoading = true;
  Map<String, dynamic>? _applicationData;
  Map<String, dynamic>? _applicationDetails;
  List<dynamic>? _timberLogData;
  List<dynamic>? _speciesLocationData;
  List<dynamic>? _imageDocuments;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadApplicationData();
  }

  Future<void> _loadApplicationData() async {
    try {
      // Load all data from local storage
      final String? rawData =
          await LocalStorage.getApplicationData(widget.applicationId);
      final appDetails =
          await LocalStorage.getApplicationDetails(widget.applicationId);
      final timberLog = await LocalStorage.getTimberLog(widget.applicationId);
      final speciesLocation =
          await LocalStorage.getSpeciesLocation(widget.applicationId);
      final imageDocuments =
          await LocalStorage.getImageDocuments(widget.applicationId);

      setState(() {
        if (rawData != null) {
          _applicationData = json.decode(rawData);
        }
        _applicationDetails = appDetails;
        _timberLogData = timberLog;
        _speciesLocationData = speciesLocation;
        _imageDocuments = imageDocuments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load application data: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
          child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }

    if (_applicationDetails == null) {
      return const Center(child: Text('No application details found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildApplicationDetailsSection(),
          const SizedBox(height: 20),
          if (_timberLogData != null) _buildTimberLogSection(),
          const SizedBox(height: 20),
          if (_speciesLocationData != null) _buildSpeciesLocationSection(),
          const SizedBox(height: 20),
          if (_imageDocuments != null) _buildImageDocumentsSection(),
        ],
      ),
    );
  }

  Widget _buildApplicationDetailsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Application Details',
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildDetailItem('Application ID',
                _applicationDetails!['app_id']?.toString() ?? 'N/A'),
            _buildDetailItem('Application Type',
                _applicationDetails!['app_type']?.toString() ?? 'N/A'),
            _buildDetailItem('Applicant Name',
                _applicationDetails!['applicant_name']?.toString() ?? 'N/A'),
            _buildDetailItem(
                'Status', _applicationDetails!['status']?.toString() ?? 'N/A'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }

  Widget _buildTimberLogSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Timber Log Details',
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _timberLogData!.length,
              itemBuilder: (context, index) {
                final log = _timberLogData![index];
                return ListTile(
                  title: Text('Species: ${log['species_name'] ?? 'N/A'}'),
                  subtitle: Text(
                      'Quantity: ${log['quantity'] ?? 'N/A'} | Volume: ${log['volume'] ?? 'N/A'}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeciesLocationSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Species Location',
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _speciesLocationData!.length,
              itemBuilder: (context, index) {
                final location = _speciesLocationData![index];
                return ListTile(
                  title:
                      Text('Location: ${location['location_name'] ?? 'N/A'}'),
                  subtitle: Text(
                      'Coordinates: ${location['latitude'] ?? 'N/A'}, ${location['longitude'] ?? 'N/A'}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageDocumentsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Documents & Images',
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _imageDocuments!.length,
              itemBuilder: (context, index) {
                final document = _imageDocuments![index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: document['image_url'] != null
                            ? Image.network(
                                document['image_url'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (ctx, error, _) => const Center(
                                  child: Icon(Icons.broken_image, size: 50),
                                ),
                              )
                            : const Center(
                                child: Icon(Icons.insert_drive_file, size: 50)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          document['document_name'] ?? 'Document',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
