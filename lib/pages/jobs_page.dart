import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgets.headingVersaTexts(colorText: 'Jobs.'),
                widgets.greenButton(label: 'Add new job',onPress: (){}),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index){
                    return widgets.jobCardBlack(
                        postTime: '10 days',
                        jobName: 'Sr.Flutter Developer',
                      salaryRange: '30000 - 50000',
                      experience: '4 - 8 Year',
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
