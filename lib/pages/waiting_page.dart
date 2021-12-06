import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class WaitingPage extends StatelessWidget {
  WaitingPage({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Row(
                children: [
                  widgets.headingTexts(
                      blackText: 'Hey ',
                    colorText: 'Google,',
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              widgets.headingTexts(
                blackText: 'Your Company has',
              ),
              widgets.headingTexts(
                blackText: 'Created Successfully.',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('JobsWay will Verify Your Company and Provide',
                  ),
              const Text(' the Dashboard to you within 1 - 2 days',
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
