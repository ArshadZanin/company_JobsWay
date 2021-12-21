import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/login_register/register.dart';
import 'package:jobs_way_company/model/login_model.dart';
import 'package:jobs_way_company/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final widgets = Get.put(WidgetController());
  final emailOrUserNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscurePassword = true;
  bool _isLoading = false;


  Future<Login?> loginCompany({
    required String password,
    required String email,
  }) async {
    const String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/login';


    try{
      final response = await http.post(Uri.parse(apiUrl), body: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        final String responseString = response.body;

        return loginFromJson(responseString);
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widgets.headingTexts(
                      blackText: 'Log into ', colorText: 'Company.'),
                  const SizedBox(
                    height: 50,
                  ),
                  widgets.textFieldGrey(
                    label: 'Email',
                    textController: emailOrUserNameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widgets.textFieldGreyObscure(
                    label: 'Password',
                    textController: passwordController,
                    onPress: () {
                      _isObscurePassword ?
                      _isObscurePassword = false :
                      _isObscurePassword = true;
                      setState(() {

                      });
                    }, obscure: _isObscurePassword,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {
                  //           debugPrint("Forgot Password");
                  //         },
                  //         child: const Text('Forgot Password'))
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  widgets.textColorButtonCircle(
                      text: 'Sign In',
                      onPress: () async {
                        FocusScope.of(context).requestFocus(FocusNode());

                        _isLoading = true;

                        setState(() {

                        });

                        var email = emailOrUserNameController.text;
                        var password = passwordController.text;

                        if(email.length <= 5){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('invalid email',textAlign: TextAlign.center,),
                          ));
                          _isLoading = false;
                          setState(() {

                          });
                        }else if(password.length <= 8){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('password is not correct',textAlign: TextAlign.center,),
                          ));
                          _isLoading = false;
                          setState(() {

                          });
                        }else{


                          var result = await loginCompany(email: email, password: password);

                          if(result == null){
                            _isLoading = false;
                            setState(() {

                            });
                          }else if(result.token != null && result.company != null){

                            var value = result.company;

                            final response = await http.get(Uri.parse(value!.logoUrl!));
                            var valueByte = base64.encode(response.bodyBytes);

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


                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          }else{
                            _isLoading = false;
                            setState(() {

                            });
                          }
                        }

                      }, isLoading: _isLoading),
                  const SizedBox(
                    height: 15,
                  ),
                  widgets.buttonWithText(
                    text: "Company not Registered?",
                    buttonText: "Register Now",
                    onPress: () {
                      debugPrint("Register Now");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
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
