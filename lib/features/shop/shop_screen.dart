import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoe_project/data/services/auth_service.dart';
import 'package:shoe_project/data/services/category_model.dart';
import 'package:shoe_project/data/services/sneakers_model.dart';
import 'package:shoe_project/data/services/sneakes_services.dart';
import 'package:shoe_project/features/shop/createCategory.dart';

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
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text("Nike shoes"),
          GFTextField(
            controller: _controller,
          ),
          Text("Timberland shoes"),
          GFTextField(
            controller: _controller1,
          ),
          Text("Sharp shoes"),
          GFTextField(
            controller: _controller2,
          ),
          FutureBuilder(
            future: _querySnapshot,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return GFLoader();
              }
              print(snapshot.data!.docs);
              var catLuist = snapshot.data!.docs;

              return GFDropdown(
                  value: cat.isEmpty ? catLuist[0].id : cat,
                  items: List.generate(
                    catLuist.length,
                    (value) => DropdownMenuItem(
                      child: Text(catLuist[value].id),
                      value: catLuist[value].id,
                    ),
                  ),
                  onChanged: (ob) {
                    setState(() {
                      cat = ob!;
                    });
                  });
            },
          ),
          SizedBox(
            height: 30,
          ),
          GFButton(
            onPressed: () async {
              var model = SneakersModel(
                  name: _controller.text,
                  description: _controller1.text,
                  price: int.parse(_controller2.text),
                  catergory: cat);

              var res = await seve.addSneakers(model);

              Get.showSnackbar(GetSnackBar(
                duration: Duration(seconds: 3),
                title: "Model Saved",
                message: "Model Saved with is $res",
              ));
            },
            child: Text("Create Category"),
          ),
          GFButton(
            onPressed: () {
              Get.to(() => CreateCategory());
            },
            child: Text("To creat Category"),
          )
        ],
      )),
    ));
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
