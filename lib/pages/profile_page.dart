import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Profile.',
          style: TextStyle(
            color: Color(0xFF008FAE),
          ),
        ),
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
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.network(
                        'https://img.flaticon.com/icons/png/512/2702/2702602.png?'
                            'size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: widgets.textWidget(
                    text: 'Google',
                  size: 30,
                  bold: true,
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.corporate_fare_outlined,
                  text: 'Information Technology',
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.location_on_outlined,
                  text: 'Bengaluru, India',
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.mail_outlined,
                  text: 'google@mail.com',
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.iconText(
                  icon: Icons.phone_outlined,
                  text: '21837788290',
                textSize: 20,
              ),
              const SizedBox(height: 20,),
              widgets.textWidget(
                text: 'Bio :',
                size: 22,
                bold: true,
              ),
              const Text(
                  'In publishing and graphic design, Lorem ipsum is a'
                      ' placeholder text commonly used to demonstrate the '
                      'visual form of a document or a typeface without'
                      ' relying on meaningful content. ',
                style: TextStyle(fontSize: 20),
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
                  widgets.textWidget(text: 'www.google.com',bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.instagram),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: 'www.instagram.com/google',bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.facebook),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: 'www.facebook.com/google',bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.twitter),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: 'www.twitter.com/google',bold: true),
                ],
              ),
              Row(
                children: [
                  const FaIcon(FontAwesomeIcons.linkedin),
                  const SizedBox(width: 5,),
                  widgets.textWidget(text: 'www.linkedin.com/google',bold: true),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
