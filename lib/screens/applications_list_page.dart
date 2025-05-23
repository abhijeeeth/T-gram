import 'package:flutter/material.dart';
import 'package:tigramnks/screens/application_details_page.dart';
import 'package:tigramnks/sqflite/dbhelper.dart';

// Define a consistent color scheme
class AppColors {
  static const Color primary = Color.fromARGB(255, 28, 110, 99);
  static const Color primaryLight = Color.fromARGB(255, 60, 150, 136);
  static const Color primaryDark = Color.fromARGB(255, 18, 80, 72);
  static const Color accent = Color.fromARGB(255, 255, 152, 0);
  static const Color background = Color.fromARGB(255, 245, 250, 248);
  static const Color cardBg = Colors.white;
  static const Color textPrimary = Color.fromARGB(255, 50, 50, 50);
  static const Color textSecondary = Color.fromARGB(255, 100, 100, 100);
}

class ApplicationsListPage extends StatefulWidget {
  const ApplicationsListPage({super.key});

  @override
  _ApplicationsListPageState createState() => _ApplicationsListPageState();
}

class _ApplicationsListPageState extends State<ApplicationsListPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  List<Map<String, dynamic>> _applications = [];
  String? _error;
  final DbHelper _dbHelper = DbHelper();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadApplications();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadApplications() async {
    try {
      final applications = await _dbHelper.getApplications();
      setState(() {
        _applications = applications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load applications: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _showDatabaseInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final stats = await _dbHelper.getDatabaseStats();
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.storage, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Database Information',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Database Path:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      Text('${stats['dbPath']}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tables (${stats['tables']})',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      const SizedBox(height: 8),
                      ...((stats['tableNames'] as List).map((table) => Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$table:',
                                    style: const TextStyle(
                                        color: AppColors.textPrimary)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${stats['counts'][table]} records',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete_forever, color: Colors.white),
                    label: const Text('Delete All Data',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            title: const Row(
                              children: [
                                Icon(Icons.warning, color: Colors.red),
                                SizedBox(width: 8),
                                Text(
                                  'Confirm Deletion',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            content: const Text(
                                'Are you sure you want to delete ALL data? This action cannot be undone.'),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  // Close both dialogs first
                                  Navigator.of(context)
                                      .pop(); // Close confirmation dialog
                                  Navigator.of(context)
                                      .pop(); // Close database info dialog

                                  setState(() {
                                    _isLoading = true;
                                  });

                                  try {
                                    await _dbHelper.resetDatabase();

                                    setState(() {
                                      _isLoading = false;
                                    });

                                    // Just refresh the list without showing any SnackBar
                                    _loadApplications();
                                  } catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                      _error = "Failed to reset database: $e";
                                    });
                                  }
                                },
                                child: const Text(
                                  'Delete Everything',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.close),
              label: const Text('Close'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Failed to get database information: $e";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_error ?? "Error fetching database information"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text(
          'Field Verification List',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            tooltip: 'Database Info',
            onPressed: _showDatabaseInfo,
          ),
          IconButton(
            icon: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 6.28,
                  child: const Icon(Icons.refresh, color: Colors.white),
                );
              },
            ),
            tooltip: 'Refresh',
            onPressed: () {
              _animationController.forward(from: 0);
              _loadApplications();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16),
            Text(
              'Loading applications...',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: _loadApplications,
            ),
          ],
        ),
      );
    }

    if (_applications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, color: AppColors.primary, size: 64),
            const SizedBox(height: 16),
            const Text(
              'No applications found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sync your device to download applications',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _loadApplications,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: Colors.white,
      onRefresh: _loadApplications,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: _applications.length,
          itemBuilder: (context, index) {
            final application = _applications[index];
            final status = application['application_status'] ?? 'Pending';
            final statusColor = _getStatusColor(status);

            return Card(
              elevation: 3,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      AppColors.background.withOpacity(0.3),
                    ],
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationDetailsPage(
                          applicationId: application['id'].toString(),
                        ),
                      ),
                    ).then((_) => _loadApplications());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                application['name'] ?? 'Unknown Applicant',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: statusColor.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 24,
                          thickness: 1,
                          color: Colors.grey.shade200,
                        ),
                        _buildInfoRow(Icons.numbers,
                            'Application ID: ${application['application_no'] ?? 'N/A'}'),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.location_on,
                            'Village: ${application['village'] ?? 'N/A'}'),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.calendar_today,
                            'Created: ${application['created_date'] ?? 'N/A'}'),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View Details',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF2E7D32); // Deeper green
      case 'pending':
        return AppColors.accent; // Orange accent color
      case 'rejected':
      case 'disapproved':
        return const Color(0xFFC62828); // Deeper red
      case 'verified':
        return const Color(0xFF1565C0); // Deeper blue
      default:
        return const Color(0xFF607D8B); // Blue grey
    }
  }
}
