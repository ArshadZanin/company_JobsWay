import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/login_register/log_in.dart';
import 'package:jobs_way_company/pages/hr_page/add_hr_page.dart';
import 'package:jobs_way_company/pages/hr_page/hr_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final widgets = Get.put(WidgetController());
  File? image;
  Uint8List? bytesImage;

  var companyName = '';
  var industry = '';
  var location = '';
  var email = '';
  var phone = '';
  var about = '';
  var website = '';
  var instagram = '';
  var facebook = '';
  var twitter = '';
  var linkedin = '';
  var password = '';
  var confirmPassword = '';

  @override
  initState() {
    super.initState();
    retrieveData().whenComplete(() {
      setState(() {
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'Profile.',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HrPage(),),);
            },
            icon: const Icon(Icons.person_add_alt),),
          IconButton(onPressed: () async {

            final preferences = await SharedPreferences.getInstance();
            preferences.clear();

            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LogIn(),),);
          },icon: const Icon(Icons.logout),),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: bytesImage != null ?
                        Image.memory(
                          bytesImage!,
                          fit: BoxFit.cover,
                        ):Container(),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: widgets.textWidget(
                    text: companyName,
                  size: 30,
                  bold: true,
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.corporate_fare_outlined,
                  text: industry,
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.location_on_outlined,
                  text: location,
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.mail_outlined,
                  text: email,
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.phone_outlined,
                  text: phone,
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.textWidget(
                text: 'Bio :',
                size: 22,
                bold: true,
              ),
              Text(
                  about,
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              const SizedBox(height: 20,),
              widgets.textWidget(
                text: 'Social Media :',
                size: 22,
                bold: true,
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.link),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: website,bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.instagram),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: instagram,bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.facebook),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: facebook,bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.twitter),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: twitter,bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.linkedin),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: linkedin,bold: true),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> retrieveData() async{
    final preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("image");
    bytesImage = base64Decode(result!);

    String? companyNameGet = preferences.getString("companyName");
    companyName = companyNameGet!;


    String? industryGet = preferences.getString("industry");
    industry = industryGet!;

    String? locationGet = preferences.getString("location");
    location = locationGet!;

    String? emailGet = preferences.getString("email");
    email = emailGet!;

    String? phoneGet = preferences.getString("phone");
    phone = phoneGet!;

    String? aboutGet = preferences.getString("about");
    about = aboutGet!;

    String? websiteGet = preferences.getString("website");
    website = websiteGet!;

    String? linkedinGet = preferences.getString("linkedin");
    linkedin = linkedinGet!;

    String? instagramGet = preferences.getString("instagram");
    instagram = instagramGet!;

    String? twitterGet = preferences.getString("twitter");
    twitter = twitterGet!;

    String? facebookGet = preferences.getString("facebook");
    facebook = facebookGet!;

    String? passwordGet = preferences.getString("password");
    password = passwordGet!;
    confirmPassword = passwordGet;


    setState(() {

    });
  }
}
