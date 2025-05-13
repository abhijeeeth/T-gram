import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tigramnks/TransitPass.dart';
import 'package:tigramnks/blocks/formOneblock.dart';
import 'package:tigramnks/events/addFormOne.dart';
import 'package:tigramnks/events/deleteFormOne.dart';
import 'package:tigramnks/events/setFormOne.dart';
import 'package:tigramnks/events/updateFormOne.dart';
import 'package:tigramnks/sqflite/dataBase.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/formOneModel.dart';

// class formsNotsList extends StatefulWidget {


//   String sessionToken;
//   String userName;
//   String userEmail;
 
//   formsNotsList({this.sessionToken, this.userName, this.userEmail});
//   @override
//   _formsNotsListState createState() =>
//       _formsNotsListState(sessionToken, userName, userEmail);
// }

// class _formsNotsListState extends State<formsNotsList> {
//   _formsNotsListState(String sessionToken, String userName, String userEmail);
  
//   String get sessionToken => sessionToken;
  
//   get userName => userName;
  
//   get userEmail => userEmail;
  
// //   String get sessionToken => sessionToken;
// //   String get userName => userName;
// //   String get userEmail => userEmail;

// //   dataBaseSqf dbHelper;
// //   formOneFields _user;

// //   final nameController = TextEditingController();
// //   final addressController = TextEditingController();
// //   final survayController = TextEditingController();
// //   bool isEditing = false;
  
// //  Future<void> addOrEditUser() async {
// //     String address = addressController.text;
// //     String name = nameController.text;
// //     String survayno = survayController.text;

// //     if (!isEditing) {
// //       formOneFields user = new formOneFields(name: name, address: address, survayno: survayno);
// //       await addUser(user);
// //     } else {
// //       _user.survayno = survayno;
// //       _user.address = address;
// //       _user.name = name;
// //       await updateUser(_user);
// //     }
// //     resetData();
// //     setState(() {});
// //   }

// //   Future<int> addUser(formOneFields user) async {
// //     return await this.dbHelper.insertForm1(user);
// //   }

// //   Future<int> updateUser(formOneFields user) async {
// //     return await this.dbHelper.updateForm1(user);
// //   }

// //   void resetData() {
// //     nameController.clear();
// //     addressController.clear();
// //     survayController.clear();
// //     isEditing = false;
// //   }

//  @override
//   void initState() {
//     super.initState();
//     dataBaseSqf.db.getFormOnes().then((formOneList){
//       BlocProvider.of<formOneBlock>(context).add(setFormOne(formOneList));
//     },);
    
//   }

//   showFoodDialog(BuildContext context, formOneFields form, int index,String sessionToken,String userName,String userEmail){
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(form.name),
//         content: Text("id ${form.id}"),
//         actions: <Widget>[
//           TextButton (
//             onPressed: () => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => TransitPass(
//                 form: form, 
//                 formOneIndex: index,
//                 sessionToken:sessionToken,
//                 userName:userName,
//                 userEmail:userEmail
//               ),
//               ),
//             ),
//             child: Text("Update"),
//           ),
//           TextButton (
//             onPressed: () => dataBaseSqf.db.delete(form.id).then((_) {
//               BlocProvider.of<formOneBlock>(context).add(
//                 deleteForm1(index),
//               );
//               Navigator.pop(context);
//             }),
//             child: Text("Delete"),
//           ),
//           TextButton (
//             onPressed: () => Navigator.pop(context),
//             child: Text("Cancel"),
//           ),
//         ],
//       ),
//     );
//   }
// //   void populateFields(formOneFields form) {
// //     _user = form;
// //     nameController.text = _user.name;
// //     addressController.text = _user.address;
// //     survayController.text = _user.survayno;
// //     isEditing = true;
// // }
//   // @override
//   // Widget build(BuildContext context) {
//   //   Widget userWidget() {
//   //   return FutureBuilder(
//   //     future: this.dbHelper.retrieveForm1(),
//   //     builder: (BuildContext context, AsyncSnapshot<List<formOneFields>> snapshot) {
//   //       if (snapshot.hasData) {
//   //         return ListView.builder(
//   //             itemCount: snapshot.data?.length,
//   //             itemBuilder: (context, position) {
//   //               return Dismissible(
//   //                   direction: DismissDirection.endToStart,
//   //                   background: Container(
//   //                     color: Colors.red,
//   //                     alignment: Alignment.centerRight,
//   //                     padding: EdgeInsets.symmetric(horizontal: 10.0),
//   //                     child: Icon(Icons.delete_forever),
//   //                   ),
//   //                   key: UniqueKey(),
//   //                   onDismissed: (DismissDirection direction) async {
//   //                     await this
//   //                         .dbHelper
//   //                         .deleteForm1(snapshot.data[position].id);
//   //                   },
//   //                   child: new GestureDetector(
//   //                     behavior: HitTestBehavior.opaque,
//   //                     onTap: () => populateFields(snapshot.data[position]),
//   //                     child: Column(
//   //                       children: <Widget>[
//   //                         Row(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                           children: <Widget>[
//   //                             Column(
//   //                               crossAxisAlignment: CrossAxisAlignment.start,
//   //                               children: <Widget>[
//   //                                 Padding(
//   //                                   padding: const EdgeInsets.fromLTRB(
//   //                                       12.0, 12.0, 12.0, 6.0),
//   //                                   child: Text(
//   //                                     snapshot.data[position].name,
//   //                                     style: TextStyle(
//   //                                         fontSize: 22.0,
//   //                                         fontWeight: FontWeight.bold),
//   //                                   ),
//   //                                 ),
//   //                                 Padding(
//   //                                   padding: const EdgeInsets.fromLTRB(
//   //                                       12.0, 6.0, 12.0, 12.0),
//   //                                   child: Text(
//   //                                     snapshot.data[position].address.toString(),
//   //                                     style: TextStyle(fontSize: 18.0),
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                             Padding(
//   //                               padding: const EdgeInsets.all(8.0),
//   //                               child: Column(
//   //                                 mainAxisAlignment:
//   //                                     MainAxisAlignment.spaceEvenly,
//   //                                 children: <Widget>[
//   //                                   Container(
//   //                                     decoration: BoxDecoration(
//   //                                         color: Colors.black26,
//   //                                         borderRadius:
//   //                                             BorderRadius.circular(100)),
//   //                                     child: Padding(
//   //                                       padding: const EdgeInsets.all(8.0),
//   //                                       child: Text(
//   //                                         snapshot.data[position].survayno
//   //                                             .toString(),
//   //                                         style: TextStyle(
//   //                                           fontSize: 16,
//   //                                           color: Colors.white,
//   //                                         ),
//   //                                       ),
//   //                                     ),
//   //                                   )
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                         Divider(
//   //                           height: 2.0,
//   //                           color: Colors.grey,
//   //                         )
//   //                       ],
//   //                     ),
//   //                   ));
//   //             });
//   //       } else {
//   //         return Center(child: CircularProgressIndicator());
//   //       }
//   //     },
//   //   );
//   // }
//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(" storage"),
//         // leading: Image.asset(
//         //   'assets/images/logo.png',
//         // ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(8),
//         color: Colors.grey,
//         child: BlocConsumer<formOneBlock,List<formOneFields>>(
//           builder: (context, formsNotsList) {
//             return ListView.builder(
//               itemBuilder: (BuildContext context, int index) {
//                 print("foodList: $formsNotsList");

//                 formOneFields form = formsNotsList[index];
//                 return Card(
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(16),
//                     title: Text(form.name , style: const TextStyle(fontSize: 26)),
//                     subtitle: Text(
//                       form.address , style: const TextStyle(fontSize: 20),
//                     ),
//                     onTap: () => showFoodDialog(context, form, index, sessionToken, userName, userEmail),
//                   ),
//                 );
//               },
//               itemCount: formsNotsList.length,
//             );
//           },
//           listener: (BuildContext context, formsNotsList) {},
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_)  => TransitPass(
//             sessionToken:sessionToken,
//                 userName:userName,
//                 userEmail:userEmail
           
          
//               ),),
//         ),
//       ),
//     );
//   }
// }

// // class _formsNotsListState extends State<formsNotsList> {
// //    String sessionToken;
// //    String userName;
// //    String userEmail;
// //     List<formOneModel> notes;
// //    bool isLoading = false;

// //     _formsNotsListState(this.sessionToken, this.userName, this.userEmail);


// //    @override
// //   void initState() {
// //     super.initState();

// //     refreshNotes();
// //   }

// //   @override
// //   void dispose() {
// //     dataBaseSqf.instance.close();

// //     super.dispose();
// //   }


// //   Future refreshNotes() async {
// //     setState(() => isLoading = true);

// //     this.notes = await dataBaseSqf.instance.readAllNotes();

// //     setState(() => isLoading = false);
// //   }
// //   @override
// //   Widget build(BuildContext context) => Scaffold(
// //         appBar: AppBar(
// //           title: Text(
// //             'Notes',
// //             style: TextStyle(fontSize: 24),
// //           ),
// //           actions: [Icon(Icons.search), SizedBox(width: 12)],
// //         ),
// //         body: Center(
// //           child: isLoading
// //               ? CircularProgressIndicator()
// //               : notes.isEmpty
// //                   ? const Text(
// //                       'No Notes',
// //                       style: TextStyle(color: Colors.white, fontSize: 24),
// //                     )
// //                   : buildNotes(),
// //         ),
//         // floatingActionButton: FloatingActionButton(
//         //   backgroundColor: Colors.black,
//         //   child: Icon(Icons.add),
//         //   onPressed: () async {
//         //     await Navigator.of(context).push(
//         //       MaterialPageRoute(builder: (context) => TransitPass(
//         //         sessionToken:sessionToken,
//         //         userName:userName,
//         //         userEmail:userEmail,
//         //       )),
//         //     );

// //             refreshNotes();
// //           },
// //         ),
// //       );

// //   Widget buildNotes() => StaggeredGridView.countBuilder(
// //         padding: EdgeInsets.all(8),
// //         itemCount: notes.length,
// //         staggeredTileBuilder: (index) => StaggeredTile.fit(2),
// //         crossAxisCount: 4,
// //         mainAxisSpacing: 4,
// //         crossAxisSpacing: 4,
// //         itemBuilder: (context, index) {
// //           final note = notes[index];

// //           return GestureDetector(
// //             onTap: () async {
// //               await Navigator.of(context).push(MaterialPageRoute(
// //                // builder: (context) => NoteDetailPage(noteId: note.id!),
// //               ));

// //               refreshNotes();
// //             },
// //           //  child: NoteCardWidget(note: note, index: index),
// //           );
// //         },
// //       );


// // }

