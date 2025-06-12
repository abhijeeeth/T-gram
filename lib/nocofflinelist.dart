import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline NOC Applications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: _refreshList,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
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
              ));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: nocApps.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final app = nocApps[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.assignment, color: Colors.blue),
                    ),
                    title: Text(
                      app['name'] ?? 'No Name',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Division: ${app['division'] ?? '-'}'),
                          Text('Village: ${app['village'] ?? '-'}'),
                        ],
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.badge, color: Colors.grey, size: 20),
                        Text(
                          'ID: ${app['id']}',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Optionally navigate to details page
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(app['name'] ?? 'No Name'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Division: ${app['division'] ?? '-'}'),
                              Text('Village: ${app['village'] ?? '-'}'),
                              Text('ID: ${app['id']}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
