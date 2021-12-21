import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/image_pick/utils.dart';
import 'package:jobs_way_company/model/register_model.dart';
import 'package:jobs_way_company/pages/waiting_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({String this.reRegister = '', Key? key}) : super(key: key);
  String? reRegister;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final widgets = Get.put(WidgetController());
  File? image;
  Uint8List? bytesImage;
  bool confirm = false;
  bool _isLoading = false;

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

  bool _isObscurePassword = true;
  bool _isObscureCPassword = true;

  Future<Registered?> registerCompany({
    required String companyName,
    required String industry,
    required String email,
    required String location,
    required String phone,
    required String bio,
    required String website,
    required String linkedin,
    required String facebook,
    required String twitter,
    required String instagram,
    required String password,
    required String image,
    required String imageExtension,
  }) async {
    try {
      final jsonMap = {
        "companyDetails": {
          "companyName": companyName,
          "industry": industry,
          "email": email,
          "location": location,
          "phone": phone,
          "bio": bio,
          "website": website,
          "linkedIn": linkedin,
          "facebook": facebook,
          "twitter": twitter,
          "instagram": instagram,
          "password": password
        },
        "image": """data:image/$imageExtension;base64,$image"""
      };

      String jsonData = jsonEncode(jsonMap);

      String apiUrl;

      if (widget.reRegister == '') {
        apiUrl =
            'https://jobsway-company.herokuapp.com/api/v1/company/register';
      } else {
        apiUrl =
            'https://jobsway-company.herokuapp.com/api/v1/company/reregister';
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonData,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final String responseString = response.body;
        return registeredFromJson(responseString);
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              '${result['error']}',
              textAlign: TextAlign.center,
            ),
          ));
        }
        return null;
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
  initState() {
    super.initState();
    retrieveData().whenComplete(() async {
      if (bytesImage != null) {
        Directory tempDir = await getTemporaryDirectory();
        var tempPath = tempDir.path;
        // await File('$tempPath/profile.png').delete();
        File file = File('$tempPath/profile.png');
        await file.writeAsBytes(bytesImage!.buffer
            .asUint8List(bytesImage!.offsetInBytes, bytesImage!.lengthInBytes));
        image = file;
      }

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
                    child: image == null ? Container() : Image.file(image!),
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
                    setState(() {});
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
                widgets.textFieldGreyObscure(
                  label: 'Password',
                  textController: passwordController,
                  onPress: () {
                    _isObscurePassword
                        ? _isObscurePassword = false
                        : _isObscurePassword = true;
                    setState(() {});
                  },
                  obscure: _isObscurePassword,
                ),
                widgets.textFieldGreyObscure(
                  label: 'Confirm Password',
                  textController: confirmPasswordController,
                  onPress: () {
                    _isObscureCPassword
                        ? _isObscureCPassword = false
                        : _isObscureCPassword = true;
                    setState(() {});
                  },
                  obscure: _isObscureCPassword,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              confirm == false
                                  ? confirm = true
                                  : confirm = false;
                              setState(() {});
                            },
                            icon: confirm == true
                                ? const Icon(Icons.check_box_outlined)
                                : const Icon(Icons.check_box_outline_blank)),
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
                  child: widgets.textColorButtonCircle(
                    text: 'Register Your Company',
                    onPress: () async {
                      FocusScope.of(context).requestFocus(FocusNode());

                      _isLoading = true;

                      setState(() {});

                      if (image == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Add Image',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        return;
                      }

                      String fileExtension =
                          image!.path.split('/').last.split('.').last;

                      final bytes = await image!.readAsBytes();
                      var value = base64.encode(bytes);

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

                      List<String> aboutList = about.split(' ');

                      if (confirm == false) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'verification not ticked',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (companyName.length <= 5) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'company name minimum length 5',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (industry.length <= 5) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'industry minimum length 5',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (location.length <= 5) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'location minimum length 5',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (email.length <= 5) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'email minimum length 5',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (phone.length == 10) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'phone minimum length 5',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (aboutList.length <= 20) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'about minimum length 20',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (password.length <= 8) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'the password minimum length 8',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else if (password != confirmPassword) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'the password and confirm password are different',
                            textAlign: TextAlign.center,
                          ),
                        ));
                        _isLoading = false;
                        setState(() {});
                      } else {
                        var result = await registerCompany(
                            companyName: companyName,
                            industry: industry,
                            email: email,
                            location: location,
                            phone: phone,
                            bio: about,
                            website: website,
                            linkedin: linkedin,
                            facebook: facebook,
                            twitter: twitter,
                            instagram: instagram,
                            password: password,
                            image: value,
                            imageExtension: fileExtension);

                        if (result == null) {
                          _isLoading = false;
                        } else if (result.company!.id != null) {
                          initializePreference(
                            image: value,
                            id: result.company!.id!,
                          );

                          if (result.company!.status == false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WaitingPage(
                                  name: companyName,
                                  id: result.company!.id!,
                                ),
                              ),
                            );
                          }
                        }
                      }
                    },
                    isLoading: _isLoading,
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
    required String id,
  }) async {
    final preferences = await SharedPreferences.getInstance();
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

  Future<void> retrieveData() async {
    final preferences = await SharedPreferences.getInstance();
    String? result = preferences.getString("image");
    if (result != null) {
      bytesImage = base64Decode(result);
    }

    String? companyNameGet = preferences.getString("companyName");
    companyName = companyNameGet ?? '';

    String? industryGet = preferences.getString("industry");
    industry = industryGet ?? '';

    String? locationGet = preferences.getString("location");
    location = locationGet ?? '';

    String? emailGet = preferences.getString("email");
    email = emailGet ?? '';

    String? phoneGet = preferences.getString("phone");
    phone = phoneGet ?? '';

    String? aboutGet = preferences.getString("about");
    about = aboutGet ?? '';

    String? websiteGet = preferences.getString("website");
    website = websiteGet ?? '';

    String? linkedinGet = preferences.getString("linkedin");
    linkedin = linkedinGet ?? '';

    String? instagramGet = preferences.getString("instagram");
    instagram = instagramGet ?? '';

    String? twitterGet = preferences.getString("twitter");
    twitter = twitterGet ?? '';

    String? facebookGet = preferences.getString("facebook");
    facebook = facebookGet ?? '';

    String? passwordGet = preferences.getString("password");
    password = passwordGet ?? '';
    // confirmPassword = passwordGet;

    setState(() {});
  }

  Future<File?> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
}
