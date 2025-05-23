import 'package:flutter/material.dart';
import 'package:tigramnks/sqflite/dbhelper.dart';

// Define theme colors
class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 28, 110, 99);
  static const Color accentColor = Color.fromARGB(255, 223, 242, 239);
  static const Color textDarkColor = Color.fromARGB(255, 51, 51, 51);
  static const Color cardBgColor = Colors.white;
}

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
  final DbHelper _dbHelper = DbHelper();

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
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Application Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey[100],
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _loadApplicationData();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_applicationDetails == null) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_off,
              color: Colors.grey,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              'No application details found',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusBanner(),
          const SizedBox(height: 16),
          _buildApplicationDetailsSection(),
          const SizedBox(height: 20),
          if (_timberLogData != null && _timberLogData!.isNotEmpty)
            _buildTimberLogSection(),
          const SizedBox(height: 20),
          if (_speciesLocationData != null && _speciesLocationData!.isNotEmpty)
            _buildSpeciesLocationSection(),
          const SizedBox(height: 20),
          if (_imageDocuments != null && _imageDocuments!.isNotEmpty)
            _buildImageDocumentsSection(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    final status =
        _applicationDetails!['application_status']?.toString() ?? 'Pending';
    Color statusColor;
    IconData statusIcon;

    // Assign colors and icons based on status
    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      default:
        statusColor = const Color.fromARGB(255, 28, 110, 99);
        statusIcon = Icons.info;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.scanner, color: statusColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Application Status: $status',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: statusColor,
                //   ),
                // ),
                Text(
                  'Application ID: ${_applicationDetails!['application_no'] ?? _applicationDetails!['id'] ?? 'N/A'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationDetailsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Applicant Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: AppColors.accentColor, thickness: 1.5),
            _buildDetailItem(
              'Name',
              _applicationDetails!['name']?.toString() ?? 'N/A',
              Icons.person_outline,
            ),
            _buildDetailItem(
              'Address',
              _applicationDetails!['address']?.toString() ?? 'N/A',
              Icons.location_on_outlined,
            ),
            _buildDetailItem(
              'District',
              _applicationDetails!['district']?.toString() ?? 'N/A',
              Icons.business,
            ),
            _buildDetailItem(
              'Village',
              _applicationDetails!['village']?.toString() ?? 'N/A',
              Icons.home_work_outlined,
            ),
            _buildDetailItem(
              'Survey No',
              _applicationDetails!['survey_no']?.toString() ?? 'N/A',
              Icons.map_outlined,
            ),
            _buildDetailItem(
              'Purpose',
              _applicationDetails!['purpose']?.toString() ?? 'N/A',
              Icons.assignment_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimberLogSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.nature, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Timber Log Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: AppColors.accentColor, thickness: 1.5),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _timberLogData!.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final log = _timberLogData![index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${log['species_of_tree'] ?? 'Unknown Species'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Volume: ${log['volume'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Dimensions: L:${log['length'] ?? 'N/A'} × B:${log['breadth'] ?? 'N/A'} × H:${log['height'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
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

  Widget _buildSpeciesLocationSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Species Location',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: AppColors.accentColor, thickness: 1.5),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _speciesLocationData!.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final location = _speciesLocationData![index];
                final hasCoordinates = location['latitude'] != null &&
                    location['longitude'] != null &&
                    location['latitude'].toString().isNotEmpty &&
                    location['longitude'].toString().isNotEmpty;

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.pin_drop,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${location['species_of_tree'] ?? 'Unknown Species'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (hasCoordinates)
                              Row(
                                children: [
                                  const Icon(Icons.my_location,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'Lat: ${location['latitude']}, Long: ${location['longitude']}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            if (!hasCoordinates)
                              const Text(
                                'Location coordinates not available',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (hasCoordinates)
                        IconButton(
                          icon: const Icon(
                            Icons.map,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            // TODO: Open map with these coordinates
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Map view not implemented yet'),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          },
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

  Widget _buildImageDocumentsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.image, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Documents & Images',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: AppColors.accentColor, thickness: 1.5),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: _imageDocuments!.length,
              itemBuilder: (context, index) {
                final document = _imageDocuments![index];
                // Find first non-null image in the document
                String? imageUrl;
                String? documentType;

                for (var key in document.keys) {
                  if ((key.contains('img') ||
                          key.contains('detail') ||
                          key.contains('application') ||
                          key.contains('sktech') ||
                          key.contains('approval')) &&
                      document[key] != null &&
                      document[key].toString().isNotEmpty) {
                    imageUrl = document[key];
                    documentType = key.split('_').join(' ').toUpperCase();
                    break;
                  }
                }

                return GestureDetector(
                  onTap: () {
                    // if (imageUrl != null) {
                    //   // TODO: Show full-screen image viewer
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text('Viewing $documentType'),
                    //       backgroundColor: AppColors.primaryColor,
                    //     ),
                    //   );
                    // }
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: imageUrl != null
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                          Color>(
                                                      AppColors.primaryColor),
                                            ),
                                          );
                                        },
                                        errorBuilder: (ctx, error, _) =>
                                            const Center(
                                          child: Icon(Icons.broken_image,
                                              size: 50, color: Colors.grey),
                                        ),
                                      ),
                                      // Positioned(
                                      //   right: 5,
                                      //   top: 5,
                                      //   child: Container(
                                      //     padding: const EdgeInsets.all(4),
                                      //     decoration: const BoxDecoration(
                                      //       color: AppColors.primaryColor,
                                      //       shape: BoxShape.circle,
                                      //     ),
                                      //     child: const Icon(
                                      //       Icons.zoom_in,
                                      //       color: Colors.white,
                                      //       size: 16,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.insert_drive_file,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                          ),
                          child: Text(
                            documentType ?? 'Document ${index + 1}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textDarkColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textDarkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
