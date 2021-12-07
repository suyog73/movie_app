import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.isPassword = false,
    required this.textInputType,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.onChange,
    required this.textInputAction,
  }) : super(key: key);
  final bool isPassword;
  final TextInputType textInputType;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged onChange;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: textInputType,
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.redAccent.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}
