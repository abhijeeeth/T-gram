import 'package:flutter/material.dart';
import 'package:tigramnks/screens/application_details_page.dart';
import 'package:tigramnks/sqflite/dbhelper.dart';

class ApplicationsListPage extends StatefulWidget {
  const ApplicationsListPage({super.key});

  @override
  _ApplicationsListPageState createState() => _ApplicationsListPageState();
}

class _ApplicationsListPageState extends State<ApplicationsListPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _applications = [];
  String? _error;
  final DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    _loadApplications();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadApplications,
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

    if (_error != null) {
      return Center(
          child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }

    if (_applications.isEmpty) {
      return const Center(child: Text('No applications found'));
    }

    return RefreshIndicator(
      onRefresh: _loadApplications,
      child: ListView.builder(
        itemCount: _applications.length,
        itemBuilder: (context, index) {
          final application = _applications[index];
          final status = application['application_status'] ?? 'Pending';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(
                application['name'] ?? 'Unknown Applicant',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                      'Application ID: ${application['application_no'] ?? 'N/A'}'),
                  Text('Village: ${application['village'] ?? 'N/A'}'),
                  Text('Created: ${application['created_date'] ?? 'N/A'}'),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios),
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
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
      case 'disapproved':
        return Colors.red;
      case 'verified':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
