import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class RegisterPage extends StatefulWidget {
  const  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final widgets = Get.put(WidgetController());
  ///assign controllers
  final companyNameController = TextEditingController();
  final industryController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              widgets.headingTexts(
                  blackText: 'Register Your ',
                  colorText: 'Company',
              ),
              const Text('Basic Details:'),
              Row(
                children: [
                  Expanded(
                      child: widgets.textFieldGrey(
                        label: 'Company Name',
                        textController: companyNameController
                      ),
                  ),
                  Expanded(
                      child: widgets.textFieldGrey(
                        label: 'Industry',
                        textController: industryController
                      ),
                  ),
                ],
              ),
              widgets.textFieldGrey(
                label: 'Location',
                textController: locationController
              ),
              Row(
                children: [
                  Expanded(
                      child: widgets.textFieldGrey(
                        label: 'Email',
                        textController: emailController
                      ),
                  ),
                  Expanded(
                      child: widgets.textFieldGrey(
                        label: 'Phone',
                        textController: phoneController
                      ),
                  ),
                ],
              ),
              widgets.textFieldGrey(
                label: 'About Your Company..',
                textController: aboutController
              ),
            ],
          ),
        ),
      ),
    );
  }
}
