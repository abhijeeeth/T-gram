import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tigramnks/model/nocapprovedrejecedmodel.dart';
import 'package:tigramnks/model/nocforwardedlistmodel.dart';
import 'package:tigramnks/model/nocfreshapplictaionmodel.dart';
import 'package:tigramnks/model/nocpendinglistmodel.dart';
import 'package:tigramnks/model/nocviewmodel.dart';
import 'package:tigramnks/server/serverhelper.dart';

class Initializer {
  static NOCFreshapplicationModel nocFreshapplicationModel =
      NOCFreshapplicationModel();
  static NOCPendingModel nocPendingModel = NOCPendingModel();
  static NOCApprovedRejectedModel nocApprovedRejectedModel =
      NOCApprovedRejectedModel();
  static NOCForwardedListModel nocForwardedListModel = NOCForwardedListModel();
  static NOCListViewModel nocListViewModel = NOCListViewModel();

  static Future<dynamic> get(String url, String token) async {
    try {
      log(token.toString());
      // bool trustSelfSigned = true;
      // HttpClient httpClient = HttpClient()
      //   ..badCertificateCallback =
      //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
      // IOClient ioClient = IOClient(httpClient);
      var response = await http.get(
        Uri.parse(ServerHelper.baseUrl + url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "token $token"
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // if (jsonDecode(response.body)['msg']
        //     .contains("Your session has expired")) {
        //   // await expireCall.makeExpire();
        //   return {"status": false, "msg": "expired"};
        // } else {
        //   return response.body;
        // }
      } else {
        var error = {
          "status": false,
          "msg": "${response.statusCode} - ${response.reasonPhrase}"
        };
        return error;
      }
    } on Exception catch (e) {
      // Helper.showToast(msg: e.toString());
      log(e.toString());
      // throw NoHostException();
    }
  }

  static Future<dynamic> post(String url, Map data, String token) async {
    // var token = await LocalStorage.getToken();
    // log(token ?? "");
    log('${ServerHelper.baseUrl + url} -- $data');
    var body = json.encode(data);
    dynamic response;
    try {
      // bool trustSelfSigned = true;
      // HttpClient httpClient = HttpClient()
      //   ..badCertificateCallback =
      //       ((X509Certificate cert, String host, int port) => trustSelfSigned);
      // IOClient ioClient = IOClient(httpClient);
      response = await http
          .post(Uri.parse(ServerHelper.baseUrl + url),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "token $token"
              },
              body: body)
          .timeout(const Duration(seconds: 20));
      // log('${ip! + url} -- $data'); // loged
      if (response.statusCode == 200) {
        // Helper.showLog(response.body);
        return jsonDecode(response.body);
        // if (jsonDecode(response.body)['msg']
        //     .contains("Your session has expired")) {
        //   // await expireCall.makeExpire();
        //   return {"status": false, "msg": "expired"};
        // } else {

        // }
      } else {
        var error = {
          "status": false,
          "msg": "${response.statusCode} - ${response.reasonPhrase}"
        };
        return error;
      }
    } on Exception catch (e) {
      log(e.toString());
      // Helper.showToast(msg: e.toString());
      // throw NoHostException();
    }
  }
}
