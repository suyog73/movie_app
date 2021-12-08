import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/helper/constants.dart';

class InputFields extends StatelessWidget {
  const InputFields({
    Key? key,
    required this.label,
    this.validator,
    required this.controller,
    required this.onChange,
    required this.icon,
    required this.keyBoardType,
    required this.textInputAction,
  }) : super(key: key);

  final String label;

  final TextEditingController controller;
  final ValueSetter<String> onChange;
  final FormFieldValidator<String>? validator;
  final IconData icon;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TextFormField(
          onChanged: onChange,
          controller: controller,
          decoration: kTextFormFieldDec.copyWith(
              prefixIcon: Icon(
                icon,
                color: Colors.lightBlueAccent,
              ),
              hintText: label),
          validator: validator,
          cursorColor: Colors.lightBlueAccent,
          keyboardType: keyBoardType,
          textInputAction: textInputAction,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
