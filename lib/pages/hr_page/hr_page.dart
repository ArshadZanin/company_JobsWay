import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/model/fetch_hr_model.dart';
import 'package:jobs_way_company/pages/hr_page/add_hr_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HrPage extends StatefulWidget {
  const HrPage({Key? key}) : super(key: key);

  @override
  _HrPageState createState() => _HrPageState();
}

class _HrPageState extends State<HrPage> {
  final widgets = Get.put(WidgetController());

  Future<FetchHr?> fetchHrList() async {
    final preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString("id");
    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/get-all-hr/$id';
    print(apiUrl);

    try {
      final response = await http.get(Uri.parse(apiUrl));

      print(response.statusCode);
      if (response.statusCode == 200) {
        final String responseString = '{"HrDetails":${response.body}}';
        print(responseString);
        return fetchHrFromJson(responseString);
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

  Future<void> deleteHr({required String hrId}) async {
    final preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString("id");
    String apiUrl =
        'https://jobsway-company.herokuapp.com/api/v1/company/delete-hr/$id';
    print(apiUrl);

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {"hrId": hrId});

      print(response.statusCode);
      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(responseString);
        // fetchHrList();
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          'HR Details.',
          style: GoogleFonts.poppins(
            color: const Color(0xFF008FAE),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddHR(),
                ),
              );
            },
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
        elevation: 0,
      ),
      //
      body: FutureBuilder(
          future: fetchHrList(),
          builder: (BuildContext context, AsyncSnapshot<FetchHr?> snapshot) {
            if (snapshot.hasData) {
              var hr = snapshot.data!.hrDetails!;
              return ListView.builder(
                  itemCount: hr.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.blue[100],
                      elevation: 1,
                      child: ListTile(
                        leading: SizedBox(
                          height: double.infinity,
                          width: 50,
                          child: Center(
                            child: Text(
                              '${hr[index].status}',
                              style: hr[index].status == 'active' ?
                              const TextStyle(color: Colors.green):
                              const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        title: Text("Name : ${hr[index].name}"),
                        subtitle: Text("Email : ${hr[index].email}"),
                        trailing: IconButton(
                          onPressed: () {
                            deleteHr(hrId: hr[index].id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
