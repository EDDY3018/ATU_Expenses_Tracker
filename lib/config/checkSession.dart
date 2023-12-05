
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/providers/userDetailsProvider.dart';
import 'repo.dart';
import 'sharePreference.dart';

Future<String> checkSession() async {
  String auth = "not auth";

  SharedPreferences? prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("auth")) {
    if (prefs.getBool("auth")!) {
      auth = "auth";
    } else {
      auth = "not auth";
    }
  } else {
    saveBoolShare(key: "auth", data: false);
    auth = "not auth";
  }

  // auth = "not auth";
  await Future.delayed(Duration(seconds: 3), () async {
    //load all data here
    Repository repo = new Repository();
    await repo.fetchUserDetails();
    if (userModel != null) {
      auth = "auth";
    } else {
      debugPrint("please log in");
      auth = "not auth";
    }
  });
  return auth;
}