import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tigramnks/model/nocapprovedrejecedmodel.dart';
import 'package:tigramnks/model/nocfreshapplictaionmodel.dart';
import 'package:tigramnks/model/nocpendinglistmodel.dart';
import 'package:tigramnks/server/serverhelper.dart';

class Initializer {
  static NOCFreshapplicationModel nocFreshapplicationModel =
      NOCFreshapplicationModel();
  static NOCPendingModel nocPendingModel = NOCPendingModel();
  static NOCApprovedRejectedModel nocApprovedRejectedModel =
      NOCApprovedRejectedModel();

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
}
