import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class AssignTask extends StatefulWidget {
  const AssignTask({Key? key}) : super(key: key);

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  ///widget controller
  final widgets = Get.put(WidgetController());

  ///text field controllers assign
  final setA = TextEditingController();
  final setB = TextEditingController();
  final setC = TextEditingController();
  final setD = TextEditingController();
  final timerMinute = TextEditingController();

  ///button color control
  int buttonSelect = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Prepare Questions.',
          style: TextStyle(
            color: Color(0xFF008FAE),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ///set 1
              widgets.textWidget(
                text: 'Questions :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              widgets.textFieldGrey(
                textController: setA,
              ),
              widgets.textFieldGrey(
                textController: setB,
              ),
              widgets.textFieldGrey(
                textController: setC,
              ),
              widgets.textFieldGrey(
                textController: setD,
              ),

              widgets.textWidget(
                text: 'Task Sets :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widgets.blueButton(
                      label: '1',
                      onPress: () {
                        buttonSelect != 1 ?
                        buttonSelect = 1 :
                        buttonSelect = buttonSelect;
                        setState(() {

                        });
                      },
                      colorGrey: buttonSelect == 1 ? false : true,
                    ),
                    widgets.blueButton(
                      label: '2',
                      onPress: () {
                        buttonSelect != 2 ?
                        buttonSelect = 2 :
                        buttonSelect = buttonSelect;
                        setState(() {

                        });
                      },
                      colorGrey: buttonSelect == 2 ? false : true,
                    ),
                    widgets.blueButton(
                      label: '3',
                      onPress: () {
                        buttonSelect != 3 ?
                        buttonSelect = 3 :
                        buttonSelect = buttonSelect;
                        setState(() {

                        });
                      },
                      colorGrey: buttonSelect == 3 ? false : true,
                    ),
                  ],
                ),
              ),
              widgets.textWidget(
                text: 'Set Timer :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              widgets.textFieldGrey(
                label: 'Minutes',
                textController: timerMinute,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(
                    text: 'Send Task',
                    onPress: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
