import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/model/shortlisted_users_model.dart';
import 'package:jobs_way_company/pages/other_pages/assign_task.dart';
import 'package:jobs_way_company/pages/other_pages/task_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShortListedPage extends StatefulWidget {
  const ShortListedPage({Key? key}) : super(key: key);

  @override
  _ShortListedPageState createState() => _ShortListedPageState();
}

class _ShortListedPageState extends State<ShortListedPage> {
  final widgets = Get.put(WidgetController());

  Stream<ShortlistedUsers?> fetchShortlistedList() async* {
    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if (idGet != null) {
      id = idGet;
    }

    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/applicants/shortlisted/$id';

    print(apiUrl);

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final String responseString = response.body;

        // print('{"applicantsList":$responseString}');

        yield shortlistedUsersFromJson('{"shortListed":$responseString}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///heading
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widgets.headingVersaTexts(colorText: 'Short Listed.'),
                  widgets.greenButton(
                      label: 'Set Tasks',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TaskList(),
                          ),
                        );
                      }),
                ],
              ),
            ),

            ///application list
            Expanded(
              child: StreamBuilder(
                stream: fetchShortlistedList(),
                builder: (BuildContext context,
                    AsyncSnapshot<ShortlistedUsers?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.shortListed!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data!.shortListed![index];
                        return widgets.applicationList(
                          imageSrc: '${user.applications!.imgUrl}',
                          name: '${user.applications!.firstName} '
                                '${user.applications!.secondName}',
                          place: '${user.applications!.location}',
                          email: '${user.applications!.email}',
                          phone: '${user.applications!.phone}',
                          experience: '${user.applications!.experience} Years',
                          jobTitle: 'Sr.Flutter Developer',
                          button: widgets.textColorButton(
                            text: 'Assign Task',
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AssignTask(
                                    userId: user.applications!.userId!,
                                    jobId: user.id!
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
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
