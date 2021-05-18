import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/account/account_controller.dart';
import 'package:getx_app/themes/themes.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Input"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 48),
            Text(
              "User input data",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Themes.orangeAccentColor,
              ),
            ),
            SizedBox(height: 16),
            KeyValueText(name: "name", value: controller.name),
            KeyValueText(name: "Email", value: controller.email),
            KeyValueText(name: "Password", value: controller.password),
            KeyValueText(name: "Gender", value: controller.gender),
          ],
        ),
      ),
    );
  }
}

class KeyValueText extends StatelessWidget {
  const KeyValueText({
    Key key,
    @required this.name,
    @required this.value,
  }) : super(key: key);

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
          ),
        ),
        Text(
          value ?? "",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
