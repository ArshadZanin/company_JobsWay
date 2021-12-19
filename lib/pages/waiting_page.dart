import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way_company/pages/home_page.dart';
import 'package:jobs_way_company/pages/rejection_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingPage extends StatefulWidget {
  WaitingPage({Key? key, required this.name, required this.id})
      : super(key: key);

  String name;
  String id;

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  final widgets = Get.put(WidgetController());

  Future<void> checkStatus() async {
    String apiUrl =
    'https://jobsway-company.herokuapp.com/api/v1/company/company/${widget.id}';
    final response = await http.get(Uri.parse(apiUrl));

    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      if (result['company']['status'] == false) {
        print("status false");
      } else if (result['company']['status'] == 'Rejected') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RejectionPage(
              name: widget.name,
              id: widget.id,
              reason: result['company']['reason'],
            ),
          ),
        );
      } else {

        await initializePreference();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Row(
                children: [
                  widgets.headingTexts(
                    blackText: 'Hey ',
                    colorText: '${widget.name},',
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              widgets.headingTexts(
                blackText: 'Your Company has',
              ),
              widgets.headingTexts(
                blackText: 'Created Successfully.',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'JobsWay will Verify Your Company and Provide',
              ),
              const Text(
                ' the Dashboard to you within 1 - 2 days',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initializePreference() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("login", 'login');
  }

}
