import 'dart:developer';

import 'package:agronom_ai/controller/agro_controller.dart';
import 'package:agronom_ai/presentation/screens/main_agro_screen.dart';
import 'package:agronom_ai/presentation/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterLoginScreen extends StatefulWidget {
  const RegisterLoginScreen({super.key});

  @override
  State<RegisterLoginScreen> createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
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
                      } else if (!RegExp(r'^\+998 \d{2} \d{3} \d{2} \d{2}$')
                          .hasMatch(value)) {
                        return "Enter a valid phone number";
                      }
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
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters long";
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
                    await provider.register(
                        password: passwordController.text.trim(),
                        phoneNumber: phoneNumberController.text.trim());

                    if (provider.isAllowed) {
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
                          "Register",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
