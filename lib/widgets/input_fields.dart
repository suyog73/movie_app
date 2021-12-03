import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/helper/constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.label,
    this.validator,
    required this.controller,
    required this.onChange,
    required this.icon,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final ValueSetter<String> onChange;
  final FormFieldValidator<String>? validator;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: const TextStyle(
        //     fontSize: 17,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.black,
        //   ),
        // ),
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
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
