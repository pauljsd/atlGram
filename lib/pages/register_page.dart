import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  double? deviceHeight, deviceWidth;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  String? name, email, password;
  File? image;

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
                profileImageWidget(),
                form(),
                registerButton(),
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

  Widget profileImageWidget() {
    var imageProvider = image != null
        ? FileImage(image!)
        : const NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
        onTap: () {
          FilePicker.platform.pickFiles(type: FileType.image).then((result) {
            setState(() {
              image = File(result!.files.first.path!);
            });
          });
        },
        child: Container(
          height: deviceHeight! * 0.15,
          width: deviceHeight! * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider as ImageProvider,
            ),
          ),
        ));
  }

  Widget form() {
    return Container(
      height: deviceHeight! * 0.30,
      child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              nameTextField(),
              emailTextField(),
              passwordTextField(),
            ],
          )),
    );
  }

  Widget nameTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'Name...'),
      onSaved: (_value) {
        setState(() {
          name = _value;
        });
      },
      validator: (_value) =>
          _value!.length > 2 ? null : 'Please enter real name',
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

  Widget registerButton() {
    return MaterialButton(
      onPressed: registerUser,
      color: Colors.red,
      minWidth: deviceWidth! * 0.60,
      height: deviceHeight! * 0.05,
      child: const Text('Register',
          style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  void registerUser() {
    _registerFormKey.currentState!.save();
    if (_registerFormKey.currentState!.validate() && image != null) {}
    _registerFormKey.currentState!.save();
    // print('oya na');
  }
}
