import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/pages/other_pages/choose_plan_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final widgets = Get.put(WidgetController());

  String jobId = '';

  ///assign controllers
  final jobTitle = TextEditingController();
  final category = TextEditingController();
  final experienceFrom = TextEditingController();
  final experienceTo = TextEditingController();
  final salaryFrom = TextEditingController();
  final salaryTo = TextEditingController();
  final qualification = TextEditingController();
  final education = TextEditingController();
  final location = TextEditingController();
  final language = TextEditingController();
  final skills = TextEditingController();
  int partTime = 0;
  int fullTime = 1;

  Future<bool> addJobCompany({
    required String jobTitle,
    required String jobCategory,
    required String minExp,
    required String maxExp,
    required String timeSchedule,
    required String qualification,
    required String education,
    required String jobLocation,
    required String skills,
    required String language,
  }) async {

    String id = '';
    String hrId = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    if(idGet != null){
      id = idGet;
    }
    String? hrIdGet = preferences.getString("hrId");
    if(hrIdGet != null){
      hrId = hrIdGet;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Hr Account is needed for Add Job!',
          textAlign: TextAlign.center,
        ),
      ));
    }

    List<String> qualificationList = qualification.split(',');
    List<String> skillsList = skills.split(',');
    List<String> languageList = language.split(',');

    try {
      final jsonMap = {
        "jobTitle" : jobTitle ,
        "jobCategory" : jobCategory,
        "minExp" : minExp,
        "maxExp" : maxExp ,
        "timeSchedule" : timeSchedule ,
        "qualification" : qualificationList,
        "education" : education ,
        "jobLocation" : jobLocation ,
        "skills" : skillsList,
        "language" : languageList
      };

      String jsonData = jsonEncode(jsonMap);

      String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company//add-job/$hrId?cid=$id';

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonData,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final String responseString = response.body;
        var value = jsonDecode(responseString);

        jobId = value["job"]["_id"];
        print(jobId);


        print(responseString);
        return true;
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              '${result['error']}',
              textAlign: TextAlign.center,
            ),
          ));
        }
        return false;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Check network connection',
          textAlign: TextAlign.center,
        ),
      ));
      return false;
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$e',
          textAlign: TextAlign.center,
        ),
      ));
      return false;
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$e',
          textAlign: TextAlign.center,
        ),
      ));
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    jobTitle.text = "Flutter Developer";
    category.text = "software";
    experienceFrom.text = "0";
    experienceTo.text = "3";
    qualification.text = "degree and any";
    education.text = "BCA";
    location.text = "Bangalore";
    skills.text = "flutter,dart";
    language.text = "english,malayalam";
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
                    partTime == 1 ? partTime = 0 : partTime = 1;
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
                    fullTime == 1 ? fullTime = 0 : fullTime = 1;
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
                widgets.textFieldGrey(
                  label: 'Location',
                    textController: location,
                ),
                widgets.textWidget(
                    text: 'Language :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(
                    label: 'Separate by coma', textController: language),
                widgets.textWidget(
                    text: 'Skills :', size: 14, color: Colors.grey),
                widgets.textFieldGrey(
                    label: 'Separate by coma', textController: skills),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: widgets.textColorButton(
                      text: 'Proceed to Payment',
                      onPress: () async {

                        bool result = await addJobCompany(
                            jobTitle: jobTitle.text,
                            jobCategory: category.text,
                            minExp: experienceFrom.text,
                            maxExp: experienceTo.text,
                            timeSchedule: partTime == 1 ? 'partTime' : 'fullTime',
                            qualification: qualification.text,
                            education: education.text,
                            jobLocation: location.text,
                            skills: skills.text,
                            language: language.text,
                        );

                        print(jobId);
                        if(result){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChoosePlanPage(
                                jobId: jobId,
                                jobName: jobTitle.text,
                              ),
                            ),
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Something issue!',textAlign: TextAlign.center,),
                          ));
                        }

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
