import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoe_project/data/services/auth_service.dart';
import 'package:shoe_project/data/services/category_model.dart';
import 'package:shoe_project/data/services/sneakers_model.dart';
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
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  late Future<QuerySnapshot<CategoryModel>> _querySnapshot;

  @override
  void initState() {
    _querySnapshot = seve.getAllCategory();
    // TODO: implement initState
    super.initState();
  }

  String cat = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SneakerDetailScreen());
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.seve,
    required this.auth,
  });

  final SneakesServices seve;
  final AuthService auth;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: seve.getDataAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('It has some errors yo');
        }

        print(snapshot.data?[0]);
        return auth.getUser == null
            ? Center(
                child: Text('Data successful ${snapshot.data?[0]["name"]}'))
            : Center(
                child: Text(
                    'Data successful ${snapshot.data?[0]["name"]} ${auth.getUser?.email}'));
      },
    );
  }
}
