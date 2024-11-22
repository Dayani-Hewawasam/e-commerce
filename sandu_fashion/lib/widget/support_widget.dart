import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle BoldTextFeildStyle() {
    return const TextStyle(
        color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold);
  }

  static TextStyle lightTextFeildStyle() {
    return const TextStyle(
        color: Colors.black54, fontSize: 20.0, fontWeight: FontWeight.w500);
  }

  static TextStyle semiboldTextFeildStyle() {
    return const TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);
  }
}
