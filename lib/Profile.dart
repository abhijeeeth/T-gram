import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tigramnks/server/serverhelper.dart';

class Profile extends StatefulWidget {
  final String sessionToken;
  final String userName;
  final String userEmail;
  final String userMobile;
  final String userAddress;
  final String userProfile;

  const Profile({
    super.key,
    required this.sessionToken,
    required this.userName,
    required this.userEmail,
    required this.userMobile,
    required this.userAddress,
    required this.userProfile,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String Vphone = '';
  String Vemail = '';
  String Vname = '';
  String Vaddress = '';
  String pic_url = '';

  @override
  void initState() {
    super.initState();
    viewProfile();
  }

  viewProfile() async {
    const String url = '${ServerHelper.baseUrl}auth/ViewProfile';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "token ${widget.sessionToken}"
    });
    Map<String, dynamic> responseJSON = json.decode(response.body);
    setState(() {
      Vphone = responseJSON['user']['phone'];
      Vemail = responseJSON['user']['email'];
      Vname = responseJSON['user']['name'];
      Vaddress = responseJSON['user']['address'];
      pic_url = responseJSON['user']['pic_url'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0.2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  // backgroundImage:
                  //     pic_url.isNotEmpty ? NetworkImage(pic_url) : null,
                  radius: 50.0,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.grey,
                  )),
              const SizedBox(height: 16),
              Text(
                Vname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                Vemail,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Divider(height: 32, thickness: 1),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: Text(Vphone),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.blue),
                title: Text(Vaddress),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
