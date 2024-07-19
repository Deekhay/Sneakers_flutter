import 'package:flutter/material.dart';

class SneakerDetailScreen extends StatelessWidget {
  const SneakerDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sneaker Shop"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.shop))],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: Text(
                "Nike Air Max 270 Essential",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Men’s Shoes",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\$197.36",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            Image.asset("assets/images/image2.png"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Image.asset(
                    "assets/images/image2.png",
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/image2.png",
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/image2.png",
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/image2.png",
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/image2.png",
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "The Max Air 270 unit delivers unrivaled, all-day comfort. The sleek, running-inspired design roots you to everything Nike........",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Read More..",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue))
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    radius: 24,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.shop))),
                FilledButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.shop_2_rounded),
                    label: Text("Add to cart"))
              ],
            )
          ]),
        ));
  }
}
