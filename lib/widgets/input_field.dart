import 'package:flutter/material.dart';
import 'package:movie_app/helper/constants.dart';

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
    this.validator,
  }) : super(key: key);
  final bool isPassword;
  final TextInputType textInputType;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged onChange;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType: textInputType,
        controller: controller,
        onChanged: onChange,
        textInputAction: textInputAction,
        validator: validator,
        decoration: kTextFormFieldAuthDec.copyWith(
          prefixIcon: Icon(icon, color: Colors.redAccent),
          hintText: hintText,
        ),
      ),
    );
  }
}
