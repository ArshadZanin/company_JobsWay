import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/pages/choose_plan_page.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final widgets = Get.put(WidgetController());

  ///assign controllers
  final jobTitle = TextEditingController();
  final category = TextEditingController();
  final experienceFrom = TextEditingController();
  final experienceTo = TextEditingController();
  final salaryFrom = TextEditingController();
  final salaryTo = TextEditingController();
  final qualification = TextEditingController();
  final education = TextEditingController();
  final language = TextEditingController();
  final skills = TextEditingController();
  int partTime = 1;
  int fullTime = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                  ),
                  child: widgets.headingTexts(
                      blackText: 'Add a new ', colorText: 'Job'),
                ),
                widgets.textWidget(
                    text: 'Job Title :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(textController: jobTitle),
                widgets.textWidget(
                    text: 'Category :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(textController: category),
                widgets.textWidget(
                    text: 'Experience Required :',
                    size: 14,
                    color: Colors.grey),
                Row(
                  children: [
                    Expanded(
                      child:
                          widgets.textFieldGrey(textController: experienceFrom),
                    ),
                    widgets.textWidget(
                      text: 'To',
                      size: 13,
                      bold: true,
                    ),
                    Expanded(
                      child:
                          widgets.textFieldGrey(textController: experienceTo),
                    ),
                  ],
                ),
                widgets.textWidget(
                    text: 'Salary Required :', size: 14, color: Colors.grey),
                Row(
                  children: [
                    Expanded(
                      child: widgets.textFieldGrey(textController: salaryFrom),
                    ),
                    widgets.textWidget(
                      text: 'To',
                      size: 13,
                      bold: true,
                    ),
                    Expanded(
                      child: widgets.textFieldGrey(textController: salaryTo),
                    ),
                  ],
                ),
                widgets.textWidget(
                    text: 'Time :', size: 14, color: Colors.grey),
                InkWell(
                  onTap: () {
                    fullTime == 1 ? fullTime = 0 : fullTime = 1;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          fullTime == 1
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          // color: const Color(0xFF004756),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      widgets.textWidget(text: 'Full Time'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    partTime == 1 ? partTime = 0 : partTime = 1;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          partTime == 1
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          // color: const Color(0xFF004756),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      widgets.textWidget(text: 'Part Time'),
                    ],
                  ),
                ),
                widgets.textWidget(
                    text: 'Qualification :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(textController: qualification),
                widgets.textWidget(
                    text: 'Education :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(textController: education),
                widgets.textWidget(
                    text: 'Language :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(
                    label: 'Separate by coma', textController: language),
                widgets.textWidget(
                    text: 'Skills :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(
                    label: 'Separate by coma', textController: category),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: widgets.textColorButton(
                      text: 'Proceed to Payment',
                      onPress: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChoosePlanPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
