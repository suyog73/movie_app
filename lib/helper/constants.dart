import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

const kTextFormFieldDec = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent),
  ),
);

const kTextStyle = TextStyle(color: Colors.black87, fontSize: 15);

PageDecoration kGetPageDecoration() => PageDecoration(
      boxDecoration: BoxDecoration(gradient: kLinearGradient),
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24),
      // pageColor: Colors.white,
    );

DotsDecorator kGetDotDecoration() => DotsDecorator(
      color: Color(0xFFBDBDBD),
      //activeColor: Colors.orange,
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

LinearGradient kLinearGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xfffb7ba2),
    Color(0xfffce043),
  ],
);

const kTextFormFieldAuthDec = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
  ),
);
