import 'package:flutter/material.dart';
import 'package:womens_app/validators/validation.dart';

class phoneTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final GlobalKey<FormState> formKey;
  // final String? validationType;

  const phoneTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.formKey,
    // required this.validationType,
  });
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          validator: (value) {
            return (TValidator.validatePhoneNumber(value));
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            fillColor: Colors.grey.shade200,
            // prefixText: "91",
            // prefixStyle: TextStyle(
            //   color: const Color.fromARGB(255, 0, 0, 0),
            // ),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}
