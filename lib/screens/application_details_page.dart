import 'package:flutter/material.dart';
import 'package:tigramnks/sqflite/dbhelper.dart'; // Add DbHelper import

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
  final DbHelper _dbHelper = DbHelper(); // Create instance of DbHelper

  @override
  void initState() {
    super.initState();
    _loadApplicationData();
  }

  Future<void> _loadApplicationData() async {
    try {
      // Convert string ID to integer for database queries
      final int appId = int.parse(widget.applicationId);

      // Get complete application data from database
      final completeData = await _dbHelper.getCompleteApplicationData(appId);

      if (completeData['status'] == 'Success') {
        final data = completeData['data'];

        setState(() {
          // Application details is the first item in the applications array
          _applicationDetails = data['applications'][0];

          // Store raw data for reference
          _applicationData = data;

          // Get timber logs
          _timberLogData = data['timber_log'];

          // Get image documents
          _imageDocuments = data['image_documents'];

          // For species location, we can use timber logs as they have location data
          _speciesLocationData = data['timber_log'];

          _isLoading = false;
        });
      } else {
        setState(() {
          _error =
              "Failed to load application data: ${completeData['message']}";
          _isLoading = false;
        });
      }
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
                _applicationDetails!['id']?.toString() ?? 'N/A'),
            _buildDetailItem('Application No',
                _applicationDetails!['application_no']?.toString() ?? 'N/A'),
            _buildDetailItem('Applicant Name',
                _applicationDetails!['name']?.toString() ?? 'N/A'),
            _buildDetailItem(
                'Status',
                _applicationDetails!['application_status']?.toString() ??
                    'N/A'),
            _buildDetailItem('Address',
                _applicationDetails!['address']?.toString() ?? 'N/A'),
            _buildDetailItem('District',
                _applicationDetails!['district']?.toString() ?? 'N/A'),
            _buildDetailItem('Village',
                _applicationDetails!['village']?.toString() ?? 'N/A'),
            _buildDetailItem('Survey No',
                _applicationDetails!['survey_no']?.toString() ?? 'N/A'),
            _buildDetailItem('Purpose',
                _applicationDetails!['purpose']?.toString() ?? 'N/A'),
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
                  title: Text('Species: ${log['species_of_tree'] ?? 'N/A'}'),
                  subtitle: Text(
                      'Volume: ${log['volume'] ?? 'N/A'} | Dimensions: ${log['length'] ?? 'N/A'} x ${log['breadth'] ?? 'N/A'}'),
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
                      Text('Species: ${location['species_of_tree'] ?? 'N/A'}'),
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
                // Find first non-null image in the document
                String? imageUrl;
                for (var key in document.keys) {
                  if ((key.contains('img') ||
                          key.contains('detail') ||
                          key.contains('application') ||
                          key.contains('sktech') ||
                          key.contains('approval')) &&
                      document[key] != null &&
                      document[key].toString().isNotEmpty) {
                    imageUrl = document[key];
                    break;
                  }
                }

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: imageUrl != null
                            ? Image.network(
                                imageUrl,
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
                          'Document ${index + 1}',
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
