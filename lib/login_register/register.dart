import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/image_pick/utils.dart';
import 'package:jobs_way_company/login_register/otp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final widgets = Get.put(WidgetController());
  File? image;
  Uint8List? bytesImage;
  bool confirm = false;

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
  initState() {
    super.initState();
    retrieveData().whenComplete(() async {
      Directory tempDir = await getTemporaryDirectory();
      var tempPath = tempDir.path;
      // await File('$tempPath/profile.png').delete();
      File file = File('$tempPath/profile.png');
      await file.writeAsBytes(bytesImage!.buffer
          .asUint8List(bytesImage!.offsetInBytes, bytesImage!.lengthInBytes));
      image = file;


      companyNameController.text = companyName;
      industryController.text = industry;
      locationController.text = location;
      emailController.text = email;
      phoneController.text = phone;
      aboutController.text = about;
      websiteController.text = website;
      linkedinController.text = linkedin;
      instagramController.text = instagram;
      twitterController.text = twitter;
      facebookController.text = facebook;
      setState(() {});
    });
  }

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
                    maxLines: 5,
                    label: 'About Your Company..',
                    textController: aboutController),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFE6E6E6)),
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
                    setState(() {

                    });
                  },
                  child: Text(
                    'Upload Image',
                    style: GoogleFonts.poppins(color: Colors.white),
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
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: (){
                            confirm == false ? confirm = true : confirm = false;
                            setState(() {});
                          },
                          icon: confirm == true ?
                          const Icon(Icons.check_box_outlined) :
                          const Icon(Icons.check_box_outline_blank)
                        ),
                      ),
                      const Expanded(
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
                      var value = base64Encode(image!.readAsBytesSync());

                      companyName = companyNameController.text;
                      industry = industryController.text;
                      location = locationController.text;
                      email = emailController.text;
                      phone = phoneController.text;
                      about = aboutController.text;
                      instagram = instagramController.text;
                      facebook = facebookController.text;
                      twitter = twitterController.text;
                      linkedin = linkedinController.text;
                      password = passwordController.text;
                      confirmPassword = confirmPasswordController.text;
                      website = websiteController.text;

                      if(confirm == false){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('verification not ticked'),
                        ));
                      }else if(companyName.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('company name minimum length 5'),
                        ));
                      }else if(industry.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('industry minimum length 5'),
                        ));
                      }else if(location.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('location minimum length 5'),
                        ));
                      }else if(email.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('email minimum length 5'),
                        ));
                      }else if(phone.length < 10){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('phone minimum length 5'),
                        ));
                      }else if(about.length <= 14){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('about minimum length 15'),
                        ));
                      }else if(website.length <= 14){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('website minimum length 5'),
                        ));
                      }else if(instagram.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('instagram link minimum length 5'),
                        ));
                      }else if(twitter.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('twitter link minimum length 5'),
                        ));
                      }else if(linkedin.length <= 5){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('linkedin link minimum length 5'),
                        ));
                      }else if(password.length <= 8){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('the password minimum length 8'),
                        ));
                      }else if(password == confirmPassword){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('the password and confirm password are different'),
                        ));
                      }else{
                        initializePreference(image: value);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OtpEmail(),
                          ),
                        );
                      }
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

  Future<void> initializePreference({
    required String image,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("image", image);
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

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
}
