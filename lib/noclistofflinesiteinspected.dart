import 'package:flutter/material.dart';

import 'sqflite/dbhelper.dart'; // Import your DbHelper

class Noclistofflinesiteinspected extends StatefulWidget {
  const Noclistofflinesiteinspected({super.key});

  @override
  State<Noclistofflinesiteinspected> createState() =>
      _NoclistofflinesiteinspectedState();
}

class _NoclistofflinesiteinspectedState
    extends State<Noclistofflinesiteinspected> {
  List<Map<String, dynamic>> _locationImages = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocationImages();
  }

  Future<void> _fetchLocationImages() async {
    final dbHelper = DbHelper();
    final images = await dbHelper.getAllApplicationLocationImages();
    setState(() {
      _locationImages = images;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_locationImages.isEmpty) {
      return const Center(child: Text('No location images found.'));
    }
    return ListView.builder(
      itemCount: _locationImages.length,
      itemBuilder: (context, index) {
        final item = _locationImages[index];
        return ListTile(
          title: Text('ID: ${item['id']}'),
          subtitle: Text('App ID: ${item['app_id'] ?? ''}'),
          // Add more fields as needed
        );
      },
    );
  }
}
