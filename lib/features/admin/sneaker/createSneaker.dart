import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shoe_project/data/model/sneakers_model.dart';
import 'package:shoe_project/features/shop/shop_screen.dart';

import '../../../data/model/category_model.dart';
import '../../../data/services/sneakes_services.dart';

class CreateSneaker extends StatefulWidget {
  const CreateSneaker({Key? key}) : super(key: key);

  @override
  _CreateSneakerState createState() => _CreateSneakerState();
}

class _CreateSneakerState extends State<CreateSneaker> {
  final seve = SneakesServices();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _pricecontroller = TextEditingController();
  final TextEditingController _descontroller = TextEditingController();
  late Future<QuerySnapshot<CategoryModel>> allCategory;

  @override
  void initState() {
    allCategory = seve.getAllCategory();
    // TODO: implement initState
    super.initState();
  }

  void clear() {
    _namecontroller.clear();
    _pricecontroller.clear();
    _descontroller.clear();
    setState(() {
      fileName = '';
      filePath = '';
    });
  }

  //   final String? name;
  // final int? price;
  // final String? description;
  // final List<String>? images;
  // final bool? hasDiscount;
  // final int? discountPercentage;
  // final String? catergory;

  String category = '';
  String? filePath;
  String? fileName;

  void setCategory(String value) {
    setState(() {
      category = value;
    });
  }

  void setFilePath(String value) {
    setState(() {
      filePath = value;
    });
  }

  void setFileName(String value) {
    setState(() {
      fileName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CreateCategoryWidget(
      seve: seve,
      controller: _namecontroller,
      price: _pricecontroller,
      desc: _descontroller,
      allCategory: allCategory,
      category: category,
      setCategory: setCategory,
      fileName: fileName,
      filePath: filePath,
      setFileName: setFileName,
      setFilePath: setFilePath,
      clear: clear,
    );
  }
}

class CreateCategoryWidget extends StatelessWidget {
  String category;

  var setCategory;

  var setFilePath;

  var setFileName;

  var clear;

  CreateCategoryWidget(
      {super.key,
      required TextEditingController controller,
      required this.seve,
      required this.price,
      required this.desc,
      required this.allCategory,
      required this.fileName,
      required this.filePath,
      required this.category,
      required this.setFilePath,
      required this.setFileName,
      required this.clear,
      required this.setCategory})
      : _controller = controller;

  final TextEditingController _controller;
  final SneakesServices seve;
  final TextEditingController price;
  final Future<QuerySnapshot<CategoryModel>> allCategory;

  final TextEditingController desc;

  final String? filePath;
  final String? fileName;

  Future<(String, String)> pickFile() async {
    try {
      // function for get files from your file explorere using file_picker package
      var path = await FilePicker.platform.pickFiles(
        type: FileType.image,
        compressionQuality: 30,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
      );

      print(path);
      var x = path!.files[0].path;
      var y = path!.files[0].name;
      // build apk and try on your device
      return (x!, y!);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Text("Sneaker Name"),
                GFTextField(
                  controller: _controller,
                  validatornew: (value) {
                    if (value!.length < 3) return "Not enough";
                  },
                ),
                Text("Sneaker price"),
                GFTextField(
                  controller: price,
                  validatornew: (value) {
                    if (value!.length < 3) return "Not enough";
                  },
                ),
                Text("Sneaker description"),
                GFTextField(
                  controller: desc,
                  validatornew: (value) {
                    if (value!.length < 3) return "Not enough";
                  },
                ),
                FutureBuilder(
                    future: allCategory,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) Text("waitiing for dropdown");
                      var res = snapshot.data!.docs;
                      return GFDropdown(
                        value: category.isEmpty ? res[0].id : category,
                        items: List.generate(
                            res.length,
                            (index) => DropdownMenuItem(
                                  child: Text(res[index].id),
                                  value: res[index].id,
                                )),
                        onChanged: (value) {
                          setCategory(value);
                        },
                      );
                    }),
                Text("Choose File"),
                GFButton(
                  onPressed: () async {
                    var (x, y) = await pickFile();
                    print(x);

                    setFileName(y);
                    setFilePath(x);
                  },
                  child: Icon(Icons.file_open),
                ),
                if (fileName != null) Text(fileName!),
                SizedBox(
                  height: 30,
                ),
                GFButton(
                  onPressed: () async {
                    // create model sneaker from input
                    var model = SneakersModel(
                        name: _controller.text,
                        price: int.parse(price.text),
                        description: desc.text,
                        images: [],
                        catergory: category);

                    Showloading(context);
                    //calls to add sneaker
                    var k = await seve.addSneakersWithImage(
                        model, filePath, fileName);

                    print(k);
                    // clear to clear all inputs
                    clear();
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

  void Showloading(context) {
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
          ),
          child: Center(
              child: SizedBox(height: 40, child: CircularProgressIndicator())),
        ),
      ),
    );
  }
}
