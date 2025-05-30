import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tigramnks/noc_Form2.dart';

class noc_Form1 extends StatefulWidget {
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String Tree_Proposed_to_cut;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;

  noc_Form1(
      {super.key,
      required this.sessionToken,
      required this.dropdownValue,
      required this.dropdownValue1,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.Name,
      required this.Address,
      required this.survey_no,
      required this.Tree_Proposed_to_cut,
      required this.village,
      required this.Taluka,
      required this.block,
      required this.District,
      required this.Pincode});
  @override
  _noc_Form1State createState() => _noc_Form1State(
      sessionToken,
      dropdownValue,
      dropdownValue1,
      userName,
      userEmail,
      userId,
      Name,
      Address,
      survey_no,
      Tree_Proposed_to_cut,
      village,
      Taluka,
      block,
      District,
      Pincode);
}

class _noc_Form1State extends State<noc_Form1> {
  String sessionToken;
  String dropdownValue;
  String dropdownValue1;
  String userName;
  String userEmail;
  int userId;
  String Name;
  String Address;
  String survey_no;
  String Tree_Proposed_to_cut;
  String village;
  String Taluka;
  String block;
  String District;
  String Pincode;

  _noc_Form1State(
      this.sessionToken,
      this.dropdownValue,
      this.dropdownValue1,
      this.userName,
      this.userEmail,
      this.userId,
      this.Name,
      this.Address,
      this.survey_no,
      this.Tree_Proposed_to_cut,
      this.village,
      this.Taluka,
      this.block,
      this.District,
      this.Pincode);

  Map<String, bool> List = {
    'Coconut': false,
    'Rubber ': false,
    'Cashew': false,
    'Tamarind': false,
    'Mango': false,
    'Jack Fruit Tree': false,
    'Kadompuli': false,
    'Matti': false,
    'Arecanut': false,
    'konna': false,
    'Seema Konna ': false,
    'Nelli': false,
    'Neem': false,
    'Murukku': false,
    'Jathi': false,
    'Albezia': false,
    'Silk cotton': false,
    'Acacia auraculiformis': false,
    'Mangium': false,
    'Anhili ': false,
    'Kilimaram': false,
    'Manchadimaram': false,
    'Vatta': false,
    'Aranamaram': false,
    'Eucalyptus': false,
    'Seemaplavu': false,
    'Paala': false,
  };
  var holder_1 = [];

  getItems() {
    List.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    // holder_1.clear();
  }

  int _radioValue = 0;
  int _radioValue1 = 0;
  String maintenance = '';
  String maintenance1 = '';
  int maintenance_cost = 0;
  int estimatedMaintenanceCost = 0;

  bool flag = false;
  bool flag1 = false;
  bool isother_Species = false;
  TextEditingController Purpose = TextEditingController();
  TextEditingController Species = TextEditingController();
  @override
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'Yes';
        setState(() {
          flag = true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'No';
        setState(() {
          flag = false;
        });
      }
    });
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      if (_radioValue1 == 1) {
        setState(() {
          flag1 = true;
        });
      } else if (_radioValue1 == 2) {
        setState(() {
          flag1 = false;
        });
      }
    });
  }
  //-- File- Picker

  AddHolder() {
    setState(() {
      if (Species.text.isNotEmpty && isother_Species == false) {
        if (holder_1.length < int.parse(Tree_Proposed_to_cut)) {
          // if(isother_Species==false){
          isother_Species = true;
          holder_1.add(Species.text);
          // }
        } else {
          Fluttertoast.showToast(
              msg: "You can select only  $Tree_Proposed_to_cut Species",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18.0);
          Species.clear();
          return;
        }
      } else {
        if (isother_Species == true) {
          holder_1.removeLast();
          isother_Species = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor:Colors.blueGrey,
        title: const Text(
          "NOC Form",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

        elevation: 0,
        //automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 13, top: 15),
            child: const Text(
              'Species of tree or trees proposed to be cut:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          )
        ]),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
          height: MediaQuery.of(context).size.height * 0.39,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: List.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: List[key],
                activeColor: Colors.green,
                checkColor: Colors.white,
                onChanged: (bool? value) {
                  setState(() {
                    List[key] = value!;
                  });
                  if (value == true) {
                    holder_1.add(key);
                  } else if (value == false) {
                    holder_1.remove(key);
                  }
                  // AddHolder();
                },
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10, bottom: 0),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: Species,
            //  obscAddHolderureText: true,
            onChanged: AddHolder(),
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                labelText: 'Other Species',
                hintText: 'Enter Other Species'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10, bottom: 0),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: Purpose,
            //  obscureText: true,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                labelText: 'Purpose *',
                hintText:
                    ' Enter Purpose for which trees or trees proposed to be cut'),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10, left: 0, right: 0),
                child: const Text(
                  'Trees have been cut or yet to be cut? *',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: RadioListTile(
                    title: const Text(
                      'Yes',
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: (int? value) => _handleRadioValueChange(value!),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text(
                      'No',
                      style: TextStyle(fontFamily: 'Lato'),
                    ),
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: (int? value) => _handleRadioValueChange(value!),
                  ),
                ),
              ]),
              LayoutBuilder(builder: (context, constraints) {
                if (flag == true) {
                  flag1 == true;
                  return Container(
                      margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
                      child: Column(children: <Widget>[
                        Container(
                          child: const Text(
                            'Would you like to enter the log details?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: RadioListTile(
                              title: const Text(
                                'Yes',
                                style: TextStyle(fontFamily: 'Lato'),
                              ),
                              value: 1,
                              groupValue: _radioValue1,
                              onChanged: (int? value) =>
                                  _handleRadioValueChange1(value!),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: const Text(
                                'No',
                                style: TextStyle(fontFamily: 'Lato'),
                              ),
                              value: 2,
                              groupValue: _radioValue1,
                              onChanged: (int? value) =>
                                  _handleRadioValueChange1(value!),
                            ),
                          ),
                        ]),
                      ]));
                } else if (flag == false) {
                  flag1 = false;
                  return Container(
                    color: Colors.white,
                  );
                }
                return Container(); // Ensure a widget is always returned
              }),
            ]))
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          // isExtended: true,
          backgroundColor: HexColor("#0499f2"),
          onPressed: () {
            setState(() {
              // AddHolder();
              print(holder_1);
              if (Purpose.text.isEmpty) {
                // if ((Purpose.text == 0) ||
                //     (holder_1.length == 0) ||
                //     (Purpose.text == 0) ||
                //     (_radioValue.bitLength == 0)) {
                Fluttertoast.showToast(
                    msg: "Please add Purpose ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 18.0);
              } else if (holder_1.isEmpty) {
                Fluttertoast.showToast(
                    msg: "Please select Timber type",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 18.0);
              } else if (_radioValue.bitLength == 0) {
                Fluttertoast.showToast(
                    msg: "select tress have cut or not",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 18.0);
              } else if (holder_1.length > int.parse(Tree_Proposed_to_cut)) {
                Fluttertoast.showToast(
                    msg: "You can select only  $Tree_Proposed_to_cut Species",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 18.0);
              } else {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          return ScaleTransition(
                            alignment: Alignment.topCenter,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return noc_Form2(
                            sessionToken: sessionToken,
                            dropdownValue: dropdownValue,
                            dropdownValue1: dropdownValue1,
                            userName: userName,
                            userEmail: userEmail,
                            userId: userId,
                            Name: Name,
                            Address: Address,
                            survey_no: survey_no,
                            Tree_Proposed_to_cut: Tree_Proposed_to_cut,
                            village: village,
                            Taluka: Taluka,
                            block: block,
                            District: District,
                            Pincode: Pincode,
                            Purpose: Purpose.text,
                            holder_1: holder_1,
                            flag1: flag1,
                          );
                        }));
              }
            });
          },
          // isExtended: true,
          child: const Icon(Icons.navigate_next)),
    );
  }
}
