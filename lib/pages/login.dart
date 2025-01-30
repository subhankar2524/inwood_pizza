import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inwood_pizza/utils.dart';
import 'package:inwood_pizza/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> loginUser() async {
    var url = '${Constants.baseUrl}/api/users/login';
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passController.text,
      }),
    );

    var jsonData = jsonDecode(response.body);
    // print(jsonData.toString());

    if (jsonData['success'] == true) {
      // print(jsonData['message']);
      // print(jsonData['data']['token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonData['data']['token']);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      // print(jsonData['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login to Inwood'),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomTextField(controller: emailController, hintText: 'Email'),
              const SizedBox(height: 10),
              CustomTextField(controller: passController, hintText: 'Password'),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: ElevatedButton(
                  onPressed: loginUser,
                  child: const Text('Log in'),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do'nt have an account?  "),
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ])));
  }
}
