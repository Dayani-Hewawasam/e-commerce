import 'package:flutter/material.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 230, 244),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey, Sachi",
                      style: AppWidget.BoldTextFeildStyle(),
                    ),
                    Text(
                      "Good Morning",
                      style: AppWidget.lightTextFeildStyle(),
                    ),
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "images/hero2.png",
                      height: 70.0,
                      width: 70.0,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here",
                      hintStyle: AppWidget.lightTextFeildStyle()),
                ))
          ],
        ),
      ),
    );
  }
}
