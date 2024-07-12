import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoe_project/utils/constants/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoboard();
  }

  gotoboard() async {
    await Future.delayed(Durations.extralong4);
    Get.toNamed(Kroutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/Nike.png'),
      ),
    );
  }
}
