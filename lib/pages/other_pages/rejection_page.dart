import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way_company/login_register/register.dart';
import 'package:jobs_way_company/pages/home_pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class RejectionPage extends StatefulWidget {
  RejectionPage({
    Key? key,
    required this.name,
    required this.id,
    required this.reason,
  }) : super(key: key);

  String name;
  String id;
  String reason;

  @override
  _RejectionPageState createState() => _RejectionPageState();
}

class _RejectionPageState extends State<RejectionPage> {
  final widgets = Get.put(WidgetController());

  Future<void> checkStatus() async {
    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/company/${widget.id}';
    final response = await http.get(Uri.parse(apiUrl));

    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      if (result['company']['status'] == false) {
        print("status false");
      } else if(result['company']['status'] == true){

        await initializePreference();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
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
              Text(
                'Your registration has',
                style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                'been Rejected.',
                style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Check the reasons for rejection and',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'try to reapply, All the best.',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Reason : ',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                widget.reason,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              widgets.textColorButton(
                text: 'Edit Registration',
                onPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterPage(reRegister: "reRegister"),
                    ),
                  );
                },
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
