import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_social_type.dart';
import 'package:shoe_project/common/widget/button.dart';
import 'package:shoe_project/data/repository/authRepository.dart';
import 'package:shoe_project/utils/constants/routes.dart';
import 'package:shoe_project/utils/validators/auth.dart';

import '../../../data/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "sign_in_page";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool passwordSee = true;
  bool showModal = false;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Authrepository authService = AuthService();
    return Scaffold(
      primary: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 100.w,
                height: 100.h,
              ),
              const Center(
                child: Text(
                  "Welcome \nRegister to continue!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 100.w,
                height: 100.h,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async => await authService.signInWithGoogle(),
                    child: MyButton(
                      iconUrl: 'assets/images/ic_google.png',
                      text: "Log in with Google",
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Get.toNamed(Kroutes.home),
                    child: MyButton(
                      iconUrl: 'assets/images/ic_facebook.png',
                      text: "Log in with Facebook",
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Or",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Form(
                key: _signInGlobalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: AuthValidator.isNameValid,
                      decoration: const InputDecoration(hintText: "name"),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: AuthValidator.isEmailValid,
                      decoration:
                          const InputDecoration(hintText: "email address"),
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordSee,
                      validator: AuthValidator.isPasswordValid,
                      decoration: InputDecoration(
                        hintText: "password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            passwordSee = !passwordSee;
                            setState(() {});
                          },
                          child: Icon(
                            passwordSee
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
              Column(
                children: [
                  MyButtonTwo(
                      text: "Register",
                      onPressed: () => authService.createUser(
                          emailController.text, passwordController.text)),
                  const SizedBox(height: 30),
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xFF265AE8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(context) {
    showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 1,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: 800,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34), topRight: Radius.circular(34))),
        child: Container(
            width: 320.w,
            height: 300.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            )),
      ),
    );
    // if (_signInGlobalKey.currentState!.validate()) {
    //   final message = authController.login(
    //     emailController.text.trim(),
    //     passwordController.text.trim(),
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(message["message"] as String),
    //       margin:
    //           EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .9),
    //       behavior: SnackBarBehavior.floating,
    //       duration: const Duration(seconds: 5),
    //       shape: const StadiumBorder(),
    //       dismissDirection: DismissDirection.horizontal,
    //       showCloseIcon: true,
    //     ),
    //   );
    //   if (message["next"] == "next") {
    //     AppWidget.isLogin = true;
    //     AppWidget.loggedUser["email"] = emailController.text.trim();
    //     AppWidget.loggedUser["password"] = passwordController.text.trim();
    //     Navigator.pushNamed(context, AdminPage.id);
    //   }
    // }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
