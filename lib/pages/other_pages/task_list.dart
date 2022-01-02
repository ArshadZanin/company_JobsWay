import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/model/fetch_task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskList extends StatefulWidget {
  TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  bool _isLoading = false;

  ///widget controller
  final widgets = Get.put(WidgetController());

  FetchTask? fetchTaskData;

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

  Future<String?> setTaskCompany(BuildContext context) async {

    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if(idGet != null){
      id = idGet;
    }

    try{
      String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/task-sets/$id';

      print(apiUrl);

      final data = {
        "set1" : {
          "q1" : set1a.text,
          "q2" : set1b.text,
          "q3" : set1c.text,
          "q4" : set1d.text
        },
        "set2" : {
          "q1" : set2a.text,
          "q2" : set2b.text,
          "q3" : set2c.text,
          "q4" : set2d.text
        }  ,
        "set3" : {
          "q1" : set3a.text,
          "q2" : set3b.text,
          "q3" : set3c.text,
          "q4" : set3d.text
        }
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );


      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);

        return jsonDecode(responseString)['msg'];
      } else {
        _isLoading = false;
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        return null;
      }
    }on SocketException {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
      return null;
    } on TimeoutException catch (e) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    } on Error catch (e) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    }
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

      print(apiUrl);

      final response = await http.get(Uri.parse(apiUrl));


      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);

        fetchTaskData = fetchTaskFromJson(responseString);

        if(fetchTaskData != null){

          set1a.text = fetchTaskData!.qset1!.q1 ?? '';
          set1b.text = fetchTaskData!.qset1!.q2 ?? '';
          set1c.text = fetchTaskData!.qset1!.q3 ?? '';
          set1d.text = fetchTaskData!.qset1!.q4 ?? '';

          set2a.text = fetchTaskData!.qset2!.q1 ?? '';
          set2b.text = fetchTaskData!.qset2!.q2 ?? '';
          set2c.text = fetchTaskData!.qset2!.q3 ?? '';
          set2d.text = fetchTaskData!.qset2!.q4 ?? '';

          set3a.text = fetchTaskData!.qset3!.q1 ?? '';
          set3b.text = fetchTaskData!.qset3!.q2 ?? '';
          set3c.text = fetchTaskData!.qset3!.q3 ?? '';
          set3d.text = fetchTaskData!.qset3!.q4 ?? '';

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

  @override
  initState(){
    super.initState();
    retrieveData().whenComplete(() {
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
                label: 'Question 1',
                textController: set1a,
              ),
              widgets.textFieldGrey(
                label: 'Question 2',
                textController: set1b,
              ),
              widgets.textFieldGrey(
                label: 'Question 3',
                textController: set1c,
              ),
              widgets.textFieldGrey(
                label: 'Question 4',
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
                label: 'Question 1',
                textController: set2a,
              ),
              widgets.textFieldGrey(
                label: 'Question 2',
                textController: set2b,
              ),
              widgets.textFieldGrey(
                label: 'Question 3',
                textController: set2c,
              ),
              widgets.textFieldGrey(
                label: 'Question 4',
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
                label: 'Question 1',
                textController: set3a,
              ),
              widgets.textFieldGrey(
                label: 'Question 2',
                textController: set3b,
              ),
              widgets.textFieldGrey(
                label: 'Question 3',
                textController: set3c,
              ),
              widgets.textFieldGrey(
                label: 'Question 4',
                textController: set3d,
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: widgets.textColorButtonCircle(
                    text: 'Update Task Sets',
                    onPress: () async {

                      _isLoading = true;
                      setState(() {
                      });

                  var result = await setTaskCompany(context);

                  if(result == 'Task Set Added'){
                    initializePreference();
                    Navigator.pop(context);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Try Again!!',textAlign: TextAlign.center,),
                    ));
                    setState(() {

                    });
                  }
                }, isLoading: _isLoading),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initializePreference() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("set1a", set1a.text);
    await preferences.setString("set1b", set1b.text);
    await preferences.setString("set1c", set1c.text);
    await preferences.setString("set1d", set1d.text);

    await preferences.setString("set2a", set2a.text);
    await preferences.setString("set2b", set2b.text);
    await preferences.setString("set2c", set2c.text);
    await preferences.setString("set2d", set2d.text);

    await preferences.setString("set3a", set3a.text);
    await preferences.setString("set3b", set3b.text);
    await preferences.setString("set3c", set3c.text);
    await preferences.setString("set3d", set3d.text);
  }

  Future<void> retrieveData() async {
    final preferences = await SharedPreferences.getInstance();

    var set1Qa = preferences.getString("set1a");
    set1a.text = set1Qa ?? '';
    var set1Qb = preferences.getString("set1b");
    set1b.text = set1Qb ?? '';
    var set1Qc = preferences.getString("set1c");
    set1c.text = set1Qc ?? '';
    var set1Qd = preferences.getString("set1d");
    set1d.text = set1Qd ?? '';

    var set2Qa = preferences.getString("set2a");
    set2a.text = set2Qa ?? '';
    var set2Qb = preferences.getString("set2b");
    set2b.text = set2Qb ?? '';
    var set2Qc = preferences.getString("set2c");
    set2c.text = set2Qc ?? '';
    var set2Qd = preferences.getString("set2d");
    set2d.text = set2Qd ?? '';

    var set3Qa = preferences.getString("set3a");
    set3a.text = set3Qa ?? '';
    var set3Qb = preferences.getString("set3b");
    set3b.text = set3Qb ?? '';
    var set3Qc = preferences.getString("set3c");
    set3c.text = set3Qc ?? '';
    var set3Qd = preferences.getString("set3d");
    set3d.text = set3Qd ?? '';

    setState(() {});
  }


}
