import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoe_project/features/onboarding/screen1.dart';
import 'package:shoe_project/features/onboarding/screen2.dart';
import 'package:shoe_project/features/onboarding/screen3.dart';
import 'package:shoe_project/utils/constants/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  late int initialPage;
  late List<Widget> slideList;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        GFIntroScreen(
          color: Color(0XFF1483C2),
          slides: slides(),
          pageController: _pageController,
          currentIndex: initialPage,
          pageCount: 3,
          introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
            pageController: _pageController,
            pageCount: slideList.length,
            currentIndex: initialPage,
            showButton: false,
            navigationBarHeight: 160.h,
            navigationBarPadding: EdgeInsets.only(bottom: 80),
            navigationBarColor: Colors.transparent,
            dividerHeight: 0,
            dividerColor: Colors.transparent,
            dotWidth: 50,
            dotHeight: 4,
            activeColor: Colors.white,
            inactiveColor: Colors.yellow,
          ),
        ),
        Positioned(
            bottom: 20.h,
            child: SizedBox(
              width: Get.width,
              child: Center(
                child: GFButton(
                  onPressed: () {
                    print(_pageController.page);
                    if (_pageController.page == slideList.length - 1) {
                      Get.toNamed(Kroutes.login);
                    } else {
                      _pageController.nextPage(
                          duration: Durations.long1, curve: Curves.decelerate);
                    }
                  },
                  child: Text("Click"),
                ),
              ),
            ))
      ],
    ));
  }

  List<Widget> slides() {
    slideList = [Screen1(), Screen2(), Screen3()];
    return slideList;
  }
}
