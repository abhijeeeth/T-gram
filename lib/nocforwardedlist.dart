import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigramnks/Initializer.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/model/nocforwardedlistmodel.dart';

class NocForwardedListTable extends StatelessWidget {
  const NocForwardedListTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is NOClistForwardedFailed) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: const Row(
          //       children: [
          //         Icon(Icons.error_outline, color: Colors.white),
          //         SizedBox(width: 8),
          //         Text('Failed to load NOC forwarded applications'),
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
            title: const Text(
              'NOC Applications - Forwarded',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 2,
            actions: const [
              // IconButton(
              //   icon: const Icon(Icons.refresh),
              //   onPressed: () {
              //     context.read<MainBloc>().add(const NOCForwardedListEvent());
              //   },
              // ),
              SizedBox(width: 8),
            ],
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, MainState state) {
    if (state is NocForwardedLIstloading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16),
            Text(
              'Loading forwarded applications...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    final forwardedList =
        Initializer.nocForwardedListModel.data?.forwardedList ?? [];

    if (forwardedList.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(forwardedList.length),
        Expanded(
          child: _buildTable(forwardedList),
        ),
      ],
    );
  }

  Widget _buildHeader(int count) {
    final areaRangeName =
        Initializer.nocForwardedListModel.data?.areaRangeName ?? '';
    final group = Initializer.nocForwardedListModel.data?.group ?? '';

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forwarded Applications',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$count applications forwarded',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.forward_outlined,
                      size: 16,
                      color: Colors.orange.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$count',
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (areaRangeName.isNotEmpty || group.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (areaRangeName.isNotEmpty) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Area: $areaRangeName',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                if (group.isNotEmpty) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Group: $group',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
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
            Icons.forward_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Forwarded Applications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no forwarded NOC applications to display',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List<ForwardedList> forwardedList) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 800),
            child: DataTable(
              headingRowHeight: 56,
              dataRowMinHeight: 64,
              dataRowMaxHeight: 72,
              columnSpacing: 24,
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
              dataTextStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
              headingRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.grey.shade50,
              ),
              columns: const [
                DataColumn(
                  label: Text('S.No'),
                  numeric: true,
                ),
                DataColumn(label: Text('Application ID')),
                DataColumn(label: Text('Applicant Name')),
                DataColumn(label: Text('Created Date')),
                DataColumn(label: Text('Purpose')),
                // DataColumn(label: Text('Action')),
              ],
              rows: List.generate(forwardedList.length, (index) {
                final item = forwardedList[index];
                return DataRow(
                  color: WidgetStateColor.resolveWith((states) {
                    if (index.isEven) {
                      return Colors.grey.shade100;
                    }
                    return Colors.white;
                  }),
                  cells: [
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.nocApplicationIdNocOfLandApplicationId
                                ?.toString() ??
                            '-',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.nocApplicationIdName ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _formatDate(item.nocApplicationIdNocCreatedAt) ?? '-',
                          style: TextStyle(
                            color: Colors.orange.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        item.nocApplicationIdPurpose ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // DataCell(
                    //   Container(
                    //     child: ElevatedButton.icon(
                    //       onPressed: () {
                    //         // Handle view action for forwarded application
                    //         // context.read<MainBloc>().add(
                    //         //       NocForwardedActionEvent(item),
                    //         //     );
                    //       },
                    //       icon: const Icon(Icons.visibility, size: 16),
                    //       label: const Text('View'),
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.orange.shade600,
                    //         foregroundColor: Colors.white,
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 16,
                    //           vertical: 8,
                    //         ),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         elevation: 0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }),
            ),
          ),
        ),
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
