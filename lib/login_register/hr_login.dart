import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/login_register/log_in.dart';
import 'package:jobs_way_company/login_register/register.dart';
import 'package:jobs_way_company/model/hr_login_model.dart';
import 'package:jobs_way_company/model/login_model.dart';
import 'package:jobs_way_company/pages/home_pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HrLogin extends StatefulWidget {
  const HrLogin({Key? key}) : super(key: key);

  @override
  State<HrLogin> createState() => _HrLoginState();
}

class _HrLoginState extends State<HrLogin> {

  final widgets = Get.put(WidgetController());
  final emailOrUserNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscurePassword = true;
  bool _isLoading = false;


  Future<HrLoginModel?> loginCompanyHr({
    required String password,
    required String email,
  }) async {
    const String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/login/hr';


    try{
      final response = await http.post(Uri.parse(apiUrl), body: {
        "email": email,
        "password": password,
      });

      print(response.body);
      if (response.statusCode == 200) {
        final String responseString = response.body;

        return hrLoginFromJson(responseString);
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
                      blackText: 'Log into ', colorText: 'HR Company.'),
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
                        }else if(password.length < 8){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('password is not correct',textAlign: TextAlign.center,),
                          ));
                          _isLoading = false;
                          setState(() {

                          });
                        }else{


                          var result = await loginCompanyHr(email: email, password: password);

                          if(result == null){
                            _isLoading = false;
                            setState(() {

                            });
                          }else if(result.token != null && result.hrDetails != null){




                            var value = result.hrDetails;
                            //
                            // final response = await http.get(Uri.parse(value!.logoUrl!));
                            // var valueByte = base64.encode(response.bodyBytes);
                            //
                            await initializePreference(
                            //     image: valueByte,
                                id: value!.companyId!,
                                hrId: value.id!,
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
                    text: "Login as Company?",
                    buttonText: "Login Now",
                    onPress: () {
                      debugPrint("Register Now");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LogIn(),
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
    required String id,
    required String hrId,
    required String password,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("login", 'login');
    await preferences.setString("id", id);
    await preferences.setString("hrId", hrId);
    await preferences.setString("HrPassword", password);
  }

}
