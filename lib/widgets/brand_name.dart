import 'package:flutter/material.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        children: [
          TextSpan(text: "Aww", style: TextStyle(color: Colors.black87)),
          TextSpan(text: "Wallpapers", style: TextStyle(color: Colors.blue)),
        ]),
  );
}
