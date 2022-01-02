import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/model/fetch_task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AssignTask extends StatefulWidget {
  const AssignTask({Key? key, required this.userId, required this.jobId}) : super(key: key);

  final String userId;
  final String jobId;

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  ///widget controller
  final widgets = Get.put(WidgetController());

  FetchTask? fetchTaskData;

  String set1a = '';
  String set1b = '';
  String set1c = '';
  String set1d = '';

  String set2a = '';
  String set2b = '';
  String set2c = '';
  String set2d = '';

  String set3a = '';
  String set3b = '';
  String set3c = '';
  String set3d = '';

  ///text field controllers assign
  final setA = TextEditingController();
  final setB = TextEditingController();
  final setC = TextEditingController();
  final setD = TextEditingController();
  final timerMinute = TextEditingController();

  ///button color control
  int buttonSelect = 1;



  @override
  initState(){
    super.initState();
    retrieveData().whenComplete(() {
      setA.text = set1a;
      setB.text = set1b;
      setC.text = set1c;
      setD.text = set1d;
      fetchTask();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Prepare Questions.',
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
                text: 'Questions :',
                color: Colors.grey,
                size: 18,
                bold: true,
              ),
              widgets.textFieldGrey(
                label: 'Question 1',
                textController: setA,
              ),
              widgets.textFieldGrey(
                label: 'Question 2',
                textController: setB,
              ),
              widgets.textFieldGrey(
                label: 'Question 3',
                textController: setC,
              ),
              widgets.textFieldGrey(
                label: 'Question 4',
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

                        setA.text = set1a;
                        setB.text = set1b;
                        setC.text = set1c;
                        setD.text = set1d;
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

                        setA.text = set2a;
                        setB.text = set2b;
                        setC.text = set2c;
                        setD.text = set2d;
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

                        setA.text = set3a;
                        setB.text = set3b;
                        setC.text = set3c;
                        setD.text = set3d;
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
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButton(
                    text: 'Send Task',
                    onPress: () async {
                      var result = await assignTask();
                      print(result);

                      if(result == 'Success'){
                        Navigator.pop(context);
                      }else{
                        print('result error');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> retrieveData() async {
    final preferences = await SharedPreferences.getInstance();

    var set1Qa = preferences.getString("set1a");
    set1a = set1Qa ?? '';
    var set1Qb = preferences.getString("set1b");
    set1b = set1Qb ?? '';
    var set1Qc = preferences.getString("set1c");
    set1c = set1Qc ?? '';
    var set1Qd = preferences.getString("set1d");
    set1d = set1Qd ?? '';

    var set2Qa = preferences.getString("set2a");
    set2a = set2Qa ?? '';
    var set2Qb = preferences.getString("set2b");
    set2b = set2Qb ?? '';
    var set2Qc = preferences.getString("set2c");
    set2c = set2Qc ?? '';
    var set2Qd = preferences.getString("set2d");
    set2d = set2Qd ?? '';

    var set3Qa = preferences.getString("set3a");
    set3a = set3Qa ?? '';
    var set3Qb = preferences.getString("set3b");
    set3b = set3Qb ?? '';
    var set3Qc = preferences.getString("set3c");
    set3c = set3Qc ?? '';
    var set3Qd = preferences.getString("set3d");
    set3d = set3Qd ?? '';

    setState(() {});
  }

  Future<void> fetchTask()async{

    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if(idGet != null){
      id = idGet;
    }else{
      return;
    }

    try{
      String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/task/all/$id';

      setState(() {

      });

      final response = await http.get(Uri.parse(apiUrl));


      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);

        fetchTaskData = fetchTaskFromJson(responseString);

        if(fetchTaskData != null){

          set1a = fetchTaskData!.qset1!.q1 ?? '';
          set1b = fetchTaskData!.qset1!.q2 ?? '';
          set1c = fetchTaskData!.qset1!.q3 ?? '';
          set1d = fetchTaskData!.qset1!.q4 ?? '';

          set2a = fetchTaskData!.qset2!.q1 ?? '';
          set2b = fetchTaskData!.qset2!.q2 ?? '';
          set2c = fetchTaskData!.qset2!.q3 ?? '';
          set2d = fetchTaskData!.qset2!.q4 ?? '';

          set3a = fetchTaskData!.qset3!.q1 ?? '';
          set3b = fetchTaskData!.qset3!.q2 ?? '';
          set3c = fetchTaskData!.qset3!.q3 ?? '';
          set3d = fetchTaskData!.qset3!.q4 ?? '';

          initializePreference();
        }

        // return jsonDecode(responseString)['msg'];
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        return;
      }
    }on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
      return;
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return;
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return;
    }
  }

  Future<void> initializePreference() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("set1a", set1a);
    await preferences.setString("set1b", set1b);
    await preferences.setString("set1c", set1c);
    await preferences.setString("set1d", set1d);

    await preferences.setString("set2a", set2a);
    await preferences.setString("set2b", set2b);
    await preferences.setString("set2c", set2c);
    await preferences.setString("set2d", set2d);

    await preferences.setString("set3a", set3a);
    await preferences.setString("set3b", set3b);
    await preferences.setString("set3c", set3c);
    await preferences.setString("set3d", set3d);
  }

  Future<String?> assignTask() async {

    String id = '';
    String hrId = '';
    String name = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    String? hrIdGet = preferences.getString("hrId");
    if(idGet != null){
      id = idGet;
    }
    if(hrIdGet != null){
      hrId = hrIdGet;
    }

    try{

      String apiUrlVerify = 'https://jobsway-company.herokuapp.com/api/v1/company/task/assign/$hrId';

      final data = {
        "time" : timerMinute.text,
        "taskQuestions" : {
          "q1" : setA.text,
          "q2" : setB.text,
          "q3" : setC.text,
          "q4" : setD.text,
        },
        "userId" : widget.userId,
        "companyId" : id,
        "jobId" : widget.jobId,
        "submitType" : "URL"
      };

      final response = await http.post(
        Uri.parse(apiUrlVerify),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );


      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);

        return jsonDecode(responseString)["msg"];
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
      return null;
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    }
  }


}
