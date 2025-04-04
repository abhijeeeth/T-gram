// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNonNot2.dart';
import 'package:tigramnks/NEW_FORMS/transitPassNotified2.dart';
import 'package:tigramnks/homePage.dart';

class transitPassNotified extends StatefulWidget {
  final int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village_;
  String userGroup;

  transitPassNotified(
      {super.key,
      required this.sessionToken,
      required this.userName,
      required this.userEmail,
      required this.userId,
      required this.formOneIndex,
      required this.village_,
      required this.userGroup});

  @override
  State<transitPassNotified> createState() => _transitPassNotifiedState(
      formOneIndex,
      sessionToken,
      userName,
      userEmail,
      userId,
      village_,
      userGroup);
}

class _transitPassNotifiedState extends State<transitPassNotified> {
  int formOneIndex;
  String sessionToken;
  String userName;
  String userEmail;
  int userId;
  String village__;
  String userGroup;

  _transitPassNotifiedState(this.formOneIndex, this.sessionToken, this.userName,
      this.userEmail, this.userId, this.village__, this.userGroup);

  String? divisionData;
  String? rangeData;
  String? selectedPurpose;
  bool holder_check = false;
  String maintenance = '';
  double v = 0.0;
  double Len = 0.0;

  TextEditingController Name = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController survey_no = TextEditingController();
  TextEditingController Tree_Proposed_to_cut = TextEditingController();
  TextEditingController DistrictCo = TextEditingController();
  TextEditingController TalukCo = TextEditingController();
  TextEditingController blockCo = TextEditingController();
  TextEditingController pincodeCo = TextEditingController();
  TextEditingController villageCo = TextEditingController();
  TextEditingController Purpose = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController girth = TextEditingController();
  TextEditingController volume = TextEditingController();
  String no_Tree = "0";

  bool flag1 = true;
  int exindex = 1;

  Map<String, bool> SpeciasList = {
    'Rosewood(Dalbergia latifolia)': false,
    'Teak(Tectona grandis) ': false,
    'Thempavu(Terminalia tomantosa)': false,
    'Chadachi(Grewia tiliaefolia)': false,
    'Chandana vempu(Cedrela toona)': false,
    'Vellakil(Dysoxylum malabaricum)': false,
    'Irul(Xylia xylocarpa)': false,
    'Ebony(Diospyrus sp.)': false,
    'Kampakam(Hopea Parviflora)': false,
  };
  Map<String, bool> SpeciasListB = {
    "(Ear Pod Wattle) - (അക്കേഷ്യ)": false,
    "(ഇയർ ലീഫ് അക്കേഷ്യ) - (അക്കേഷ്യ)": false,
    "(Eenja,Velutha-incha,Palinja)": false,
    "() - (കരിങ്ങാലി)": false,
    "(Baabolamaram, Gonthumaram, Karivelam)": false,
    "(Vanni) - (പൗവേലം, വന്നി)": false,
    "(Karingali) - (ചെങ്കരിങ്ങാലി, വെള്ളവേലം)": false,
    "() - (മാഞ്ചിയം)": false,
    "(Karingodi,Shegappuagili,Narivenga,Karangan,Nellara)": false,
    "(Kurangadi) - (കുരങ്ങാടി)": false,
    "() - (മുട്ടനാറി) ": false,
    "(Eeyoli, Malavirinji)": false,
    "(Eyyoli)": false,
    "(Eyyoli) - (തളി, ത്യോളി, മുങ്ങാലി)": false,
    "(Red bead tree) ": false,
    " (  ) - (മഞ്ചാടി)": false,
    " () - (മഞ്ഞക്കടമ്പ്) ": false,
    "(Koovalam) - (കൂവളം)": false,
    "(Karakil)": false,
    "() - (പുണ്യവ) ": false,
    "() - (ചുവന്നചീരളം) ": false,
    "() - (നിർമുള്ള) ": false,
    "(Manjari) - (മഞ്ചാരി) ": false,
    "(Kozhivalan, Mulimpala)": false,
    "(Mattipongilyam, Peemaram, Peruppi)": false,
    "(Maharukh) - (മട്ടി) ": false,
    " () - (മട്ടി) ": false,
    "(Sau tree) - (മൊട്ടവാക, പൊന്തംവാക)": false,
    "(Mottavaka, Pottavaka)": false,
    "(East India walnut, Lebbek tree) - (നെന്മേനിവാക, കാട്ടുവാക)": false,
    "() - (Nenmenivaka)": false,
    "(Vaga,Nenmenivaka,Karimthakara,Kattuvaka,Karivaka)": false,
    "(Vaka) - (വാക) ": false,
    "(Black siris, Kala siris) - (കുന്നിവാക, നെല്ലിവാക)": false,
    "(ക്രാബ്സ് ഐ ഇന്ത്യൻ ലിക്വറിയ ) - (കുന്നി കുന്നിവാക) ": false,
    "(Pulivaka) - (കുന്നിവാക, നെല്ലിവാക, പുളിവാക)": false,
    "() - (തകര ) ": false,
    "(Jalavaka, Vellavaka)": false,
    "(Rain tree) - (മഴമരം) ": false,
    "(Arinjl)": false,
    "(Devil tree, Shaitan wood) - (ഏഴിലംപാല, മംഗലപാല)": false,
    "() - (പാല) ": false,
    "(Ezhilamppala, Mangalappala, Pala, Yekshippala)": false,
    "(Ezhilam pala) - (ഏഴിലംപാല) ": false,
    "(Theeppala,Perumarunnu,Kuttippala,Palamunpala)": false,
    "(Cashew-nut tree) - (കശുമാവ്) ": false,
    "(Kasumavu,Parangimavu)": false,
    "(Kaiadi,Malamkara,Kalumanikkam)": false,
    "(Kal manikyam) - (കൽമാണിക്ക്യം) ": false,
    "(Nilaveppu) - (Kiriathu)": false,
    "(Mullan)": false,
    "(Axle wood, Button tree) - (കൽകാഞ്ഞിരം, മലകാഞ്ഞിരം)": false,
    "() - (കൽകാഞ്ഞിരം)8 ": false,
    "(Vekkali) - (വെക്കാളി) ": false,
    "(ഉപാസ് ട്രീ ) - (അരയാഞ്ഞിലി ) ": false,
    "(Aranthal,Chilapettamaram,Maravuri,Aranjili,Karanjili,Nettavil)": false,
    "(Arandhil) - (അരയാഞ്ഞിലി) ": false,
    "() - (കരിവെട്ടി(എടല) ": false,
    "() - (താളി) ": false,
    "() - (വെട്ടി, ഏച്ചിൽ)": false,
    "(Putharaval)": false,
    "() - (പുത്താരവൽ, താത്തലമരം)": false,
    "(Thathalamaram)": false,
    "(Rohituka tree) - (ചെമ്മരം) ": false,
    "(Chemmaram)": false,
    "(Swarnavetti,Neervetti,Nirvittil)": false,
    "(Maravetty)": false,
    "() - (പൊൻവെട്ടി, വെട്ടി)": false,
    "(Aechil, Ponvetti, Vetti)": false,
    "(Neer vetti) - (നീർവെട്ടി) ": false,
    "(Vetty) - (വെട്ടി) ": false,
    "() - (കാട്ടുകൊന്ന, പന്നിവാക)": false,
    "(Njettipana,Malan Thengu)": false,
    "() - (ഞെട്ടിത്തെങ്) ": false,
    "() - (Kadaplavu)": false,
    "(Jack fruit tree) - (പ്ലാവ്) ": false,
    "(Atthi)": false,
    "() - (പ്ലാവ്) ": false,
    "(Plavu)": false,
    "(Wild jack) - (ആഞ്ഞിലി) ": false,
    "(വൈൽഡ് ജാക്ക് ) - (ആഞ്ഞിലി) ": false,
    "(Anjili, Ayani)": false,
    "(Anjili) - (ആഞ്ഞിലി) ": false,
    "(Kattunaragam,Malanaragam)": false,
    "() - (കാട്ടുനാരകം) ": false,
    "(Katunarenga)": false,
    "() - (കാട്ടുനാരകം ) ": false,
    "(Kambilivirinji, Malavirinji, Neyaram)": false,
    "(Veppu) - ()": false,
    "(Aariyaveppu)": false,
    "(Veppu) - (ആര്യവേപ്പ്) ": false,
    "() - (മൂട്ടിൽകായ, മൂട്ടിൽപ്പഴം)": false,
    "() - (മൂട്ടിൽപ്പഴം) ": false,
    "(Mootty, Mootikaya, Mootilpazham)": false,
    "(Mootti) - (മൂട്ടി) ": false,
    "(Arampuli)": false,
    "() - (ആത്തി, മലമന്ദാരം)": false,
    "(Arampali, Malayathi, Kotapuli)": false,
    "(Kaattathi) - (മലയത്തി, കുടമ്പുളിമന്ദാരം)": false,
    "(Cholakara)": false,
    "(Parapakku)": false,
    "() - (നീലി) ": false,
    "(Cholavenga, Mlachethayan, Neeli, Thiruppu)": false,
    "(Sindooram, Kurannumannal)": false,
    "(Kurangu manjal) - (കുരങ്ങുമഞ്ഞൾ) ": false,
    "(Neerkuruntha) - (നീർകുരുണ്ട) ": false,
    "() - (ഇലവ്) ": false,
    "(Elavu, Ilavu, Mullilavu, Poola)": false,
    "(Elavu) - (ഇലവ്) ": false,
    "(Silk cotton tree) - (പൂള, ഇളവ്)": false,
    "(റെഡ് സിഡാർ ) - (പൂള ) ": false,
    "(Mullilavu)": false,
    "(Karimpana)": false,
    "(Mulvaengai)": false,
    "() - (ചളിര്) ": false,
    "(Mulluvenga,Mulkaini)": false,
    "() - (മുള്ളൻക്കയിനി, മുക്കയിനി)": false,
    "(Mulluvenga) - (മുള്ളുവേങ്ങ, മുള്ളൻകൈനി, മുക്കൈനി)": false,
    "(Paper mulberry) - ()": false,
    "(Malamavu,Kulamavu)": false,
    "(Moongapezhu, Nuramaram, Priyalam)": false,
    "(Moongapezhu) - (മൂങ്ങാപ്പേഴ്) ": false,
    "(ഫ്ലെയിo ഓഫ് ദി ഫോറസ്ററ്, സ്റ്റാർഡ് ടീക്ക്  ) - (ചമത)": false,
    "(Plachi, Palasinsamatha)": false,
    "(Plash) - (പ്ലാശ്, ചമത)": false,
    "(Kattakatti,Vizhoothi)": false,
    "(Vizhudhi)": false,
    "(റാട്ടാൻ കൈൻ പാം ) - (ചൂരൽ) ": false,
    "(Great woolly malayan lilac) - (ചെറുതേക്ക്) ": false,
    "(French mulberry of the western ghats) - (Cheruthekku, Naikumbil)": false,
    "(Cheruthekku, Thinperivelam, Naikumbil)": false,
    "(Aattupunna, Manjapunna, Valuzhavam)": false,
    "(Kattupunna)": false,
    "(Cherupunna,Aattupunna,Porapunna,Manjapunna)": false,
    "(Punna) - (ചെറുപുന്ന) ": false,
    "(മാസ്ററ് വുഡ് ) - (പുന്ന ) ": false,
    "(Punna,Surampunna,Pinna)": false,
    "(Poonspar tree, Sirpoon tree) - (പുന്ന, കാട്ടുപുന്ന)": false,
    "(Pullani,Varavalli,Pullanni,Pullanji)": false,
    "() - (Pantham)": false,
    "(Thellippayin,Pantham, Pantappayan, Thelli, Viraka, Thellippayin)": false,
    "(Payan) - (പൈൻ) ": false,
    "(Irumbarappan)": false,
    "(Irimparuppi) - (ഇരുമ്പറുപ്പി) ": false,
    "(Aanakombi)": false,
    "(Aanakombi) - (ചെറുകാര, കാര, കണ്ടകാര)": false,
    "() - (കൽപ്പുന്ന) ": false,
    "(Adandamkody)": false,
    "(Waghutty)": false,
    "() - (വല്ലഭം) ": false,
    "(ഇന്ത്യൻ ഓക്ക് ) - (വറങ്) ": false,
    "(Vallabham,Varanga,Varrungu,Valovam)": false,
    "(Vallabham) - (വല്ലഭം) ": false,
    "(Wild guava) - (പേഴ്) ": false,
    "(പാറ്റ്ന ഓക്ക് ) - (പേഴ് ) ": false,
    "(Aalam, Alasoo, Pezhu)": false,
    "(Pezhu) - (പേഴ്‌)": false,
    "(Elephant''s palm, Fish-tail palm) - (ആനപ്പന, ചൂണ്ടപ്പന)": false,
    "() - (പന) ": false,
    "(Olatti, Kalippana, Chundappana)": false,
    "(Pana) - (ചൂണ്ടപ്പന) ": false,
    "(Indian laburnum, Fistula) - (കണിക്കൊന്ന, കർണികാരം)": false,
    "(ഇന്ത്യൻ ലാബർനം ) - (കണിക്കൊന്ന ) ": false,
    "(Kanikonna, Konna)": false,
    "(Kanikkonna) - (കണിക്കൊന്ന) ": false,
    "(Kada konna, Red Cassia)": false,
    "(Kada konna) - (കടക്കൊന്ന) ": false,
    "(Australian pine )": false,
    ") - (കാറ്റാടി)": false,
    "(ബീഫ് വുഡ് ) - (കാറ്റാടി )  ": false,
    "(Emetic nut) - (കാര)  ": false,
    "(Ekana, Vembu, Chandanavembu, Mathagirivembu)": false,
    "() - (പൂച്ചകുരുമരം)  ": false,
    "() - (മല ഇലഞ്ഞി)  ": false,
    "(Pulinji) - (പുളിഞ്ചി)  ": false,
    "(റെഡ് സിഡാർ ) - (ചുവന്നകിൽ )  ": false,
    "() - (കറുപ്പ)  ": false,
    "() - (കറപ്പ)  ": false,
    "(Illavangam, Karappa, Vayana)": false,
    "(karappa) - (വഴന, എടന)": false,
    "(Aattuvayana) ": false,
    "(Kattu karuva)": false,
    "(Cinnamon) - (കറുവപ്പട്ട)  ": false,
    "(Karukappetta) - (കറുവ)  ": false,
    "(Kattukaruva)": false,
    "(Ceylon cinnamom) - (Vayana,karuva)": false,
    "() - (കയ്പരങ്ങി)  ": false,
    "() - (ഒടുക്ക്)  ": false,
    "() - (വാട്ടപെരുവലം)  ": false,
  };
  var holder_1 = [];
  bool _getHolderCheck() {
    print("No_treee Bool $no_Tree");
    return int.parse(no_Tree) > 0;
  }

  // double _getVolume(double girth, double length) {
  //   v = ((girth * 0.01) / 4) * ((girth * 0.01) / 4) * length;
  //   return v;
  // }
  double _getVolume(double girth, double length) {
    // Convert girth from cm to meters
    double girthInMeters = girth * 0.01;

    // Calculate the radius from the girth
    double radius = girthInMeters / (2 * pi);

    // Calculate the volume of the cylinder
    double volume = pi * pow(radius, 2) * length;

    return volume;
  }

  Widget getTextV(BuildContext context, double girth, double length) {
    return Text((_getVolume(girth, length).toString()).toString());
  }

  List log_details = [];
  List d = [];
  List Species = [];
  List Length = [];
  List Girth = [];
  List Volume = [];
  List Latitude = [];
  List Longitude = [];
  List n_list = [];
  bool flag_no = false;
  bool flag_Log = false;

  int _radioValue = 0;
  int _radioValue2 = 0;
  bool flag_land = false;
  bool flag_sp = false;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      if (_radioValue == 1) {
        maintenance = 'YES';
        setState(() {
          flag_land = true;
        });
      } else if (_radioValue == 2) {
        maintenance = 'NO';
        setState(() {
          flag_land = false;
        });
      }
    });
  }

  int num1 = 0;
  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioValue2 = value;
      if (_radioValue2 == 11) {
        maintenance = 'YES';
        setState(() {
          flag_sp = true;
        });
      } else if (_radioValue2 == 22) {
        maintenance = 'NO';
        setState(() {
          flag_sp = false;
        });
      }
    });
  }

  final bool _showSpecias = false;
  final List<String> speciasTextList = [
    'Rosewood(Dalbergia latifolia)',
    'Teak(Tectona grandis) ',
    'Thempavu(Terminalia tomantosa)',
    'Chadachi(Grewia tiliaefolia)',
    'Chandana vempu(Cedrela toona)',
    'Vellakil(Dysoxylum malabaricum)',
    'Irul(Xylia xylocarpa)',
    'Ebony(Diospyrus sp.)',
    'Kampakam(Hopea Parviflora)'
  ];

  getItems() {
    selectedList.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });
    print(holder_1);
  }

  void getCurrentLocation3() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    var posi4 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    setState(() {
      //  locaionmsg="$posi1.latitude,$posi1.longitude";
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      LoadData();
      getCurrentLocation3();
    });
  }

  bool sp_value = false;
  Map<String, bool> selectedList = {};
  void switchSpeciesList(int selectedValue) {
    setState(() {
      if (selectedValue == 2) {
        holder_1.clear();
        selectedList = SpeciasListB;
        sp_value = true;
        log_details = [];
        n_list = [];
        updateDropdown();
      } else if (selectedValue == 11) {
        selectedList = SpeciasList;
        holder_1.clear();
        updateDropdown();
        sp_value = true;
      } else if (selectedValue == 1) {
        selectedList = {};
        sp_value = false;
        log_details = [];
        n_list = [];
        holder_1.clear();
        updateDropdown();
      } else {
        holder_1.clear();
        selectedList = {};
        sp_value = false;
        log_details = [];
        n_list = [];
        updateDropdown();
      }
    });
  }

  void updateDropdown() {
    // Logic to dynamically update holder_1
    // ...

    // Reset dropdownValue3 if it doesn't exist in the updated holder_1
    if (!holder_1.contains(dropdownValue3)) {
      dropdownValue3 =
          null; // or assign a default value that exists in holder_1
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Form II - Notified",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Text(
                  'Is extent of land below 1 Ha?  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 15),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              'Yes',
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            value: 1,
                            groupValue: _radioValue,
                            // onChanged: _handleRadioValueChange,
                            onChanged: (value) {
                              switchSpeciesList(value!);
                              setState(() {
                                _handleRadioValueChange(value);
                                _showPopupMessage1(context);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: Text(
                                'No',
                                style: TextStyle(fontFamily: 'Lato'),
                              ),
                              value: 2,
                              groupValue: _radioValue,
                              onChanged: (value) {
                                switchSpeciesList(value!);
                                _handleRadioValueChange(value);
                                setState(() {
                                  _radioValue = value;
                                });
                              }),
                        ),
                      ]),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (flag_land == true) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 200,
                                    child: Scrollbar(
                                      thumbVisibility:
                                          true, // Show the scrollbar always
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: speciasTextList
                                              .map((text) =>
                                                  ListTile(title: Text(text)))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (flag_land == false) {
                            return SizedBox(
                              height: 0,
                              width: 0,
                            );
                          }
                          return Container();
                        },
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (flag_land == true) {
                            return Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Text(
                                  'Are you applying for any of the 9 specified trees given above?  ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  child: RadioListTile(
                                      title: Text(
                                        'Yes',
                                        style: TextStyle(fontFamily: 'Lato'),
                                      ),
                                      value: 11,
                                      groupValue: _radioValue2,
                                      onChanged: (value) {
                                        switchSpeciesList(value!);
                                        _handleRadioValueChange2(value);
                                        setState(() {
                                          _radioValue2 = value;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      'No',
                                      style: TextStyle(fontFamily: 'Lato'),
                                    ),
                                    value: 22,
                                    groupValue: _radioValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        _handleRadioValueChange2(value!);
                                        _showPopupMessage(context);
                                      });
                                    },
                                  ),
                                ),
                              ])
                            ]);
                          } else if (flag_land == false) {
                            return SizedBox(
                              height: 0,
                              width: 0,
                            );
                          }
                          return Container();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 20, bottom: 0),
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: const TextSpan(children: <TextSpan>[
                            TextSpan(
                                text:
                                    "Division                                Range",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                          ]),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(top: 8, left: 15, right: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10, bottom: 0),
                        child: Row(
                          children: <Widget>[
                            DropdownButton<String>(
                              value: divisionData,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              hint: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Select Division",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                              onChanged: (String? data) {
                                setState(() {
                                  divisionData = data!;
                                });
                              },
                              items: divisions
                                  .toSet()
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                            Spacer(),
                            DropdownButton<String>(
                              value: rangeData,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              hint: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Select Range",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                              onChanged: (String? data) {
                                setState(() {
                                  rangeData = data ?? '';
                                });
                              },
                              items: ranges
                                  .toSet()
                                  .toList()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: Name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              // border: OutlineInputBorder(),
                              labelText: 'Name ',
                              hintText: 'Enter Your Name',
                              suffixIcon: RichText(
                                text: TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: Address,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            labelText: 'Address',
                            hintText: 'Enter Your Address',
                            suffixIcon: RichText(
                              text: TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: survey_no,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14.0)),
                            ),
                            labelText: 'Survey Number',
                            hintText: 'Enter Survey Number',
                            suffixIcon: RichText(
                              text: TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: Tree_Proposed_to_cut,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              labelText: 'Number of trees proposed to be cut.',
                              hintText: 'Enter Number of Trees',
                              suffixIcon: RichText(
                                text: TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            onChanged: (value) {
                              no_Tree = value;
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: DistrictCo,
                            enabled: false, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'District',
                                hintText: 'Enter Your District'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: TalukCo,
                            enabled: false, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Taluk',
                                hintText: 'Enter Your Taluk'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: blockCo,
                            enabled: true, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14.0)),
                                ),
                                labelText: 'Block (optional)',
                                hintText: 'Enter Your Block'),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: villageCo,
                            enabled: false, // Make the TextField non-editable
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14.0)),
                                ),
                                // border: OutlineInputBorder(),
                                labelText: 'Village ',
                                hintText: 'Enter Your Village'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextField(
                            controller: pincodeCo,
                            enabled: true, // Make the TextField non-editable
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14.0)),
                              ),
                              // border: OutlineInputBorder(),
                              labelText: 'Pincode ',
                              hintText: 'Enter Your Pincode',
                              suffixIcon: RichText(
                                text: TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ),
                      Row(children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 13, top: 15),
                          child: Text(
                            'Species of tree or trees proposed to be cut:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                      Visibility(
                        visible: sp_value,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                              // Your decoration properties
                              ),
                          child: Scrollbar(
                            // Wrap your ListView with Scrollbar
                            thumbVisibility: true, // Show the scrollbar always
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: selectedList.keys.map((String key) {
                                return CheckboxListTile(
                                  title: Text(key),
                                  value: selectedList[key],
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  onChanged: (bool? value) {
                                    holder_check = _getHolderCheck();
                                    if (int.parse(no_Tree) > 0 &&
                                        holder_check) {
                                      if (value == true) {
                                        if (holder_1.length <
                                            int.parse(no_Tree)) {
                                          holder_1.add(key);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg:
                                                "You can only add $no_Tree species",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 18.0,
                                          );
                                          return;
                                        }
                                      } else {
                                        holder_1.remove(key);
                                      }
                                      setState(() {
                                        selectedList[key] = value!;
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10, bottom: 0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          value: selectedPurpose,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          hint: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Select Purpose",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ), // Initially selected value (can be null)
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPurpose =
                                  newValue; // Now accepts nullable String
                            });
                          },
                          items: <String>['Personal', 'Commercial']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              LayoutBuilder(builder: (context, constraints) {
                                if (flag1 == true) {
                                  return Column(
                                    children: [
                                      Column(children: [
                                        LayoutBuilder(
                                            builder: (context, constraints) {
                                          print(n_list.length);
                                          int textValue = 0;
                                          if (Tree_Proposed_to_cut.text == "") {
                                            textValue = 0;
                                          } else {
                                            textValue = int.parse(
                                                Tree_Proposed_to_cut.text);
                                          }
                                          return Builder(
                                            builder: (context) {
                                              if (textValue > n_list.length) {
                                                flag_no = true;
                                                flag_Log = true;

                                                print("Flag_No $flag_no");
                                                return Text(
                                                  "Add log details for all trees",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16),
                                                );
                                              } else {
                                                flag_no = false;
                                                print("Flag_No F $flag_no");
                                                return Text(
                                                  "",
                                                  style: TextStyle(fontSize: 1),
                                                );
                                              }
                                            },
                                          );
                                        })
                                      ]),
                                      Visibility(
                                        visible: flag_Log,
                                        child: Container(
                                            margin: const EdgeInsets.all(10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.29,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 0.0,
                                                  offset: Offset(2.0,
                                                      2.0), // shadow direction: bottom right
                                                )
                                              ],
                                            ),
                                            child: Scrollbar(
                                                thumbVisibility: true,
                                                thickness: 15,
                                                child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        children: <Widget>[
                                                          DataTable(
                                                            columns: [
                                                              DataColumn(
                                                                  label: Text(
                                                                'S.No',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blue),
                                                              )),
                                                              DataColumn(
                                                                  label: Text(
                                                                'Species  ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blue),
                                                              )),
                                                              DataColumn(
                                                                label: Row(
                                                                  children: <Widget>[
                                                                    Text(
                                                                      'GBH (cm)',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .info),
                                                                      onPressed:
                                                                          () {
                                                                        // Show a dialog or tooltip with the additional information
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return AlertDialog(
                                                                              title: Text('Information'),
                                                                              content: Text(
                                                                                'Measured at a height of 1.4 meters above the ground.',
                                                                              ),
                                                                              actions: <Widget>[
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text('OK'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                  label: Text(
                                                                ' Height(M)   ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blue),
                                                              )),
                                                              DataColumn(
                                                                  label: Text(
                                                                ' Volume (m³) ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blue),
                                                              )),
                                                              DataColumn(
                                                                label: Row(
                                                                  children: <Widget>[
                                                                    Text(
                                                                      "Add log ",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    Visibility(
                                                                      visible:
                                                                          flag_no ==
                                                                              true,
                                                                      child:
                                                                          IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .add_circle,
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await showInformationDialog(
                                                                              context);

                                                                          setState(
                                                                              () {
                                                                            DataRow;
                                                                            exindex =
                                                                                exindex + 1;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                            rows: n_list
                                                                .map(((index) =>
                                                                    DataRow(
                                                                        cells: [
                                                                          DataCell(
                                                                              Text((index + 1).toString())),
                                                                          DataCell(SizedBox(
                                                                              width: 180,
                                                                              child: Text(
                                                                                log_details[index]['species_of_tree'].toString(),
                                                                              ))),
                                                                          DataCell(SizedBox(
                                                                              width: 100,
                                                                              child: Text(
                                                                                log_details[index]['breadth'].toString(),
                                                                              ))),
                                                                          DataCell(SizedBox(
                                                                              width: 100,
                                                                              child: Text(
                                                                                log_details[index]['length'].toString(),
                                                                              ))),
                                                                          DataCell(SizedBox(
                                                                              width: 100,
                                                                              child: Text(
                                                                                log_details[index]['volume'].toString(),
                                                                              ))),
                                                                          DataCell(
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Text("remove"),
                                                                              IconButton(
                                                                                icon: Icon(
                                                                                  Icons.remove_circle,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                onPressed: () {
                                                                                  flag_no = true;

                                                                                  log_details.removeAt(index);
                                                                                  n_list.removeLast();

                                                                                  setState(() {
                                                                                    DataRow;
                                                                                  });
                                                                                },
                                                                              ), //--------------Remove Button
                                                                              Text("edit"),
                                                                              IconButton(
                                                                                icon: Icon(
                                                                                  Icons.edit_rounded,
                                                                                  color: Colors.blue,
                                                                                ),
                                                                                onPressed: () async {
                                                                                  await EditInformationDialog(context, index);
                                                                                  setState(() {
                                                                                    DataRow;
                                                                                  });
                                                                                },
                                                                              )
                                                                            ],
                                                                          )),
                                                                        ])))
                                                                .toList(),
                                                          ),
                                                        ],
                                                      ),
                                                    )))),
                                      ),
                                    ],
                                  );
                                } else if (flag1 == false) {
                                  return Container(
                                    color: Colors.white,
                                  );
                                }
                                return Container();
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.green,
                            ),
                            onPressed: () {
                              if (_radioValue == 0) {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please tick about extend of land details",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (divisionData == null) {
                                Fluttertoast.showToast(
                                    msg: "Please select Division ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (rangeData == null) {
                                Fluttertoast.showToast(
                                    msg: "Please select Range ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (Name.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add Applicant Name ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (Address.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add Applicant Address ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (survey_no.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add Survay Number",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (selectedPurpose == null) {
                                Fluttertoast.showToast(
                                    msg: "Please add Purpose ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (pincodeCo.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add Applicant Pincode ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (holder_1.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please select Specias types ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (log_details.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please add Log details ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else
                                num1 = int.parse(Tree_Proposed_to_cut.text);
                              if (log_details.length != num1) {
                                Fluttertoast.showToast(
                                    msg: "Please add $num1 tree log ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              } else if (divisionData != null &&
                                  _radioValue != 0 &&
                                  rangeData != null &&
                                  Name.text.isNotEmpty &&
                                  Address.text.isNotEmpty &&
                                  survey_no.text.isNotEmpty &&
                                  selectedPurpose != null &&
                                  pincodeCo.text.isNotEmpty &&
                                  holder_1.isNotEmpty &&
                                  log_details.isNotEmpty &&
                                  log_details.length == num1) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => transitPassNotified2(
                                        formOneIndex: formOneIndex,
                                        sessionToken: sessionToken,
                                        userName: userName,
                                        userEmail: userEmail,
                                        userId: userId,
                                        userGroup: userGroup,
                                        Name_: Name.text,
                                        Division_: divisionData!,
                                        range_: rangeData!,
                                        address_: Address.text,
                                        survey_no_: survey_no.text,
                                        tree_no_cut: no_Tree,
                                        district_: DistrictCo.text,
                                        taluke_: TalukCo.text,
                                        block_: blockCo.text,
                                        village_: villageCo.text,
                                        pincode_: pincodeCo.text,
                                        holder_1: holder_1,
                                        purpose_: selectedPurpose!,
                                        log_details: log_details),
                                  ),
                                );
                                setState(() {});
                              }
                            },
                            child: Text(" NEXT ")),
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.navigate_next),
        //     backgroundColor: HexColor("#0499f2"),
        //     onPressed: () {
        //       if (_radioValue == 0) {
        //         Fluttertoast.showToast(
        //             msg: "Please tick about extend of land details",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (divisionData == null) {
        //         Fluttertoast.showToast(
        //             msg: "Please select Division ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (rangeData == null) {
        //         Fluttertoast.showToast(
        //             msg: "Please select Range ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (Name.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Applicant Name ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (Address.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Applicant Address ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (survey_no.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Survay Number",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (selectedPurpose == null) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Purpose ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (pincodeCo.text.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Applicant Pincode ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (holder_1.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please select Specias types ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (log_details.isEmpty) {
        //         Fluttertoast.showToast(
        //             msg: "Please add Log details ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else
        //         num1 = int.parse(Tree_Proposed_to_cut.text);
        //       if (log_details.length != num1) {
        //         Fluttertoast.showToast(
        //             msg: "Please add $num1 tree log ",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.CENTER,
        //             timeInSecForIosWeb: 1,
        //             backgroundColor: Colors.red,
        //             textColor: Colors.white,
        //             fontSize: 18.0);
        //       } else if (divisionData != null &&
        //           _radioValue != 0 &&
        //           rangeData != null &&
        //           Name.text.isNotEmpty &&
        //           Address.text.isNotEmpty &&
        //           survey_no.text.isNotEmpty &&
        //           selectedPurpose != null &&
        //           pincodeCo.text.isNotEmpty &&
        //           holder_1.isNotEmpty &&
        //           log_details.isNotEmpty &&
        //           log_details.length == num1) {
        //         print(log_details.length);
        //         Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => transitPassNotified2(
        //                 formOneIndex: formOneIndex,
        //                 sessionToken: sessionToken,
        //                 userName: userName,
        //                 userEmail: userEmail,
        //                 userId: userId,
        //                 userGroup: userGroup,
        //                 Name_: Name.text,
        //                 Division_: divisionData,
        //                 range_: rangeData,
        //                 address_: Address.text,
        //                 survey_no_: survey_no.text,
        //                 tree_no_cut: no_Tree,
        //                 district_: DistrictCo.text,
        //                 taluke_: TalukCo.text,
        //                 block_: blockCo.text,
        //                 village_: villageCo.text,
        //                 pincode_: pincodeCo.text,
        //                 holder_1: holder_1,
        //                 purpose_: selectedPurpose,
        //                 log_details: log_details),
        //           ),
        //         );
        //         setState(() {});
        //       }
        //     }),
      ),
    );
  }

  String? dropdownValue3;
  String spacies_holder = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                          });
                        },
                        items: holder_1
                            .map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: length,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter Height(M)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter GBH(cm)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter GBH(cm)"),
                      ),
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: const Text(
                    'OK ',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.isEmpty) ||
                        (girth.text.isEmpty)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else
                      Len = double.parse(girth.text);
                    if (dropdownValue3 == "Thempavu(Terminalia tomantosa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Thempavu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Rosewood(Dalbergia latifolia)" &&
                        Len < 150) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Rosewood should be 150 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Teak(Tectona grandis) " &&
                        Len < 60) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Teak should be 60 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Kampakam(Hopea Parviflora)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Kampakam should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chadachi(Grewia tiliaefolia)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chadachi should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chandana vempu(Cedrela toona)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chandana vempu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Vellakil(Dysoxylum malabaricum)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Vellakil should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Irul(Xylia xylocarpa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Irul should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Ebony(Diospyrus sp.)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Ebony should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                      };
                      log_details.add(logs);
                      int n = log_details.length;
                      n_list = [];
                      //
                      //  List n_list =[];
                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }

                      length.clear();
                      girth.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> EditInformationDialog(BuildContext context, int index) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          dropdownValue3 = log_details[index]['species_of_tree'];
          length.text = log_details[index]['length'];
          girth.text = log_details[index]['breadth'];
          volume.text = log_details[index]['volume'];

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<dynamic>(
                        value: dropdownValue3,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        hint: Text("Species"),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (dynamic data) {
                          setState(() {
                            dropdownValue3 = data;
                          });
                        },
                        items: holder_1
                            .map<DropdownMenuItem<dynamic>>((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        //initialValue: log_details[index]['length'],
                        controller: length,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter height(M)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter height(M)"),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: girth,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter GBH(cm)";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter GBH(cm)"),
                      ),
                    ],
                  )),
              title: Text('Trees Logs'),
              actions: <Widget>[
                InkWell(
                  child: Text(
                    'OK ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    if ((dropdownValue3 == null) ||
                        (length.text.isEmpty) ||
                        (girth.text.isEmpty)) {
                      Fluttertoast.showToast(
                          msg: "Please add all details ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else
                      Len = double.parse(girth.text);
                    if (dropdownValue3 == "Thempavu(Terminalia tomantosa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Thempavu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Rosewood(Dalbergia latifolia)" &&
                        Len < 150) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Rosewood should be 150 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Teak(Tectona grandis) " &&
                        Len < 60) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Teak should be 60 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Kampakam(Hopea Parviflora)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Kampakam should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chadachi(Grewia tiliaefolia)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chadachi should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Chandana vempu(Cedrela toona)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Chandana vempu should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 ==
                            "Vellakil(Dysoxylum malabaricum)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Vellakil should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Irul(Xylia xylocarpa)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Irul should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else if (dropdownValue3 == "Ebony(Diospyrus sp.)" &&
                        Len < 75) {
                      Fluttertoast.showToast(
                          msg: "Minimum GBH of Ebony should be 75 cm",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18.0);
                    } else {
                      Map<String, dynamic> logs = {
                        "species_of_tree": dropdownValue3,
                        "length": length.text,
                        "breadth": girth.text,
                        "volume": _getVolume(
                                (double.parse(
                                    girth.text == "" ? '0' : girth.text)),
                                (double.parse(
                                    length.text == "" ? '0' : length.text)))
                            .toString(),
                      };

                      log_details[index] = logs;
                      int n = log_details.length;
                      n_list = [];

                      print(n);
                      for (int i = 0; i < n; i++) {
                        n_list.add(i);
                      }

                      if (_formKey.currentState!.validate()) {
                        length.clear();
                        girth.clear();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            );
          });
        });
  }

  Future<bool> _onBackPressed() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to go previous page'),
        content: const Text('Changes you made may not be saved.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("YES"),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  String villageTaluka = "";
  String villageDist = "";

  List<String> ranges = [];
  List<String> divisions = [];
  LoadData() async {
    int DL = 0;
    const String url =
        'https://f4020lwv-8000.inc1.devtunnels.ms//api/auth/villages/';
    Map data = {
      "village": village__,
    };

    var body = json.encode(data);

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: body);

    Map<String, dynamic> responseJson = json.decode(response.body);
    villageTaluka = responseJson['data']['village_taluka'];
    villageDist = responseJson['data']['village_dist'];

    List<dynamic> possibilityList = responseJson['data']['possibility'];
    for (var possibility in possibilityList) {
      String range = possibility['range'];
      String divi = possibility['division'];
      divisions.add(divi);
      ranges.add(range);
    }

    setState(() {
      TalukCo.text = villageTaluka;
      DistrictCo.text = villageDist;
      villageCo.text = village__;
    });
  }

  void _showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.red), // Set the border color
            ),
            title: const Text('Popup Message'),
            content: const Text(
                'As per Section 6(3)(ii) of the The Kerala Promotion of Tree Growth in Non-forest areas Act , 2005, such prior permission is not required  for the cutting and removal of trees mentioned in the schedule'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(
                        sessionToken: sessionToken,
                        userName: userName,
                        userEmail: userEmail,
                        userId: userId,
                        userMobile: '', // Add default value
                        userAddress: '', // Add default value
                        userProfile: '', // Add default value
                        userGroup: '', // Add default value
                        userCato: '', // Add default value
                      ),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPopupMessage1(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.red), // Set the border color
            ),
            title: const Text('Popup Message'),
            content: const Text(
                'As per Section 6(3)(i) of the The Kerala Promotion of Tree Growth in Non-forest areas Act , 2005 the small holders in the area notified under this sub section are free to cut and remove any tree except the specified trees.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
