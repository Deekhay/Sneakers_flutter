import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoe_project/data/services/auth_service.dart';
import 'package:shoe_project/data/model/category_model.dart';
import 'package:shoe_project/data/model/sneakers_model.dart';
import 'package:shoe_project/data/services/sneakes_services.dart';
import 'package:shoe_project/features/shop/sneaker_detail/sneaker_detail_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final seve = SneakesServices();
  final auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int page = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShopScreenPage(),
      backgroundColor: Color(0xfff7f7f9),
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          animationDuration: Duration(seconds: 2),
          selectedIndex: page,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          indicatorColor: Colors.transparent,
          onDestinationSelected: (value) {},
          destinations: [
            NavigationDestination(
                icon: Icon(
                  size: 28,
                  Icons.home_outlined,
                  color: Colors.grey,
                ),
                label: "Shop"),
            NavigationDestination(
                icon: Icon(
                  size: 28,
                  Icons.favorite_outline_outlined,
                  color: Colors.grey,
                ),
                label: "Favourite"),
            Transform.translate(
              offset: Offset(0, -36),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: ColoredBox(
                  color: Color(0xfff7f7f9),
                  child: SizedBox(
                      width: 70,
                      height: 100,
                      child: Center(
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.blue,
                          child: NavigationDestination(
                              icon: Icon(
                                Icons.shop_outlined,
                                color: Colors.white,
                              ),
                              label: "Cart"),
                        ),
                      )),
                ),
              ),
            ),
            NavigationDestination(
                icon: Icon(
                  size: 28,
                  Icons.notifications_outlined,
                  color: Colors.blueGrey,
                ),
                label: "Notification"),
            NavigationDestination(
                icon: Icon(
                  size: 28,
                  Icons.person_4_outlined,
                  color: Colors.grey,
                ),
                label: "Profile")
          ]),
    );
  }
}

class ShopScreenPage extends StatefulWidget {
  const ShopScreenPage({Key? key}) : super(key: key);

  @override
  State<ShopScreenPage> createState() => _ShopScreenPageState();
}

class _ShopScreenPageState extends State<ShopScreenPage> {
  late SneakesServices _services;
  late Future<QuerySnapshot<CategoryModel>> allCategory;

  @override
  void initState() {
    // got sneaker service

    _services = SneakesServices();
    // called and fetched all category once
    allCategory = _services.getAllCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Explore"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.shop))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GFSearchBar(
                        searchBoxInputDecoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              size: 24,
                            ),
                            labelText: "Looking for Shoes",
                            labelStyle: TextStyle(color: Colors.black45),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.black26, width: 3)),
                            fillColor: Colors.white),
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        searchList: [],
                        overlaySearchListItemBuilder: (item) {
                          return const ListTile(
                            title: Text("data"),
                          );
                        },
                        searchQueryBuilder: (query, list) {
                          return [];
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 28,
                      child: Icon(Icons.filter),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Select Category",
                  style: TextStyle(fontSize: 27),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 60,
                  child: FutureBuilder(
                    // Used futurebuilder to get all category and render them
                    future: allCategory,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ColoredBox(
                                        color: Color(0xfff2f2f2),
                                        child: SizedBox(
                                          height: 45,
                                        ),
                                      ))),
                            ],
                          ),
                        );
                      }
                      print(snapshot.data!.docs);
                      var categoryList = snapshot.data!.docs;
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ColoredBox(
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 45,
                                    width: 120,
                                    child: Center(
                                        child: Text(
                                      categoryList[index].id,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    )),
                                  ),
                                ));
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                width: 20,
                              ),
                          itemCount: categoryList.length);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Popular Shoes",
                  style: TextStyle(fontSize: 27),
                ),
                // Do for shoes
              ],
            ),
          ),
        ),
      ),
    );
  }
}
