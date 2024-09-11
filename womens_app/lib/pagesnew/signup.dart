import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:womens_app/components/button_with_loading.dart';
import 'package:womens_app/controllers/loadingbtn.dart';
import 'package:womens_app/pagesnew/login.dart';
import 'package:womens_app/services/auth_service.dart';
import 'package:womens_app/components/email_field.dart';
import 'package:womens_app/components/password_field.dart';
import 'package:womens_app/components/phone_field.dart';
import 'package:womens_app/components/square_tile.dart';

class SignupWithLoadingbtn extends StatefulWidget {
  const SignupWithLoadingbtn({super.key});

  @override
  State<SignupWithLoadingbtn> createState() => _SignupWithLoadingbtn();
}

class _SignupWithLoadingbtn extends State<SignupWithLoadingbtn> {
  //getx controlllers
  final AuthController authController =
      Get.put(AuthController()); //getx initialising new authContoller
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  final GlobalKey<FormState> _emailformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneformKey = GlobalKey<FormState>();

  String? userExists;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Image.asset(
                  'lib/images/logo.png', // Path to your custom icon
                  width: 150,
                  // height: 100,
                ),
                //quote
                Text(
                  'Where everyone has the right to live!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  "Sign-Up",
                  style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                ),
                if (userExists != null) // Display the user's email if it exists
                  Text(
                    'Succesfully registerd: $userExists',
                    style: const TextStyle(color: Colors.green, fontSize: 16),
                  ),
                const SizedBox(height: 25),
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email',
                  obscureText: false,
                  formKey: _emailformKey,
                  // validationType:
                  //     TValidator.validateEmail(usernameController.text),
                ),
                const SizedBox(height: 15),
                phoneTextField(
                  controller: numberController,
                  hintText: 'Phone Number(Optional)',
                  obscureText: false,
                  formKey: _phoneformKey,
                  // validationType:
                  //     TValidator.validatePhoneNumber(numberController.text),
                ),

                const SizedBox(height: 15),

                // password textfield
                PasswordField(
                  controller: passwordController,
                  hintText: 'Password', formKey: _passwordFormKey,
                  // obscureText: true,
                ),

                const SizedBox(height: 10),

                //create dialogs

                const SizedBox(height: 15),

                // sign in button
                MyLoadingButton(
                  onTap: () async {
                    final bool isEmailValid =
                        _emailformKey.currentState?.validate() ?? false;
                    final bool isPasswordValid =
                        _passwordFormKey.currentState?.validate() ?? false;
                    // final bool isPhoneValid =
                    //     _phoneformKey.currentState?.validate() ?? false;

                    if (isEmailValid && isPasswordValid
                        //  && isPhoneValid
                        ) {
                      authController.setLoading(true);
                      // Show loading dialog
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return const LoadingIndicator(
                      //         message:
                      //             'Setting up your account. Please hold on...');
                      //   },
                      // );

                      // Simulate a delay
                      // await Future.delayed(const Duration(seconds: 10));
                      try {
                        String? result = await AuthService().signUp(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                          numberController.text.trim(),
                        );

                        if (result == "Sign up successful") {
                          // Navigator.of(context)
                          //     .pop();
                          // Close the loading dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account created. Please log in.'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(result ?? 'An error occurred')),
                          );
                        }
                      } finally {
                        authController.setLoading(false); // End loading
                        // Navigator.of(context).pop(); // Ensure dialog is closed
                      }
                    }
                  },
                  label: "Sign-Up",
                ),

                const SizedBox(height: 25),

                // or Sign-up with google/apple text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Sign-up with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),

                const SizedBox(height: 50),
                // already have an account
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Login Here',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                //privacy policy and help
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Privacy Policy"), Text("Help!")],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
