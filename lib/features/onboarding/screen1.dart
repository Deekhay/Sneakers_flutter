import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [Image.asset('assets/images/Screen1/V1.png')],
              ),
              Image.asset('assets/images/image1.png'),
            ],
          ),
        ),
      ),
    );
  }
}
