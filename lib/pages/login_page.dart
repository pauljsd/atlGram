import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  double? deviceHeight, deviceWidth;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title(),
                form(),
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return const Text(
      'ATLGram',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
    );
  }

  Widget form() {
    return Container(
      height: deviceHeight! * 0.30,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              emailTextField(),
              passwordTextField(),
            ],
          )),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Email...'),
      onSaved: (_value) {
        setState(() {
          email = _value;
        });
      },
      validator: (_value) {
        bool _result = _value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
        );
        return _result ? null : "Please enter a valid email";
      },
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Password...'),
      onSaved: (_value) {
        setState(() {
          password = _value;
        });
      },
      validator: (_value) => _value!.length > 6
          ? null
          : 'Please enter a password greater than 6 characters',
    );
  }

  Widget loginButton() {
    return MaterialButton(
      onPressed: loginUser,
      color: Colors.red,
      minWidth: deviceWidth! * 0.60,
      height: deviceHeight! * 0.05,
      child: const Text('Login',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    );
  }

  void loginUser() {
    if (_loginFormKey.currentState!.validate()) {}
  }
}
