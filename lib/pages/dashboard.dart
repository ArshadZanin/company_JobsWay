import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///first two containers
            Row(
              children: [
                widgets.dashContainer(11, 'New Applications'),
                const SizedBox(width: 10,),
                widgets.dashContainer(4, 'Jobs'),
              ],
            ),
            ///Applicants list

            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index){
                    return widgets.applicantList(
                        name: 'Arshad Sanin'
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
