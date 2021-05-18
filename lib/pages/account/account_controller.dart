import 'package:get/get.dart';

class AccountController extends GetxController {
  final String name = Get.arguments['username'];
  final String email = Get.arguments['email'];
  final String password = Get.arguments['password'];
  final String gender = Get.arguments['gender'];
}
