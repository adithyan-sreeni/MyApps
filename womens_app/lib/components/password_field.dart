import 'package:flutter/material.dart';
import 'package:womens_app/validators/validation.dart';

class PasswordField extends StatefulWidget {
  final controller;
  final String hintText;
  final GlobalKey<FormState> formKey;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.formKey,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  void inverter() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          controller: widget.controller,
          validator: (value) => TValidator.validatePassword(value),
          // (value) {
          //   return (TValidator.validatePassword(value));
          // },
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
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: inverter,
            ),
          ),
        ),
      ),
    );
  }
}
