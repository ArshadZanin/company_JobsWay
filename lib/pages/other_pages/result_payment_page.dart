import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class ResultPage extends StatelessWidget {
  ResultPage({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widgets.textWidget(
                text: 'Payment Successfully Completed.',
                color: Colors.green,
                bold: true,
              ),
              widgets.textWidget(
                text: 'The job will start displaying within seconds.',
                size: 14,
                bold: true,
              ),
              const SizedBox(height: 20,),
              widgets.textColorButton(
                text: 'Back to Dashboard',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
