import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/firebase/firebaseAuth.dart';
import '../userModel.dart';

final _fetcher = BehaviorSubject<UserModel>();
Sink<UserModel> get _fetcherSink => _fetcher.sink;
Stream<UserModel> get userModelStream => _fetcher.stream;
UserModel? userModel;

class UserDetailsProvider {
  UserDetailsProvider() {
    // Initialize the stream with an initial value of userModel
    _fetcher.add(userModel!);
  }

  Future<void> get() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auth") && prefs.getBool("auth")!) {
      if (prefs.containsKey("userDetails")) {
        try {
          String encodedData = prefs.getString("userDetails")!;
          var decodedData = json.decode(encodedData);
          if (kDebugMode) {
            print(decodedData);
          }
          userModel = UserModel.fromJson(decodedData);
          firebaseUserId = userModel!.data!.firebaseId;
          _fetcherSink.add(userModel!);
        } catch (e) {
          // Handle the exception gracefully, e.g., log the error or show a message
          print("Error fetching user data: $e");
          userModel = null;
        }
      }
    } else {
      userModel = null;
    }
  }

  // Dispose the BehaviorSubject when no longer needed
  void dispose() {
    _fetcher.close();
  }
}
