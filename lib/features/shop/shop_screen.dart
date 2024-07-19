import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoe_project/data/services/auth_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SneakerDetailScreen());
  }
}
