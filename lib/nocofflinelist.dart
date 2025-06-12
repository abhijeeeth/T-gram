import 'package:flutter/material.dart';
import 'package:tigramnks/nocofflinesiteinspection.dart';

import 'sqflite/dbhelper.dart';

class Nocofflinelist extends StatefulWidget {
  const Nocofflinelist({super.key});

  @override
  State<Nocofflinelist> createState() => _NocofflinelistState();
}

class _NocofflinelistState extends State<Nocofflinelist> {
  late Future<List<Map<String, dynamic>>> _nocApplicationsFuture;

  @override
  void initState() {
    super.initState();
    _nocApplicationsFuture = DbHelper().getNocApplications();
  }

  void _refreshList() {
    setState(() {
      _nocApplicationsFuture = DbHelper().getNocApplications();
    });
  }

  void _clearAllData() async {
    await DbHelper().deleteAllNocApplications();
    _refreshList();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All offline NOC applications cleared.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Offline NOC Applications',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 28, 110, 99),
                Color.fromARGB(207, 28, 110, 99),
                Color.fromARGB(195, 105, 138, 132)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: _refreshList,
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _nocApplicationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final nocApps = snapshot.data ?? [];
            if (nocApps.isEmpty) {
              return const Center(
                child: Text(
                  'No offline NOC applications found.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: nocApps.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final app = nocApps[index];
                return Card(
                  elevation: 3,
                  shadowColor: Colors.blue[700]?.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Nocofflinesiteinspection(
                                    appId: app['id'].toString(),
                                  )));
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     title: Text(app['name'] ?? 'No Name'),
                      //     content: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text('Division: ${app['division'] ?? '-'}'),
                      //         Text('Village: ${app['village'] ?? '-'}'),
                      //         Text('ID: ${app['id']}'),
                      //       ],
                      //     ),
                      //     actions: [
                      //       TextButton(
                      //         onPressed: () => Navigator.pop(context),
                      //         child: const Text('Close'),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey[50]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Icon(Icons.assignment,
                                color: Colors.blue, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  app['name'] ?? 'No Name',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text('Division: ${app['division'] ?? '-'}',
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black87)),
                                Text('Village: ${app['village'] ?? '-'}',
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.badge,
                                  color: Colors.grey, size: 20),
                              Text(
                                'ID: ${app['id']}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Clear All Data'),
              content: const Text(
                  'Are you sure you want to delete all offline NOC applications? This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Delete All'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            _clearAllData();
          }
        },
        backgroundColor: const Color.fromARGB(255, 28, 110, 99),
        tooltip: 'Clear All Data From Offline List',
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
