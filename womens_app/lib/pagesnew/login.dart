import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:womens_app/components/button_with_loading.dart';
import 'package:womens_app/controllers/loadingbtn.dart';
import 'package:womens_app/pagesnew/signup.dart';
import 'package:womens_app/services/auth_service.dart';
import 'package:womens_app/components/email_field.dart';
import 'package:womens_app/components/password_field.dart';
import 'package:womens_app/components/square_tile.dart';
import 'package:womens_app/pagesnew/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //getx controller
  AuthController authController = Get.put(AuthController());
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _emailformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  // sign user up method

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      // backgroundColor: ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // logo
            Column(
              children: [
                Image.asset(
                  'lib/images/logo.png', // Path to your custom icon
                  // width: 200,
                  width: screenWidth * .482,
                  height: screenWidth * .4,
                  // height: 100,
                ),
                //quote
                Text(
                  'Where everyone has the right to live!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            // const SizedBox(height: 25),
            //sign in text
            Text(
              "Sign-In",
              style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: screenWidth * 0.087,
                  fontWeight: FontWeight.w600),
            ),

            // const SizedBox(height: 25),
            // email and password form
            Form(
              child: Column(
                children: [
                  //email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Username',
                    obscureText: false,
                    formKey: _emailformKey,
                  ),
                  const SizedBox(height: 10),

                  // password textfield
                  PasswordField(
                    controller: passwordController,
                    hintText: 'Password',
                    formKey: _passwordFormKey,
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 10),

            // forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            //   const SizedBox(height: 25),

            // sign in button
            MyLoadingButton(
              onTap: () async {
                // Show loading dialog
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (BuildContext context) {
                //     return const LoadingIndicator(
                //         message: 'Signing you in. Just a moment...');
                //   },
                // );
                final bool isEmailValid =
                    _emailformKey.currentState?.validate() ?? false;

                if (isEmailValid) {
                  //}
                  authController.setLoading(true);
                  await Future.delayed(const Duration(seconds: 1));
                  try {
                    String? result = await AuthService().signIn(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    if (result == "Sign in successful") {
                      //remove loading dialog
                      // Navigator.of(context).pop();
                      // go to next page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    } else {
                      //remove loading dialog
                      // Navigator.of(context).pop();
                      // Show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result!)),
                      );
                    }
                  } finally {
                    authController.setLoading(false);
                  }
                }
              },
              label: "Sign In",
            ),

            //  const SizedBox(height: 25),

            // or login with
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
                      'Or continue with',
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

            //   const SizedBox(height: 25),

            // google + apple sign in buttons
            Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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

                const SizedBox(height: 13),

                //new?register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  (const SignupWithLoadingbtn())),
                        );
                      },
                      child: const Text(
                        'Register here',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //     // height: 60,
            //     // :  * .1,
            //     ),
            Padding(
              // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Privacy Policy"), Text("Help!")],
              ),
            )
          ],
        ),
      ),
    );
  }
}
