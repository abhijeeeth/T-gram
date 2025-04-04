// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:tigramnks/Images.dart';

import 'package:tigramnks/NEW_FORMS/viewApplicationNw2.dart';
import 'package:tigramnks/ViewApplication.dart';
import 'package:tigramnks/ViewApplication2.dart';

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
  ViewApplication1(
      {required this.sessionToken,
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
      required this.user_Loc});
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
      user_Loc);
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
      this.user_Loc);

// Future<bool> _onBackPressed() {
//   return showDialog(
//     context: context,
//     builder: (context) => new AlertDialog(
//       title: new Text('Are you sure?'),
//       content: new Text('Do you want to exit an App'),
//       actions: <Widget>[
//         new GestureDetector(
//           onTap: () => Navigator.of(context).pop(false),
//           child: Text("NO"),
//         ),
//         SizedBox(height: 16),
//         new GestureDetector(
//           onTap: () => Navigator.of(context).pop(true),
//           child: Text("YES"),
//         ),
//       ],
//     ),
//   ) ??
//       false;r
// }

  @override
  Widget build(BuildContext context) {
    List images = [
      // img_signature,
      img_revenue_approval,
      img_declaration,
      // img_revenue_application,
      // img_location_sktech,
      img_tree_ownership_detail,
      img_aadhar_detail,
    ];

    print(img_signature);
    List<String> Image_nm = [
      // "Signature",
      "Land Proof",
      "Possession Proof",
      // "Revenue Application",
      // "location Sketch",
      "Proof of OwnerShip",
      "Id Proof",
    ];
    print(images.toString());
    Future<bool> _onBackPressed() async {
      return await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: const Text('Do you want to go previous page'),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: const Text("NO"),
                ),
                const SizedBox(height: 16),
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: const Text("YES"),
                ),
              ],
            ),
          ) ??
          false;
    }

    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Application View'),

            //backgroundColor: Colors.blueGrey,
            elevation: 0,
            // automaticallyImplyLeading: false,
          ),
          body: Column(children: <Widget>[
            SizedBox(
              child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0, top: 10, bottom: 0, left: 15),
                  child: Text(
                    '------ATTACHMENTS GALLERY--------',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  )),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: images.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (BuildContext context, int index) {
                    // return Card(
                    //   elevation: 5,
                    //   semanticContainer: true,
                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                    //   margin: EdgeInsets.only(top: 10),
                    //   child: InkWell(
                    //     onTap: () {
                    //       print(images);
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (_) => ImageView(
                    //                     Images: images[index].toString(),
                    //                   )));
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //           image: NetworkImage(images[index].toString()),
                    //           fit: BoxFit.fitWidth,
                    //           alignment: Alignment.center,
                    //         ),
                    //       ),
                    //       child: ListTile(
                    //         title: Text(
                    //           Image_nm[index].toString(),
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //               backgroundColor: Colors.black,
                    //               color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    // );
                    return Card(
                      elevation: 5,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          print("PDFFFFF");
                          final url = images[index].toString();
                          if (url.toLowerCase().endsWith('.pdf')) {
                            // Open a PDF viewer
                            PdfLauncher.launchPdfUrl(url);
                            // PdfLauncher.launchPdfUrl(url + "/$sessionToken");
                          } else {
                            // Display the image
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    // ImageView(Images: url + "/$sessionToken"),
                                    ImageView(Images: url),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  images[index] + "/$sessionToken".toString()),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.center,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  Image_nm[index].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    backgroundColor: Colors.black,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (images[index]
                                  .toString()
                                  .toLowerCase()
                                  .endsWith('.pdf'))
                                Icon(
                                  Icons.picture_as_pdf,
                                  size: 50,
                                  color:
                                      Colors.red, // Choose your preferred color
                                ),
                            ],
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  }),
            )
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.navigate_next),
            backgroundColor: HexColor("#0499f2"),
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
                          user_Loc: user_Loc
                          //sessionToken:sessionToken,
                          )));
            },
          ),
        ));
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
