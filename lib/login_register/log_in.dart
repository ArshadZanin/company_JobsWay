import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/login_register/register.dart';
import 'package:jobs_way_company/pages/home_page.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());
  final emailOrUserNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgets.headingTexts(
                      blackText: 'Log into ', colorText: 'Company.'),
                  const SizedBox(
                    height: 50,
                  ),
                  widgets.textFieldGrey(
                    label: 'Email',
                    textController: emailOrUserNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widgets.textFieldGrey(
                    label: 'Password',
                    textController: passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            debugPrint("Forgot Password");
                          },
                          child: const Text('Forgot Password'))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  widgets.textColorButton(
                      text: 'Sign In',
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  widgets.buttonWithText(
                    text: "Company not Registered?",
                    buttonText: "Register Now",
                    onPress: () {
                      debugPrint("Register Now");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
