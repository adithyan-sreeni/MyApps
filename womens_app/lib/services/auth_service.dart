import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:womens_app/validators/firebase_auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign out
  Future<void> signOut() async {
    print("function is called 1");
    await _auth.signOut();
    print("function is called 2");
  }

  // Sign up with email and password
  Future<String?> signUp(
      String email, String password, String phoneNumber) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      // If the user is created successfully, store the phone number in Firestore
      if (user != null) {
        try {
          print("setstate is run ");
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'email': user.email,
            'phoneNumber': phoneNumber,
            // Add any other fields you want to store
          });
        } catch (e) {
          print('Failed to save user data to Firestore: $e');
        }
      }
      await Future.delayed(Duration(seconds: 1));
      await signOut();

      return "Sign up successful";
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException into TFirebaseAuthException
      TFirebaseAuthException customException = TFirebaseAuthException(e.code);
      return customException.message;
    }
  }

  // Sign in with email and password
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Sign in successful";
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException into TFirebaseAuthException
      TFirebaseAuthException customException = TFirebaseAuthException(e.code);
      return customException.message;
    }
  }

  // Check if a user is signed in
  User? get currentUser {
    return _auth.currentUser;
  }
}
