import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tigramnks/Images.dart';
import 'package:tigramnks/Initializer.dart';
import 'package:tigramnks/bloc/main_bloc.dart';
import 'package:tigramnks/image_capture_page.dart';
import 'package:tigramnks/model/nocviewmodel.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:url_launcher/url_launcher.dart';

class NOCView extends StatelessWidget {
  const NOCView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {
        if (state is NocListIndividualViewFailed) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: const Text('Failed to load NOC details'),
          //     backgroundColor: Colors.red.shade400,
          //     behavior: SnackBarBehavior.floating,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // );
        }
      },
      builder: (context, state) {
        if (state is NocListIndividualViewLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        if (state is NocListIndividualViewLoaded) {
          final nocData = Initializer.nocListViewModel.data?.nocApplication;
          if (nocData == null) {
            return _buildEmptyState();
          }
        }
        final nocData = Initializer.nocListViewModel.data?.nocApplication;

        return Initializer.nocListViewModel.data == null
            ? _buildEmptyState()
            : Scaffold(
                backgroundColor: Colors.grey.shade50,
                appBar: AppBar(
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 28, 110, 99),
                          Color.fromARGB(207, 28, 110, 99),
                          Color.fromARGB(195, 105, 138, 132)
                        ],
                      ),
                    ),
                  ),
                  title: const Text(
                    'NOC Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Application ID Card
                        _buildHeaderCard(nocData!.nocOfLandApplicationId),
                        const SizedBox(height: 14),
                        ServerHelper.userGroup == 'deputy range officer'
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImageCapturePage(
                                                appId: nocData.id.toString(),
                                              )),
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                  label:
                                      const Text('Proceed to site inspection'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 28, 110, 99),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 24),

                        // Personal Details
                        _buildModernSection(
                          'Personal Information',
                          Icons.person_outline,
                          [
                            _buildModernDetailRow('Full Name', nocData.name,
                                Icons.account_circle_outlined),
                            if (nocData.isInstitute == true)
                              _buildModernDetailRow(
                                'Institute',
                                nocData.instituteName,
                                Icons.business_outlined,
                              ),
                            _buildModernDetailRow('Address', nocData.address,
                                Icons.location_on_outlined),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Location Details
                        _buildModernSection(
                          'Location Details',
                          Icons.map_outlined,
                          [
                            _buildModernDetailRow('District', nocData.district,
                                Icons.location_city_outlined),
                            _buildModernDetailRow(
                                'Taluka', nocData.taluka, Icons.place_outlined),
                            _buildModernDetailRow('Village', nocData.village,
                                Icons.home_work_outlined),
                            _buildModernDetailRow('Survey Number',
                                nocData.surveyNumber, Icons.numbers_outlined),
                          ],
                        ),

                        // Comments Section - Fixed variable declarations
                        _buildCommentsIfVisible(),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget _buildCommentsIfVisible() {
    final userGroup = Initializer.nocListViewModel.data?.userGroup;
    final divisionComments =
        Initializer.nocListViewModel.data?.divisionCommentsAndFiles;
    final clerkComments =
        Initializer.nocListViewModel.data?.clerkCommentsAndFiles;

    return Column(
      children: [
        // Show Division Comments only for specific user groups
        if (userGroup != null &&
            (userGroup == "clerk division officer" ||
                userGroup == "ministerial head division officer" ||
                userGroup == "dfo territorial division officer") &&
            divisionComments != null &&
            divisionComments.isNotEmpty) ...[
          const SizedBox(height: 20),
          _buildCommentsSection(
            'Division Comments',
            divisionComments,
          ),
        ],

        // Show Clerk Comments only for specific user groups
        if (userGroup != null &&
            (userGroup == "clerk range officer" ||
                userGroup == "forest range officer" ||
                userGroup == "deputy range officer") &&
            clerkComments != null &&
            clerkComments.isNotEmpty) ...[
          const SizedBox(height: 20),
          _buildClerkCommentsSection(
            'Clerk Comments',
            clerkComments,
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No NOC data available',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again later',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(String? applicationId) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 28, 110, 99).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Application ID',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            applicationId ?? 'N/A',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSection(
      String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildModernDetailRow(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.shade500,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value ?? 'Not provided',
                  style: TextStyle(
                    fontSize: 15,
                    color: value != null
                        ? Colors.grey.shade800
                        : Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection(
    String title,
    List<DivisionCommentsAndFiles> comments,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.comment_outlined,
                    color: Colors.orange.shade600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
                height: 24,
              ),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return _buildCommentItem(comment, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(
      DivisionCommentsAndFiles comment, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue.shade100,
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.officer ?? 'Unknown Officer',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    if (comment.date != null)
                      Text(
                        comment.date!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              if (comment.file != "NO_FILE")
                InkWell(
                  onTap: () async {
                    final url =
                        "${ServerHelper.withoutapiurl}media/upload/${comment.file}" ??
                            "";
                    final isPdf = url.toLowerCase().endsWith('.pdf');
                    const isMain = false; // Set this as needed
                    if (isPdf) {
                      {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Could not open document",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      }
                    } else {
                      // Show image in ImageView and also download it
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImageView(Images: url),
                        ),
                      );
                      try {
                        final dio = Dio();
                        Directory? downloadsDir;
                        if (Platform.isAndroid) {
                          downloadsDir = await getExternalStorageDirectory();
                          final Directory? extDir =
                              await getExternalStorageDirectory();
                          if (extDir != null) {
                            const downloadsPath =
                                "/storage/emulated/0/Download";
                            downloadsDir = Directory(downloadsPath);
                          }
                        } else if (Platform.isIOS) {
                          downloadsDir =
                              await getApplicationDocumentsDirectory();
                        }
                        final fileName = url.split('/').last.split('?').first;
                        final filePath = '${downloadsDir?.path}/$fileName';
                        await dio.download(url, filePath);
                        Fluttertoast.showToast(
                          msg: "Image downloaded to $filePath",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "Failed to download image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.attachment,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
          if (comment.comment != null) ...[
            const SizedBox(height: 12),
            Text(
              comment.comment!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildClerkCommentsSection(
    String title,
    List<ClerkCommentsAndFiles> comments,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.comment_outlined,
                    color: Colors.green.shade600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
                height: 24,
              ),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return _buildClerkCommentItem(comment, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClerkCommentItem(
      ClerkCommentsAndFiles comment, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.green.shade600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.officer ?? 'Unknown Officer',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    if (comment.date != null)
                      Text(
                        comment.date!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              if (comment.file != "NO_FILE")
                InkWell(
                  onTap: () async {
                    final url =
                        "${ServerHelper.withoutapiurl}media/upload/${comment.file}" ??
                            "";
                    final isPdf = url.toLowerCase().endsWith('.pdf');
                    const isMain = false; // Set this as needed
                    if (isPdf) {
                      {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Could not open document",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      }
                    } else {
                      // Show image in ImageView and also download it
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImageView(Images: url),
                        ),
                      );
                      try {
                        final dio = Dio();
                        Directory? downloadsDir;
                        if (Platform.isAndroid) {
                          downloadsDir = await getExternalStorageDirectory();
                          final Directory? extDir =
                              await getExternalStorageDirectory();
                          if (extDir != null) {
                            const downloadsPath =
                                "/storage/emulated/0/Download";
                            downloadsDir = Directory(downloadsPath);
                          }
                        } else if (Platform.isIOS) {
                          downloadsDir =
                              await getApplicationDocumentsDirectory();
                        }
                        final fileName = url.split('/').last.split('?').first;
                        final filePath = '${downloadsDir?.path}/$fileName';
                        await dio.download(url, filePath);
                        Fluttertoast.showToast(
                          msg: "Image downloaded to $filePath",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "Failed to download image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.attachment,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
          if (comment.comment != null) ...[
            const SizedBox(height: 12),
            Text(
              comment.comment!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
