import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:assignment_test/dataModel/loginModel.dart';

class LoginRepository {
  final Dio _dio = Dio();

  Future<bool> postLoginData(Login login) async {
    final url = 'https://6570f99009586eff6642273e.mockapi.io/login';

    try {
      final response = await _dio.post(
        url,
        data: login.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      print('API Response: ${response.statusCode} - ${response.data}');

      if (response.statusCode == 201) {
        Get.snackbar("message", "Login successfully", snackPosition: SnackPosition.TOP);
        return true;
      } else {
        Get.snackbar("message", "Login failed", snackPosition: SnackPosition.TOP);
        return false;
      }
    } catch (e) {
      Get.snackbar("message", "Check Internet connection", snackPosition: SnackPosition.TOP);
      print('API Request Error: $e');
      return false;
    }
  }
}
