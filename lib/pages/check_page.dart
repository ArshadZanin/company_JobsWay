import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jobs_way_company/login_register/log_in.dart';
import 'package:jobs_way_company/pages/home_page.dart';
import 'package:jobs_way_company/pages/rejection_page.dart';
import 'package:jobs_way_company/pages/waiting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  var id = '';
  var companyName = '';
  var login = '';

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() {
      setState(() {});
      if (login != '') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => id == ''
                ? LogIn()
                : WaitingPage(
                    name: companyName,
                    id: id,
                  ),
          ),
        );
      }
    });
  }

  Future<void> checkStatus() async {
    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/company/$id';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['company']['status'] == false) {
        print("status false");
      } else if (result['company']['status'] == 'Rejected') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RejectionPage(
              name: companyName,
              id: id,
              reason: result['company']['reason'],
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      }
    }
  }

  Future<void> retrieveData() async {
    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    String? companyNameGet = preferences.getString("companyName");
    String? loginGet = preferences.getString("login");

    if (loginGet != null) {
      login = loginGet;
    }

    if (idGet != null) {
      id = idGet;
    }
    if (companyNameGet != null) {
      companyName = companyNameGet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
