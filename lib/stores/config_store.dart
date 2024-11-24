import 'dart:developer';

import 'package:flutter/material.dart';

class ConfigStore with ChangeNotifier {
  static final ConfigStore _singleton = ConfigStore._internal();
  BuildContext? currentContext;
  String identityUrl = "";
  String apiUrl = "";
  String loginUrl = "";
  static const primaryColor = Color(0xFF00233F);
  String currentCluster = "";
  String accessToken = "";
  String generalError = "Ops, Unexpected error!";
  String clientIdKey = "CF-Access-Client-Id";
  String clientId = "fce78ac176cc5d530e261ab78cf8df50.access";
  String clientSecretKey = "CF-Access-Client-Secret";
  String clientSecret =
      "3f8959653fb5f1ebbd5c19dd7244bef2000d91d60e42ca5262ceaa6d18f14e8b";

  factory ConfigStore() {
    return _singleton;
  }

  ConfigStore._internal() {
    identityUrl = "";
    apiUrl =
        "http://localhost:3000/metrics"; //"https://agent-test.moniple.com/metrics"; //  "http://localhost:3000/metrics"; //
    loginUrl = "$identityUrl/connect/apptoapp";
  }

  setAccessToken(String token) {
    debugPrint(token);
    accessToken = token;
  }

  setApiUrl(String url) {
    log(url);
    apiUrl = "$url/metrics";
    notifyListeners();
  }

  clearAccessToken() {
    accessToken = "";
  }

  String getAccessToken() {
    return accessToken;
  }

  setCurrentContext(BuildContext context) {
    currentContext = context;
  }

  static Color getTresholdColor(int usage) {
    var color = Colors.green.withAlpha(80);
    if (usage > 80) {
      color = Colors.red.withAlpha(80);
    } else if (usage > 60) {
      color = Colors.orange.withAlpha(80);
    }
    return color;
  }
}
