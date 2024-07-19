import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoe_project/features/shop/shop_screen.dart';

import '../../data/services/category_model.dart';
import '../../data/services/sneakes_services.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final seve = SneakesServices();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CreateCategoryWidget(
      seve: seve,
      controller: _controller,
    );
  }
}

class CreateCategoryWidget extends StatelessWidget {
  const CreateCategoryWidget({
    super.key,
    required TextEditingController controller,
    required this.seve,
  }) : _controller = controller;

  final TextEditingController _controller;
  final SneakesServices seve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text("Category Name"),
        GFTextField(
          controller: _controller,
          validatornew: (value) {
            if (value!.length < 3) return "Not enough";
          },
        ),
        SizedBox(
          height: 30,
        ),
        GFButton(
          onPressed: () async {
            var model = CategoryModel(id: _controller.text);
            await seve.addCategory(model);
            Get.showSnackbar(const GetSnackBar(
              duration: Durations.long1,
              title: "Model Saved",
              message: "Model Saved",
            ));
          },
          child: Text("Create Category"),
        ),
        GFButton(
          onPressed: () {
            Get.to(() => ShopScreen());
          },
          child: Text("To creat Sneakers"),
        )
      ],
    )));
  }
}
