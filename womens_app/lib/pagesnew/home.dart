import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:womens_app/components/button_with_loading.dart';
import 'package:womens_app/controllers/loadingbtn.dart';
import 'package:womens_app/pagesnew/login.dart';
import 'package:womens_app/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void logOut() async {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("user is logged in succesfully"),
            MyLoadingButton(
              onTap: () async {
                authController.setLoading(true);
                // print("function on home is called");
                try {
                  await Future.delayed(const Duration(seconds: 1));
                  AuthService().signOut();
                } finally {
                  authController.setLoading(false);
                }
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user == null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  }
                });
              },
              label: "Log out",
            )
          ],
        ),
      ),
    );
  }
}
