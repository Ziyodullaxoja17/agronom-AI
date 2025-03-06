import 'dart:developer';

import 'package:agronom_ai/controller/agro_controller.dart';
import 'package:agronom_ai/presentation/screens/main_agro_screen.dart';
import 'package:agronom_ai/presentation/screens/register_agro_screen.dart';
import 'package:agronom_ai/presentation/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginAgroScreen extends StatefulWidget {
  const LoginAgroScreen({super.key});

  @override
  State<LoginAgroScreen> createState() => _LoginAgroScreenState();
}

class _LoginAgroScreenState extends State<LoginAgroScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                spacing: 20,
                children: [
                  CustomTextFormField(
                    phoneNumberController: phoneNumberController,
                    labelText: 'Enter phone number',
                    hintText: "+998 90 XXX XX XX",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter phone number";
                      }
                      // Regular expression for validating phone number

                      return null;
                    },
                  ),
                  CustomTextFormField(
                    phoneNumberController: passwordController,
                    labelText: 'Enter password',
                    hintText: "abc 123",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter password";
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Consumer<AgroController>(
            builder: (context, provider, child) {
              return GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await provider.login(
                        password: passwordController.text.trim(),
                        phoneNumber: phoneNumberController.text.trim());

                    if (provider.isAllowed) {
                      phoneNumberController.clear();
                      passwordController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainAgroScreen(),
                        ),
                      );
                    } else {
                      log(provider.message);
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(width: 2, color: Colors.black)),
                  width: 140,
                  height: 50,
                  alignment: Alignment.center,
                  child: provider.isloading
                      ? CircularProgressIndicator()
                      : Text(
                          "Login",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You don't have a account ? ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterLoginScreen(),
                    ),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
