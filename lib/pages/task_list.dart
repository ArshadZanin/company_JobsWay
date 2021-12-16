import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class TaskList extends StatelessWidget {
  TaskList({Key? key}) : super(key: key);

  ///widget controller
  final widgets = Get.put(WidgetController());

  ///text field controllers assign
  final set1a = TextEditingController();
  final set1b = TextEditingController();
  final set1c = TextEditingController();
  final set1d = TextEditingController();
  final set2a = TextEditingController();
  final set2b = TextEditingController();
  final set2c = TextEditingController();
  final set2d = TextEditingController();
  final set3a = TextEditingController();
  final set3b = TextEditingController();
  final set3c = TextEditingController();
  final set3d = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Task List.',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
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
                  text: 'Set - 1',
                size: 20,
                bold: true,
                padding: const EdgeInsets.all(0.0),
              ),
              widgets.textWidget(
                  text: 'Questions :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              widgets.textFieldGrey(
                textController: set1a,
              ),
              widgets.textFieldGrey(
                textController: set1b,
              ),
              widgets.textFieldGrey(
                textController: set1c,
              ),
              widgets.textFieldGrey(
                textController: set1d,
              ),
              ///set 2
              widgets.textWidget(
                text: 'Set - 2',
                size: 20,
                bold: true,
                padding: const EdgeInsets.all(0.0),
              ),
              widgets.textWidget(
                text: 'Questions :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              widgets.textFieldGrey(
                textController: set2a,
              ),
              widgets.textFieldGrey(
                textController: set2b,
              ),
              widgets.textFieldGrey(
                textController: set2c,
              ),
              widgets.textFieldGrey(
                textController: set2d,
              ),
              ///set 3
              widgets.textWidget(
                text: 'Set - 3',
                size: 20,
                bold: true,
                padding: const EdgeInsets.all(0.0),
              ),
              widgets.textWidget(
                text: 'Questions :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              widgets.textFieldGrey(
                textController: set3a,
              ),
              widgets.textFieldGrey(
                textController: set3b,
              ),
              widgets.textFieldGrey(
                textController: set3c,
              ),
              widgets.textFieldGrey(
                textController: set3d,
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(text: 'Update Task Sets', onPress: (){
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
