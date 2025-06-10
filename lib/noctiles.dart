import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/Nocfreshlist.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/deputyfileupload.dart';
import 'package:tigramnks/nocapprovedrejectedlist.dart';
import 'package:tigramnks/nocforwardedlist.dart';
import 'package:tigramnks/nocpendingwithmelist.dart';

class NocApplictaionTiles extends StatefulWidget {
  final String sessionToken;

  const NocApplictaionTiles({
    super.key,
    required this.sessionToken,
  });

  @override
  State<NocApplictaionTiles> createState() => _NocApplictaionTilesState();
}

class _NocApplictaionTilesState extends State<NocApplictaionTiles> {
  late String _sessionToken;

  @override
  void initState() {
    super.initState();
    _sessionToken = widget.sessionToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'NOC Applications',
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
        shadowColor: Colors.blue[700]!.withOpacity(0.3),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          // IconButton(
          //   icon: const Icon(Icons.refresh_rounded),
          //   onPressed: () {
          //     // // Add refresh functionality here
          //     // ScaffoldMessenger.of(context).showSnackBar(
          //     //   const SnackBar(
          //     //     content: Text('Refreshing applications...'),
          //     //     duration: Duration(seconds: 2),
          //     //   ),
          //     // );
          //   },
          //   tooltip: 'Refresh',
          // ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Deputyfileupload(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.only(bottom: 24.0),
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
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[700]!.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Icon(
                          Icons.description_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Application Dashboard',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Manage your NOC applications efficiently',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Application tiles section
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 1.1,
                    children: [
                      _buildTile(
                        title: 'Fresh Applications',
                        subtitle: 'New submissions',
                        icon: Icons.add_circle_rounded,
                        color: Colors.green[600]!,
                        onTap: () {
                          context.read<MainBloc>().add(NocFreshApplicationList(
                              sessionToken: _sessionToken));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NocFreshListTable(
                                sessionToken: _sessionToken,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildTile(
                        title: 'Pending With Me',
                        subtitle: 'Awaiting action',
                        icon: Icons.hourglass_empty_rounded,
                        color: Colors.orange[600]!,
                        onTap: () {
                          context.read<MainBloc>().add(
                              NocPendingApplicationList(
                                  sessionToken: _sessionToken));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NocPendingListTable(
                                sessionToken: _sessionToken,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildTile(
                        title: 'Forwarded Files',
                        subtitle: 'Sent to others',
                        icon: Icons.forward_rounded,
                        color: Colors.blue[600]!,
                        onTap: () {
                          context.read<MainBloc>().add(
                              NocForwardedList(sessionToken: _sessionToken));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NocForwardedListTable(),
                            ),
                          );
                        },
                      ),
                      _buildTile(
                        title: 'Approved/Rejected',
                        subtitle: 'Final decisions',
                        icon: Icons.rule_rounded,
                        color: const Color(0xFF8E24AA)!,
                        onTap: () {
                          context.read<MainBloc>().add(NocApprovedRejectedList(
                              sessionToken: _sessionToken));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NocApprovedRejectedListTable(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  icon,
                  size: 24.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  color: Colors.grey[800],
                ),
              ),
              // const SizedBox(height: 4.0),
              // Text(
              //   subtitle,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontWeight: FontWeight.w400,
              //     fontSize: 11.0,
              //     color: Colors.grey[600],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
