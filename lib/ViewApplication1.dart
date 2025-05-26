// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tigramnks/Images.dart';
import 'package:tigramnks/NEW_FORMS/viewApplicationNw2.dart';
import 'package:tigramnks/server/serverhelper.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewApplication1 extends StatefulWidget {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String userName;
  String userEmail;
  String img_signature;
  String img_revenue_approval;
  String img_declaration;
  String img_revenue_application;
  String img_location_sktech;
  String img_tree_ownership_detail;
  String img_aadhar_detail;

  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  int assigned_range_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  String field_requre;
  String user_Loc;
  bool field_status;
  List species;
  List length;
  List breadth;
  List volume;
  List log_details;
  String treeSpecies;
  final List<Map<String, dynamic>> additionalDocuments;

  ViewApplication1(
      {super.key,
      required this.sessionToken,
      required this.userGroup,
      required this.userId,
      required this.Ids,
      required this.Range,
      required this.userName,
      required this.userEmail,
      required this.img_signature,
      required this.img_revenue_approval,
      required this.img_declaration,
      required this.img_revenue_application,
      required this.img_location_sktech,
      required this.img_tree_ownership_detail,
      required this.img_aadhar_detail,
      required this.verify_officer,
      required this.deputy_range_officer,
      required this.verify_range_officer,
      required this.is_form_two,
      required this.assigned_deputy2_id,
      required this.assigned_deputy1_id,
      required this.assigned_range_id,
      required this.verify_deputy2,
      required this.division_officer,
      required this.other_state,
      required this.verify_forest1,
      required this.field_requre,
      required this.field_status,
      required this.species,
      required this.length,
      required this.breadth,
      required this.volume,
      required this.log_details,
      required this.treeSpecies,
      required this.user_Loc,
      required this.additionalDocuments});
  @override
  _ViewApplication1State createState() => _ViewApplication1State(
      sessionToken,
      userGroup,
      userId,
      Ids,
      Range,
      userName,
      userEmail,
      img_signature,
      img_revenue_approval,
      img_declaration,
      img_revenue_application,
      img_location_sktech,
      img_tree_ownership_detail,
      img_aadhar_detail,
      verify_officer,
      deputy_range_officer,
      verify_range_officer,
      is_form_two,
      assigned_deputy2_id,
      assigned_deputy1_id,
      assigned_range_id,
      verify_deputy2,
      division_officer,
      other_state,
      verify_forest1,
      field_requre,
      field_status,
      species,
      length,
      breadth,
      volume,
      log_details,
      treeSpecies,
      user_Loc,
      additionalDocuments);
}

class _ViewApplication1State extends State<ViewApplication1> {
  String sessionToken;
  String userGroup;
  int userId;
  String Ids;
  List Range;
  String userName;
  String userEmail;
  String img_signature;
  String img_revenue_approval;
  String img_declaration;
  String img_revenue_application;
  String img_location_sktech;
  String img_tree_ownership_detail;
  String img_aadhar_detail;

  bool verify_officer;
  bool deputy_range_officer;
  bool verify_range_officer;
  bool is_form_two;
  int assigned_deputy2_id;
  int assigned_deputy1_id;
  int assigned_range_id;
  bool verify_deputy2;
  bool division_officer;
  bool other_state;
  bool verify_forest1;
  String field_requre;
  bool field_status;
  List species;
  List length;
  List breadth;
  List volume;
  List log_details;
  String treeSpecies;
  String user_Loc;
  final List<Map<String, dynamic>> additionalDocuments;

  bool _isDownloading = false;

  _ViewApplication1State(
      this.sessionToken,
      this.userGroup,
      this.userId,
      this.Ids,
      this.Range,
      this.userName,
      this.userEmail,
      this.img_signature,
      this.img_revenue_approval,
      this.img_declaration,
      this.img_revenue_application,
      this.img_location_sktech,
      this.img_tree_ownership_detail,
      this.img_aadhar_detail,
      this.verify_officer,
      this.deputy_range_officer,
      this.verify_range_officer,
      this.is_form_two,
      this.assigned_deputy2_id,
      this.assigned_deputy1_id,
      this.assigned_range_id,
      this.verify_deputy2,
      this.division_officer,
      this.other_state,
      this.verify_forest1,
      this.field_requre,
      this.field_status,
      this.species,
      this.length,
      this.breadth,
      this.volume,
      this.log_details,
      this.treeSpecies,
      this.user_Loc,
      this.additionalDocuments);

  Future<void> downloadPdf(String url, String fileName) async {
    setState(() {
      _isDownloading = true;
    });
    try {
      final dio = Dio();
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = await getExternalStorageDirectory();
        final Directory? extDir = await getExternalStorageDirectory();
        if (extDir != null) {
          const downloadsPath = "/storage/emulated/0/Download";
          downloadsDir = Directory(downloadsPath);
        }
      } else if (Platform.isIOS) {
        downloadsDir = await getApplicationDocumentsDirectory();
      }
      final filePath = '${downloadsDir?.path}/$fileName';

      await dio.download(url, filePath);
      Fluttertoast.showToast(
        msg: "Downloaded to $filePath",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to download file",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List images = [
      img_revenue_approval,
      img_declaration,
      img_tree_ownership_detail,
      img_aadhar_detail,
    ];

    List<String> imageNm = [
      "Land Proof",
      "Possession Proof",
      "Proof of OwnerShip",
      "Id Proof",
    ];

    Future<bool> onBackPressed() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Do you want to go previous page'),
              actions: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: const Text("NO"),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: const Text("YES"),
                ),
              ],
            ),
          ) ??
          false;
    }

    const String baseUrl = ServerHelper.withoutapiurl;

    return WillPopScope(
        onWillPop: onBackPressed,
        child: Stack(
          children: [
            Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Application View',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    )),
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [HexColor("#0499f2"), Colors.blue.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [Colors.white, HexColor("#e3f2fd")],
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    // ),
                    ),
                child: Column(children: <Widget>[
                  SizedBox(height: kToolbarHeight + 10),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'ATTACHMENTS GALLERY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor("#0499f2"),
                            fontSize: 18,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final List<Map<String, dynamic>> allAttachments = [
                          for (int i = 0; i < images.length; i++)
                            {
                              'type': 'main',
                              'url': images[i].toString(),
                              'name': imageNm[i],
                            },
                          ...additionalDocuments.map((doc) => {
                                'type': 'additional',
                                'url':
                                    '${baseUrl}media/upload/Additional_documents/${doc['document']}',
                                'name': doc['name'] ?? 'Document',
                                'uploaded_at': doc['uploaded_at'],
                                'isPdf': doc['document']
                                    .toString()
                                    .toLowerCase()
                                    .endsWith('.pdf'),
                                'document': doc['document'],
                              }),
                        ];

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 240,
                            childAspectRatio: 0.80,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: allAttachments.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final item = allAttachments[index];
                            final isMain = item['type'] == 'main';
                            final url = item['url'];
                            final isPdf = isMain
                                ? url.toLowerCase().endsWith('.pdf')
                                : (item['isPdf'] ?? false);
                            String? formattedDate;
                            if (!isMain && item['uploaded_at'] != null) {
                              try {
                                final dt = DateTime.parse(item['uploaded_at']);
                                formattedDate =
                                    "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}";
                              } catch (_) {
                                formattedDate = item['uploaded_at'];
                              }
                            }
                            return TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.95, end: 1.0),
                              duration: Duration(milliseconds: 350),
                              curve: Curves.easeOutBack,
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: Card(
                                    elevation: isMain ? 12 : 6,
                                    shadowColor: Colors.blueGrey
                                        .withOpacity(isMain ? 0.25 : 0.18),
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin:
                                        EdgeInsets.only(top: isMain ? 10 : 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          isMain ? 26 : 22),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          isMain ? 26 : 22),
                                      splashColor: HexColor("#0499f2")
                                          .withOpacity(isMain ? 0.18 : 0.13),
                                      highlightColor: Colors.blue.shade50
                                          .withOpacity(isMain ? 0.12 : 0.09),
                                      onTap: () async {
                                        if (isPdf) {
                                          if (isMain) {
                                            PdfLauncher.launchPdfUrl(url);
                                          } else {
                                            if (await canLaunchUrl(
                                                Uri.parse(url))) {
                                              await launchUrl(Uri.parse(url),
                                                  mode: LaunchMode
                                                      .externalApplication);
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
                                              builder: (_) =>
                                                  ImageView(Images: url),
                                            ),
                                          );
                                          try {
                                            final dio = Dio();
                                            Directory? downloadsDir;
                                            if (Platform.isAndroid) {
                                              downloadsDir =
                                                  await getExternalStorageDirectory();
                                              final Directory? extDir =
                                                  await getExternalStorageDirectory();
                                              if (extDir != null) {
                                                const downloadsPath =
                                                    "/storage/emulated/0/Download";
                                                downloadsDir =
                                                    Directory(downloadsPath);
                                              }
                                            } else if (Platform.isIOS) {
                                              downloadsDir =
                                                  await getApplicationDocumentsDirectory();
                                            }
                                            final fileName = url
                                                .split('/')
                                                .last
                                                .split('?')
                                                .first;
                                            final filePath =
                                                '${downloadsDir?.path}/$fileName';
                                            await dio.download(url, filePath);
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Image downloaded to $filePath",
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
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      isMain ? 26 : 22),
                                              border: Border.all(
                                                color: Colors.blue.shade100,
                                                width: isMain ? 2 : 1.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blueGrey
                                                      .withOpacity(
                                                          isMain ? 0.10 : 0.08),
                                                  blurRadius: isMain ? 10 : 8,
                                                  offset:
                                                      Offset(0, isMain ? 3 : 2),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      isMain ? 26 : 22),
                                              child: isPdf
                                                  ? Container(
                                                      color:
                                                          Colors.grey.shade100,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.picture_as_pdf,
                                                          size:
                                                              isMain ? 62 : 54,
                                                          color: Colors
                                                              .red.shade400,
                                                        ),
                                                      ),
                                                    )
                                                  : _ShimmerImage(
                                                      imageUrl: isMain
                                                          ? (url +
                                                              "/$sessionToken")
                                                          : url),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(
                                                    isMain ? 0.68 : 0.72),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      isMain ? 26 : 22),
                                                  bottomRight: Radius.circular(
                                                      isMain ? 26 : 22),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 6),
                                              child: isMain
                                                  ? Text(
                                                      item['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 15,
                                                        letterSpacing: 1.1,
                                                      ),
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              item['name'] !=
                                                                          null &&
                                                                      item['name']
                                                                          .toString()
                                                                          .trim()
                                                                          .isNotEmpty
                                                                  ? Icons
                                                                      .description
                                                                  : Icons
                                                                      .insert_drive_file,
                                                              color: Colors
                                                                  .white70,
                                                              size: 18,
                                                            ),
                                                            SizedBox(width: 6),
                                                            Flexible(
                                                              child: Text(
                                                                item['name'] ??
                                                                    'Document',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      1.0,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        if (formattedDate !=
                                                            null)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 2.0),
                                                            child: Text(
                                                              formattedDate,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          if (isPdf)
                                            Positioned(
                                              top: isMain ? 14 : 12,
                                              right: isMain ? 14 : 12,
                                              child: Tooltip(
                                                message: "Download PDF",
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white
                                                      .withOpacity(
                                                          isMain ? 0.90 : 0.93),
                                                  radius: isMain ? 18 : 17,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.download,
                                                      size: isMain ? 20 : 18,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () async {
                                                      final fileName =
                                                          url.split('/').last;
                                                      await downloadPdf(
                                                          url, fileName);
                                                    },
                                                    tooltip: "Download PDF",
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.navigate_next, color: Colors.white),
                label: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                backgroundColor: HexColor("#0499f2"),
                elevation: 6,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => viewApplicationNw2(
                              sessionToken: sessionToken,
                              userGroup: userGroup,
                              userId: userId,
                              Ids: Ids,
                              Range: Range,
                              userName: userName,
                              userEmail: userEmail,
                              img_signature: img_tree_ownership_detail,
                              verify_officer: verify_officer,
                              deputy_range_officer: deputy_range_officer,
                              verify_range_officer: verify_range_officer,
                              is_form_two: is_form_two,
                              assigned_deputy2_id: assigned_deputy2_id,
                              assigned_deputy1_id: assigned_deputy1_id,
                              assigned_range_id: assigned_range_id,
                              verify_deputy2: verify_deputy2,
                              division_officer: division_officer,
                              other_state: other_state,
                              verify_forest1: verify_forest1,
                              field_requre: field_requre,
                              field_status: field_status,
                              species: species,
                              length: length,
                              breadth: breadth,
                              volume: volume,
                              log_details: log_details,
                              treeSpecies: treeSpecies,
                              user_Loc: user_Loc)));
                },
              ),
            ),
            if (_isDownloading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade100.withOpacity(0.4),
                              blurRadius: 18,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 54,
                              height: 54,
                              child: CircularProgressIndicator(
                                color: HexColor("#0499f2"),
                                strokeWidth: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ));
  }
}

class _ShimmerImage extends StatelessWidget {
  final String imageUrl;
  const _ShimmerImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: Colors.grey.shade200,
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: progress.expectedTotalBytes != null
                        ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                        : null,
                    strokeWidth: 3,
                    color: HexColor("#0499f2"),
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Center(
            child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
          ),
        ),
      ],
    );
  }
}

class PdfLauncher {
  static void launchPdfUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
