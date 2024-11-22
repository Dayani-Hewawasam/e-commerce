import 'package:flutter/material.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/298-2.JPEG",
    "images/303-maxi-1.JPEG",
    "images/hero2.png",
    "images/blackblouse-3.jpeg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 230, 244),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
            const SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here",
                    hintStyle: AppWidget.lightTextFeildStyle(),
                    prefixIcon: const Icon(Icons.search, color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: AppWidget.semiboldTextFeildStyle()),
                const Text("see all",
                    style: TextStyle(
                        color: Color(0xFFfd6f9e),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  height: 210.0,
                  padding: const EdgeInsets.all(23.0),
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 180, 135, 172),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text("All",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold))),
                ),
                Expanded(
                  child: SizedBox(
                    height: 210.0,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(image: categories[index]);
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Products", style: AppWidget.semiboldTextFeildStyle()),
                const Text("see all",
                    style: TextStyle(
                        color: Color(0xFFfd6f9e),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500))
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 300.0,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/298-2.JPEG",
                          height: 250.0,
                          width: 130.0,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "SF-298",
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "\$100",
                              style: TextStyle(
                                  color: Color.fromARGB(250, 153, 25, 238),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 50.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(250, 153, 25, 238),
                                  borderRadius: BorderRadius.circular(7)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/303-maxi-1.JPEG",
                          height: 250.0,
                          width: 130.0,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "SF-303",
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "\$100",
                              style: TextStyle(
                                  color: Color.fromARGB(250, 153, 25, 238),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 50.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(250, 153, 25, 238),
                                  borderRadius: BorderRadius.circular(7)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/290-3.JPEG",
                          height: 250.0,
                          width: 130.0,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "SF-290",
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text(
                              "\$100",
                              style: TextStyle(
                                  color: Color.fromARGB(250, 153, 25, 238),
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 50.0,
                            ),
                            Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(250, 153, 25, 238),
                                    borderRadius: BorderRadius.circular(7)),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String image;
  CategoryTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(07)),
      height: 180.0,
      width: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            height: 180.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          const Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}
