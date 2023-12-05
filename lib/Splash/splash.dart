// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';

import '../Auth/login.dart';
import '../Specs/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatehome();
  }

  _navigatehome() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/splash.png", width: 200),
            SizedBox(height: 30),
            const Text(
              "ATU\nExpenses Tracker",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: BLUEBLACK),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
