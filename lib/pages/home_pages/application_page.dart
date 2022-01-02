import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:http/http.dart' as http;
import 'package:jobs_way_company/model/fetch_applicants_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  final widgets = Get.put(WidgetController());

  Stream<FetchApplicants?> fetchApplicantsList() async* {
    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if (idGet != null) {
      id = idGet;
    }

    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/jobs/applied-users/$id';

    print(apiUrl);

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        // print('{"applicantsList":$responseString}');

        yield fetchApplicantsFromJson('{"applicantsList":$responseString}');
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
        yield null;
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

  Future<void> addToShortlist(
      {required String jobId, required String userId}) async {
    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if (idGet != null) {
      id = idGet;
    }

    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/applicants/shortlist/$id';

    print(apiUrl);

    try {
      final response = await http.patch(Uri.parse(apiUrl), body: {
        'jobId': jobId,
        'userId': userId,
      });

      if (response.statusCode == 200) {
        final String responseString = response.body;

        // print('{"applicantsList":$responseString}');

        print(responseString);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Applicant shortlisted',
            textAlign: TextAlign.center,
          ),
        ));
        // return fetchApplicantsFromJson('{"applicantsList":$responseString}');
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
    // fetchApplicantsList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///heading
            Row(
              children: [
                widgets.headingVersaTexts(colorText: 'Applications.'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            ///application list
            Expanded(
              child: StreamBuilder(
                stream: fetchApplicantsList(),
                builder: (BuildContext context,
                    AsyncSnapshot<FetchApplicants?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.applicantsList!.length,
                        itemBuilder: (context, index) {
                          final applicant =
                              snapshot.data!.applicantsList![index];
                          return widgets.applicationList(
                            imageSrc: '${applicant.applications!.imgUrl}',
                            name:
                                '${applicant.applications!.firstName} ${applicant.applications!.secondName}',
                            place: '${applicant.applications!.location}',
                            email: '${applicant.applications!.email}',
                            phone: '${applicant.applications!.phone}',
                            experience: '${applicant.applications!.experience}',
                            jobTitle: '${applicant.jobTitle}',
                            button: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                widgets.greenButton(
                                    label: 'Add to Shortlist',
                                    onPress: () {
                                      addToShortlist(
                                          userId:
                                              '${applicant.applications!.userId}',
                                          jobId: '${applicant.id}');
                                    }),
                                widgets.redButton(
                                    label: 'Reject Request', onPress: () {
                                      setState(() {

                                      });
                                }),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      // child: CircularProgressIndicator(),
                      child: Platform.isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

