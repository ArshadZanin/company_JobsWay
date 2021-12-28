import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/model/job_list_hr_model.dart';
import 'package:jobs_way_company/pages/other_pages/add_job.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final widgets = Get.put(WidgetController());

  Future<JobListHr?> fetchJobHr() async {

    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if(idGet != null){
      id = idGet;
    }

    String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/jobs/$id';


    try{
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print('{"jobList":$responseString,}');

        return jobListHrFromJson('{"jobList":$responseString}');
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        return null;
      }
    }on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
    }

  }

  @override
  void initState() {
    super.initState();
    fetchJobHr();
  }

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
                widgets.greenButton(
                    label: 'Add new job',
                    onPress: () async {
                       await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddJobPage(),
                        ),
                      );
                       Future.delayed(const Duration(seconds: 2),(){
                         setState(() {
                         });
                       });
                       print("restart needed for this page");
                    },),
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder(
                future: fetchJobHr(),
                builder: (BuildContext context, AsyncSnapshot<JobListHr?> snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.jobList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var value = snapshot.data!.jobList![index];
                        return widgets.jobCardBlack(
                          postTime: '10 days',
                          jobName: value.jobTitle!,
                          salaryRange: '30000 - 50000',
                          experience: '${value.minExp} - ${value.maxExp} Year',
                          jobTime: value.timeSchedule!
                        );
                      },
                    );
                  }else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
