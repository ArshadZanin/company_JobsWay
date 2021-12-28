import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddHR extends StatefulWidget {
  const AddHR({Key? key}) : super(key: key);

  @override
  _AddHRState createState() => _AddHRState();
}

class _AddHRState extends State<AddHR> {

  final widgets = Get.put(WidgetController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> addHrCompany({
    required String name,
    required String email,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString("id");
    String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/add-company-hr/$id';
    print(apiUrl);


    try{
      final response = await http.post(Uri.parse(apiUrl), body: {
        "name": name,
        "email": email,
      });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final String responseString = response.body;

        // return loginFromJson(responseString);
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        // return null;
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: widgets.headingTexts(blackText: 'Add HR'),
                ),
                widgets.textFieldGrey(
                  label: 'Name',
                  textController: nameController,
                ),
                widgets.textFieldGrey(
                  label: 'Email',
                  textController: emailController,
                ),
                widgets.textColorButton(text: 'Submit', onPress: () async {
                  var name = nameController.text;
                  var email = emailController.text;

                  var result = await addHrCompany(name: name, email: email);

                  ///only before getting web hosting
                  Navigator.pop(context);

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
