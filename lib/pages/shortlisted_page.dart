import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/pages/task_list.dart';

class ShortListedPage extends StatefulWidget {
  const ShortListedPage({Key? key}) : super(key: key);

  @override
  _ShortListedPageState createState() => _ShortListedPageState();
}

class _ShortListedPageState extends State<ShortListedPage> {
  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///heading
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widgets.headingVersaTexts(colorText: 'Short Listed.'),
                  widgets.greenButton(
                      label: 'Set Tasks',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TaskList(),
                          ),
                        );
                      }),
                ],
              ),
            ),

            ///application list
            Expanded(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return widgets.applicationList(
                      imageSrc: 'https://3.bp.blogspot.com/-YyJv82hXTbM/'
                          'T02ep1RC8oI/AAAAAAAAU7M/UD9sZ_mzjXM/s1600/'
                          '120218_Rustam_03_029.jpg',
                      name: 'Arshad Sanin',
                      place: 'Kerala, India',
                      email: 'arshadzanin786@gmail.com',
                      phone: '9746802988',
                      experience: '2 Years',
                      jobTitle: 'Sr.Flutter Developer',
                      button: widgets.textColorButton(
                          text: 'Assign Task', onPress: () {}),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
