import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:womens_app/controllers/loadingbtn.dart';

class MyLoadingButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  // final bool isLoading; // New parameter to handle loading state

  const MyLoadingButton({
    super.key,
    required this.onTap,
    required this.label,
    // this.isLoading = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();  //getx finding
    return Obx(
      () => GestureDetector(
        onTap:  authController.isLoading.value? null : onTap, // Disable tap if loading
        child: Container(
          padding: const EdgeInsets.all(17),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Center(
            child: authController.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white, // Color of the spinner
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
