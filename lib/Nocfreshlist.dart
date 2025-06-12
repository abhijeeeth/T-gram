import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/Initializer.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/deputyfileupload.dart';
import 'package:tigramnks/nocview.dart';

class NocFreshListTable extends StatelessWidget {
  final String sessionToken;
  const NocFreshListTable({super.key, required this.sessionToken});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is NOClistfreshFailed) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: const Row(
          //       children: [
          //         Icon(Icons.error_outline, color: Colors.white),
          //         SizedBox(width: 8),
          //         Text('Failed to load NOC applications'),
          //       ],
          //     ),
          //     backgroundColor: Colors.red.shade600,
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            title: const Text(
              'NOC Applications',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 28, 110, 99),
                    Color.fromARGB(207, 28, 110, 99),
                    Color.fromARGB(195, 105, 138, 132),
                  ],
                ),
              ),
            ),
            elevation: 4,
            shadowColor:
                const Color.fromARGB(255, 28, 110, 99).withOpacity(0.4),
            actions: const [
              // IconButton(
              //   icon: const Icon(Icons.refresh, color: Colors.white),
              //   onPressed: () {
              //     context.read<MainBloc>().add(
              //           NocListfresh(sessionToken: sessionToken),
              //         );
              //   },
              // ),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, MainState state) {
    if (state is NocFreshLIstloading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 28, 110, 99),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Loading applications...',
              style: TextStyle(
                color: Color.fromARGB(255, 28, 110, 99),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    final pendingList =
        Initializer.nocFreshapplicationModel.data?.pendingList ?? [];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade50,
            Colors.white,
          ],
        ),
      ),
      child: pendingList.isEmpty
          ? _buildEmptyState()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(pendingList.length),
                Expanded(
                  child: _buildTable(pendingList, context),
                ),
              ],
            ),
    );
  }

  Widget _buildHeader(int count) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fresh Applications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count pending applications',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.pending_actions,
                  size: 16,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  'Pending: $count',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Applications Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no fresh NOC applications to display',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List pendingList, BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 28, 110, 99).withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 800),
            child: Theme(
              data: Theme.of(context).copyWith(
                dataTableTheme: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 28, 110, 99).withOpacity(0.1),
                  ),
                  dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return const Color.fromARGB(255, 28, 110, 99)
                            .withOpacity(0.05);
                      }
                      return null;
                    },
                  ),
                ),
              ),
              child: DataTable(
                headingRowHeight: 60,
                dataRowMinHeight: 68,
                dataRowMaxHeight: 76,
                columnSpacing: 28,
                horizontalMargin: 24,
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color.fromARGB(255, 28, 110, 99),
                ),
                dataTextStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
                columns: const [
                  DataColumn(label: Text('S.No'), numeric: true),
                  DataColumn(label: Text('Application ID')),
                  DataColumn(label: Text('Applicant Name')),
                  DataColumn(label: Text('Created Date')),
                  DataColumn(label: Text('Purpose')),
                  DataColumn(label: Text('Action')),
                ],
                rows: List.generate(pendingList.length, (index) {
                  final item = pendingList[index];
                  return DataRow(
                    cells: [
                      DataCell(_buildIndexCell(index)),
                      DataCell(_buildApplicationIdCell(item)),
                      DataCell(_buildNameCell(item)),
                      DataCell(_buildDateCell(item)),
                      DataCell(_buildPurposeCell(item)),
                      DataCell(
                          Initializer.nocFreshapplicationModel.data?.group ==
                                  'forest range officer'
                              ? _buildActionCellforRFO(item, context)
                              : _buildActionCell(item, context)),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndexCell(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 28, 110, 99).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${index + 1}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 28, 110, 99),
        ),
      ),
    );
  }

  Widget _buildApplicationIdCell(dynamic item) {
    return Text(
      item.nocApplicationIdNocOfLandApplicationId?.toString() ?? '-',
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 28, 110, 99),
      ),
    );
  }

  Widget _buildNameCell(dynamic item) {
    return Text(
      item.nocApplicationIdName ?? '-',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateCell(dynamic item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 28, 110, 99).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _formatDate(item.nocApplicationIdNocCreatedAt) ?? '-',
        style: const TextStyle(
          color: Color.fromARGB(255, 28, 110, 99),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPurposeCell(dynamic item) {
    return Text(
      item.nocApplicationIdPurpose ?? '-',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildActionCellforRFO(dynamic item, BuildContext context) {
    return item.siteInception == true &&
            item.rfoSiteInception == true &&
            item.siteInceptionRfo == false
        ? ElevatedButton.icon(
            onPressed: () {
              context.read<MainBloc>().add(NocListIndividualView(
                  download: false,
                  sessionToken: sessionToken,
                  Ids: item.id.toString() ?? ""));
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => NOCView(
                          sessionToken: sessionToken,
                          Ids: item.id.toString() ?? "",
                        )),
              );
            },
            icon: const Icon(Icons.visibility, size: 18),
            label: const Text('View Details'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 28, 110, 99),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Text(
              'Site Inspected',
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          );
  }

  Widget _buildActionCell(dynamic item, BuildContext context) {
    return item.siteInception == true
        ? ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Deputyfileupload(
                    ids: item.id.toString() ?? "",
                  ),
                ),
              );
            },
            icon: const Icon(Icons.visibility, size: 18),
            label: const Text('Upload Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 28, 110, 99),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          )
        : ElevatedButton.icon(
            onPressed: () {
              context.read<MainBloc>().add(NocListIndividualView(
                  download: false,
                  sessionToken: sessionToken,
                  Ids: item.id.toString() ?? ""));
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => NOCView(
                          sessionToken: sessionToken,
                          Ids: item.id.toString() ?? "",
                        )),
              );
            },
            icon: const Icon(Icons.visibility, size: 18),
            label: const Text('View Details'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 28, 110, 99),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          );
  }

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    try {
      // Parse the date string
      final DateTime date = DateTime.parse(dateString);

      // Format date as "01 June 2025, 4.30 AM"
      final String day = date.day.toString().padLeft(2, '0');

      final List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      final String month = months[date.month - 1];

      final int hour =
          date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
      final String minute = date.minute.toString().padLeft(2, '0');
      final String period = date.hour >= 12 ? 'PM' : 'AM';

      return '$day $month ${date.year}, $hour.$minute $period';
    } catch (e) {
      return dateString;
    }
  }
}
