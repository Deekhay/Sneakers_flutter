import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shoe_project/features/admin/category/createCategory.dart';
import 'package:shoe_project/features/admin/sneaker/createSneaker.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => CreateCategory());
              },
              child: const Text(
                "Create category",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF265AE8),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => CreateSneaker());
              },
              child: const Text(
                "Create Sneaker",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xFF265AE8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
