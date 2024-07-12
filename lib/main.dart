import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoe_project/features/authentication/login/login_screen.dart';
import 'package:shoe_project/features/onboarding/onboarding_screen.dart';
import 'package:shoe_project/features/splash_screen/splash_screen.dart';
import 'package:shoe_project/utils/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Kroutes.splash,
        routes: {
          Kroutes.splash: (context) => SplashScreen(),
          Kroutes.onboarding: (context) => OnboardingScreen(),
          Kroutes.login: (context) => SignInPage(),
        },
      ),
    );
  }
}
