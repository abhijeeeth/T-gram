import 'package:flutter/material.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              children: [
                _buildTile(
                  title: 'Fresh Application',
                  icon: Icons.add_circle_rounded,
                  color: Colors.green[600]!,
                  onTap: () {
                    // Handle fresh application tap
                  },
                ),
                _buildTile(
                  title: 'Pending With Me',
                  icon: Icons.hourglass_empty_rounded,
                  color: Colors.orange[600]!,
                  onTap: () {
                    // Handle pending with me tap
                  },
                ),
                _buildTile(
                  title: 'Forwarded Files',
                  icon: Icons.forward_rounded,
                  color: Colors.blue[600]!,
                  onTap: () {
                    // Handle forwarded files tap
                  },
                ),
                _buildTile(
                  title: 'Approved/Rejected',
                  icon: Icons.rule_rounded,
                  color: Colors.purple[600]!,
                  onTap: () {
                    // Handle approved/rejected tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  icon,
                  size: 25.0,
                  color: color,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
