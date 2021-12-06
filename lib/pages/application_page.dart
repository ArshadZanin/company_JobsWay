import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///heading
            Row(
              children: [
                widgets.headingVersaTexts(colorText: 'Applications.'),
              ],
            ),
            ///application list
            Expanded(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index){
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
                        button: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            widgets.greenButton(
                                label: 'Add to Shortlist',
                                onPress: (){}
                            ),
                            widgets.redButton(label: 'Reject Request',
                                onPress: (){}
                            ),
                          ],
                        ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
