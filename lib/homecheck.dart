import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:tigramnks/PendingApplicationsPage.dart';
import 'package:tigramnks/QueryPage.dart';
import 'package:tigramnks/Reports.dart';
import 'package:tigramnks/login.dart';
import 'package:tigramnks/noctiles.dart';
import 'package:tigramnks/pages/application_locations_list_page.dart';
import 'package:tigramnks/screens/applications_list_page.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:tigramnks/utils/local_storage.dart';

class Homecheck extends StatefulWidget {
  String sessionToken;
  int userId;
  String userName;
  String userEmail;
  String userGroup;
  String dropdownValue;
  String? userMobile;
  String? userAddress;
  List Range;
  Homecheck(
      {super.key,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.sessionToken,
      required this.userGroup,
      required this.dropdownValue,
      this.userMobile,
      this.userAddress,
      required this.Range});

  @override
  State<Homecheck> createState() => _HomecheckState();
}

class _HomecheckState extends State<Homecheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Container(
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 28, 110, 99),
                      Color.fromARGB(207, 28, 110, 99),
                      Color.fromARGB(195, 105, 138, 132)
                    ],
                  )),
                  accountEmail: Text(widget.userEmail),
                  accountName: Text(widget.userName),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      widget.userName[0].toUpperCase(),
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
                ListTile(
                    leading: const Icon(
                      Icons.receipt_long_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: const Text(
                      'Reports',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  Reports(sessionToken: widget.sessionToken)));
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.dashboard,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: const Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OfficerDashboard(
                                    sessionToken: widget.sessionToken,
                                    userName: widget.userName,
                                    userEmail: widget.userEmail,
                                    userGroup: widget.userGroup,
                                    userId: widget.userId,
                                    dropdownValue: widget.dropdownValue,
                                    Range: widget.Range,
                                    userMobile: widget.userMobile,
                                    userAddress: widget.userAddress,
                                  )));
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: const Text(
                      'QR-Scanner',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => QueryPage(
                                    userId: widget.userId,
                                    sessionToken: widget.sessionToken,
                                    userName: widget.userName,
                                    userEmail: widget.userEmail,
                                    userMobile:
                                        widget.userMobile ?? "987654312",
                                    userAddress:
                                        widget.userAddress ?? "Address",
                                  )));
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.offline_share,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: const Text(
                      'Download Field Verification',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PendingApplicationsPage(
                                    sessionToken: widget.sessionToken,
                                    Range: widget.Range,
                                    userEmail: widget.userEmail,
                                    userGroup: widget.userGroup,
                                    userId: widget.userId,
                                    userName: widget.userName,
                                  )));
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.offline_share,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: const Text(
                      'Downloaded List',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ApplicationsListPage(
                                  // sessionToken: sessionToken,
                                  // Range: Range,
                                  // userEmail: userEmail,
                                  // userGroup: userGroup,
                                  // userId: userId,
                                  // userName: userName,
                                  )));
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.offline_share,
                      color: Colors.black,
                      size: 25,
                    ),
                    title: const Text(
                      ' List',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ApplicationLocationsListPage()),
                      );
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 25,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onTap: () async {
                    // Show logout confirmation dialog
                    bool confirmLogout = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop(
                                      false); // Close the dialog without logging out
                                  await LocalStorage.removeToken();
                                  await LocalStorage.removeUserGroup();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("Logout"),
                              ),
                            ],
                          ),
                        ) ??
                        false;

                    if (confirmLogout) {
                      // Replace the drawer with a loading indicator
                      Navigator.pop(context); // Close the drawer

                      // Show loading dialog
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: Dialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text('Logging out...',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      try {
                        // Perform logout
                        const String url =
                            '${ServerHelper.baseUrl}auth/logout/';
                        await http.post(
                          Uri.parse(url),
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                            'Authorization': "token $widget.sessionToken"
                          },
                        );

                        // Clear local storage
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.remove('isLoggedIn');
                        await LocalStorage.removeToken();
                        await LocalStorage.removeUserGroup();

                        // Navigate to login screen
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // Dismiss the loading dialog
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const login()));
                      } catch (e) {
                        // Handle errors
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // Dismiss the loading dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Logout failed: ${e.toString()}')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 110, 99),
        foregroundColor: Colors.white,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Welcome, ${widget.userName}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              child: Lottie.asset(
                'assets/tree.json',
                fit: BoxFit.contain,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OfficerDashboard(
                          userId: widget.userId,
                          userName: widget.userName,
                          userEmail: widget.userEmail,
                          sessionToken: widget.sessionToken,
                          userGroup: widget.userGroup,
                          dropdownValue: '',
                          Range: widget.Range,
                          userMobile: widget.userMobile,
                          userAddress: widget.userAddress)),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height / 12,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 28, 110, 99),
                      Color.fromARGB(207, 28, 110, 99),
                      Color.fromARGB(195, 105, 138, 132)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/check_status.png',
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Cutting Pass',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NocApplictaionTiles(
                            sessionToken: widget.sessionToken,
                          )),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height / 12,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 28, 110, 89),
                      Color.fromARGB(207, 28, 110, 89),
                      Color.fromARGB(195, 105, 138, 122)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/check_status.png',
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'NOC For Land',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
