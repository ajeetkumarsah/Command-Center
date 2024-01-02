import 'package:get/get.dart';
import 'package:command_centre/mobile_dashboard/controllers/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response) {
    final AuthController controller =
        Get.put(AuthController(authRepo: Get.find()));
    if (response.statusCode == 401) {
      // controller.refreshToken();
    } else {
      // showCustomSnackBar(response.statusText ?? '');
    }
  }
}
