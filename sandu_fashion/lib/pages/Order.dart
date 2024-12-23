import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandu_fashion/Admin/admin_login.dart' as admin;
import 'package:sandu_fashion/services/database.dart';
import 'package:sandu_fashion/services/shared_pref.dart';
import 'package:sandu_fashion/widget/support_widget.dart' as support;

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? email;

  // Get the shared preferences (user email)
  getthesharedpref() async {
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  Stream<QuerySnapshot>? orderStream;

  // Load orders on initialization
  getontheload() async {
    await getthesharedpref();
    if (email != null) {
      orderStream = await DatabaseMethods().getorders(email!);
      setState(() {});
    }
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  // Widget to display all orders
  Widget allOrder() {
    return StreamBuilder<QuerySnapshot>(
      stream: orderStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        ds["ProductImage"] ?? '',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds["Product"] ?? 'Unknown Product',
                              style: support.AppWidget.semiBoldTextFeildStyle(),
                            ),
                            Text(
                              "\$${ds["Price"] ?? '0.00'}",
                              style: const TextStyle(
                                color: Color(0xFFfd6f3e),
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Status : ${ds["Status"] ?? 'Unknown'}",
                              style: const TextStyle(
                                color: Color(0xFFfd6f3e),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xfff2f2f2),
        title: Center(
          child: Text(
            "Current Orders",
            style: support.AppWidget.semiBoldTextFeildStyle(),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Expanded(
              child: allOrder(),
            ),
          ],
        ),
      ),
    );
  }
}
