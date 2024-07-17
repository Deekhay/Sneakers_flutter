import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoe_project/data/services/auth_service.dart';
import 'package:shoe_project/data/services/sneakes_services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder(
        future: seve.getDataAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('It has some errors yo');
          }

          print(snapshot.data?[0]);
          return auth.user == null
              ? Center(
                  child: Text('Data successful ${snapshot.data?[0]["name"]}'))
              : Center(
                  child: Text(
                      'Data successful ${snapshot.data?[0]["name"]} ${auth.user?.email}'));
        },
      ),
    ));
  }
}
