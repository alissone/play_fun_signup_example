import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getx_app/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/home/home_controller.dart';
import 'package:getx_app/routes/app_routes.dart';

class HomePage extends GetView<HomeController> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _gender = "";
  bool agreesTermsAndConditions = false;

  String validateUsername(String value) {
    int minimumLength = 3;
    if (!(value.length > minimumLength) && value.isNotEmpty) {
      return "Username should contain more than $minimumLength characters";
    }
    return null;
  }

  String validatePassword(String value) {
    int minimumLength = 5;
    if (!(value.length > minimumLength) && value.isNotEmpty) {
      return "Password should contain more than $minimumLength characters";
    }
    return null;
  }

  String validateEmail(String value) {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);
    if (!emailValid && value.isNotEmpty) {
      return "Email is invalid";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Spacer(),
              ValidatedTextInput(
                textController: _usernameController,
                hintText: "Name",
                textInputIcon: FaIcon(FontAwesomeIcons.user),
                textValidator: validateUsername,
              ),
              ValidatedTextInput(
                textController: _emailController,
                hintText: "E-mail",
                textInputIcon: FaIcon(FontAwesomeIcons.at),
                textValidator: validateEmail,
              ),
              ValidatedTextInput(
                textController: _passwordController,
                hintText: "Password",
                isPassword: true,
                textInputIcon: FaIcon(FontAwesomeIcons.lock),
                textValidator: validatePassword,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Themes.orangeAccentColor,
                    activeColor: Colors.red,
                    value: agreesTermsAndConditions,
                    onChanged: (bool value) {
                      agreesTermsAndConditions = value;
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "I read and agreed to the ",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(color: Themes.orangeAccentColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                          color: Themes.textColor,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Themes.orangeAccentColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () => Get.toNamed(
                        AppRoutes.ACCOUNT,
                        arguments: {
                          "username": _usernameController.text,
                          "email": _emailController.text,
                          "password": _passwordController.text,
                          "gender": _gender,
                        },
                      ),
                    ),
                  ),
                  RoundButton(
                    content: FaIcon(FontAwesomeIcons.facebookF),
                    radius: 56.0,
                    color: Color(0xFF3456a2),
                  ),
                  RoundButton(
                    content: FaIcon(FontAwesomeIcons.google),
                    radius: 56.0,
                    color: Color(0xFFdd4b39),
                  ),
                ],
              ),
              SizedBox(height: 42),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style:
                            TextStyle(color: Color(0xFF8d92a3), fontSize: 12),
                      ),
                      TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                            color: Themes.orangeAccentColor, fontSize: 12),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("https://playsport.fun/login");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValidatedTextInput extends StatelessWidget {
  ValidatedTextInput({
    Key key,
    @required TextEditingController textController,
    @required this.textInputIcon,
    @required String hintText,
    Function textValidator,
    bool isPassword,
  })  : _textController = textController,
        _textValidator = textValidator,
        _hintText = hintText,
        _isPassword = isPassword,
        super(key: key);

  final TextEditingController _textController;
  final Function _textValidator;
  final dynamic textInputIcon;
  final String _hintText;
  final dynamic _isPassword;

  bool _obscureText;
  @override
  Widget build(BuildContext context) {
    _obscureText = _isPassword ?? false;
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
      child: Row(
        children: [
          Flexible(
            child: Column(
              children: [
                TextFormField(
                  controller: _textController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _textValidator,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 16.0),
                    prefixIcon: textInputIcon,
                    hintText: _hintText,
                    errorText: _textValidator(_textController.text),
                  ),
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    @required this.radius,
    @required this.color,
    @required this.content,
  }) : super(key: key);

  final double radius;
  final Color color;
  final FaIcon content;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(radius, radius), // button width and height
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () {}, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[content],
            ),
          ),
        ),
      ),
    );
  }
}
