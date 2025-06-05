import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tigramnks/OfficerDashboard.dart';
import 'package:tigramnks/noctiles.dart';

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
      appBar: AppBar(
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
