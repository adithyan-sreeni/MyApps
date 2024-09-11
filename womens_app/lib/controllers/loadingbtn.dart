import 'package:get/get.dart';

class AuthController extends GetxController {
  // Observable variable to track loading state
  var isLoading = false.obs;

  // Method to start loading
  void setLoading(bool loading) {
    isLoading.value = loading;
  }
}
