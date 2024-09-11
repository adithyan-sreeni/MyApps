import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:womens_app/validators/validation.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final GlobalKey<FormState> formKey;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: formKey,
        child: IntlPhoneField(
          controller: controller,
          decoration: InputDecoration(
            labelText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
          ),
          initialCountryCode: 'IN', // Set initial country to India
          onChanged: (phone) {
            // You can do additional validation or state management here if needed
            print(phone.completeNumber); // Get the complete number
          },
          validator: (value) {
            return TValidator.validatePhoneNumber(value?.completeNumber);
          },
        ),
      ),
    );
  }
}
