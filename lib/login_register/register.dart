import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/image_pick/utils.dart';
import 'package:jobs_way_company/login_register/otp.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final widgets = Get.put(WidgetController());
  File? image;

  ///assign controllers
  final companyNameController = TextEditingController();
  final industryController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();
  final websiteController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: widgets.headingTexts(
                    blackText: 'Register Your ',
                    colorText: 'Company',
                  ),
                ),
                const Text('Basic Details:'),
                Row(
                  children: [
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Company Name',
                          textController: companyNameController),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Industry',
                          textController: industryController),
                    ),
                  ],
                ),
                widgets.textFieldGrey(
                    label: 'Location', textController: locationController),
                Row(
                  children: [
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Email', textController: emailController),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Phone', textController: phoneController),
                    ),
                  ],
                ),
                widgets.textFieldGrey(
                    label: 'About Your Company..',
                    textController: aboutController),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image == null ?
                    Container()
                    : Image.file(image!),
                  ),
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    image = (await Utils.pickImage(
                        cropImage: cropSquareImage,
                    ))!;
                    print('*****************************************************************');
                    var value = await BASE64.encode(image!.bodyBytes);
                    print(value);
                    print('*****************************************************************');
                    setState(() {

                    });
                  },
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Text('Connect Social Media:'),
                Row(
                  children: [
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Website', textController: websiteController),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Instagram',
                          textController: instagramController),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Facebook',
                          textController: facebookController),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: widgets.textFieldGrey(
                          label: 'Twitter', textController: twitterController),
                    ),
                  ],
                ),
                widgets.textFieldGrey(
                    label: 'LinkedIn', textController: linkedinController),
                const Text('Create Password :'),
                widgets.textFieldGrey(
                    label: 'Password', textController: passwordController),
                widgets.textFieldGrey(
                    label: 'Confirm Password',
                    textController: confirmPasswordController),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Icon(Icons.check_box),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          'I hereby declare that the information given'
                          ' in this application is true and correct.',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: widgets.textColorButton(
                    text: 'Register Your Company',
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpEmail(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
}
