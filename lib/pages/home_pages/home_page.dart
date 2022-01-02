import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/model/login_model.dart';
import 'package:jobs_way_company/pages/home_pages/application_page.dart';
import 'package:jobs_way_company/pages/home_pages/dashboard.dart';
import 'package:jobs_way_company/pages/home_pages/jobs_page.dart';
import 'package:jobs_way_company/pages/home_pages/shortlisted_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = Get.put(WidgetController());

  Future<void> fetchCompany() async {
    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    if (idGet != null) {
      id = idGet;
    }

    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/company/$id';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(responseString);

        var result = loginFromJson(responseString);

        var value = result.company;

        final responseImage = await http.get(Uri.parse(value!.logoUrl!));

        var valueByte = base64.encode(responseImage.bodyBytes);

        await initializePreference(
            image: valueByte,
            id: value.id!,
            companyName: value.companyName!,
            industry: value.industry!,
            location: value.location!,
            email: value.email!,
            phone: value.phone!,
            about: value.bio!,
            website: value.website!,
            instagram: value.instagram!,
            linkedin: value.linkedIn!,
            twitter: value.twitter!,
            facebook: value.facebook!,
            password: value.password!);
      } else {
        print(response.statusCode);
        print(response.body);
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              '${result['error']}',
              textAlign: TextAlign.center,
            ),
          ));
        }
        // return null;
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Check network connection',
          textAlign: TextAlign.center,
        ),
      ));
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$e',
          textAlign: TextAlign.center,
        ),
      ));
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '$e',
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompany();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: widgets.appbarCustom(context),
        body: const TabBarView(
          children: <Widget>[
            DashboardPage(),
            JobsPage(),
            ApplicationPage(),
            ShortListedPage(),
          ],
        ),
        bottomNavigationBar: const Material(
          color: Color(0xFFF2F2F2),
          child: TabBar(
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              labelColor: Color(0xFF008FAE),
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.pages,
                    size: 28,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.article,
                    size: 28,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.list,
                    size: 28,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Future<void> initializePreference({
    required String image,
    required String id,
    required String companyName,
    required String industry,
    required String location,
    required String email,
    required String phone,
    required String about,
    required String website,
    required String instagram,
    required String linkedin,
    required String twitter,
    required String facebook,
    required String password,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("login", 'login');
    await preferences.setString("image", image);
    await preferences.setString("id", id);
    await preferences.setString("companyName", companyName);
    await preferences.setString("industry", industry);
    await preferences.setString("location", location);
    await preferences.setString("email", email);
    await preferences.setString("phone", phone);
    await preferences.setString("about", about);
    await preferences.setString("website", website);
    await preferences.setString("instagram", instagram);
    await preferences.setString("linkedin", linkedin);
    await preferences.setString("twitter", twitter);
    await preferences.setString("facebook", facebook);
    await preferences.setString("password", password);
  }
}
