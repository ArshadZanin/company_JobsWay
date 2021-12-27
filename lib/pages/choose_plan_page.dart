import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/pages/result_payment_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChoosePlanPage extends StatefulWidget {
  ChoosePlanPage({Key? key, required this.jobId, required this.jobName}) : super(key: key);

  String? jobId;
  String? jobName;

  @override
  _ChoosePlanPageState createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends State<ChoosePlanPage> {
  final widgets = Get.put(WidgetController());

  String amount = '';

  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
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
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: widgets.headingTexts(
                      blackText: 'Choose a ',
                    colorText: 'Plan.',
                  ),
                ),

                CarouselSlider(
                    items: [
                      freeCard(),
                      basicCard(),
                      premiumCard(),
                    ],
                    options: CarouselOptions(
                      height:  MediaQuery.of(context).size.width + 25,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      // autoPlayInterval: Duration(seconds: 3),
                      // autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (value, context){},
                      scrollDirection: Axis.horizontal,
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget freeCard(){
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgets.textWidget(
                      text: 'Free',
                      bold: true,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    ///amount of plan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widgets.textWidget(
                          text: ' \$0',
                          bold: true,
                          size: 70,
                          padding: const EdgeInsets.all(0.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widgets.textWidget(
                              text: '',
                              color: Colors.grey,
                              size: 14,
                              padding: const EdgeInsets.all(0.0),
                            ),
                            widgets.textWidget(
                              text: '/Job',
                              color: Colors.grey,
                              size: 14,
                              padding: const EdgeInsets.all(0.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ///expiry data
                    Center(
                      child: widgets.textWidget(
                          text: 'Job Show for 3 Days',bold: true),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    Center(
                      child: widgets.textWidget(
                          text: 'Only 1 job at a time.',bold: true,color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () async {


                ///here*********************************************************************************************************************************************************************///

                var result = await freeCardUse();

                if(result){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultPage(),),);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Sorry, You cant use this plan ',textAlign: TextAlign.center,),
                  ));
                }

              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
              ),
              tileColor: const Color(0xFF5B40FF),
              title: Center(
                child: widgets.textWidget(
                  text: 'Select Plan',
                  bold: true,
                  color: Colors.white,
                ),),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> freeCardUse() async {

    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if(idGet != null){
      id = idGet;
    }

    String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/add-free-plan/$id';

    print(widget.jobId);

    try{
      final response = await http.post(Uri.parse(apiUrl), body: {
        "jobId" : widget.jobId
      });
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(responseString);

        return true;
        // return loginFromJson(responseString);
      } else {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${result['error']}',textAlign: TextAlign.center,),
          ));
        }
        return false;
      }
    }on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check network connection',textAlign: TextAlign.center,),
      ));
      return false;
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return false;
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return false;
    }
  }

  Widget basicCard(){
    return Card(
      color: const Color(0xFF0A0047),
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widgets.textWidget(
                            text: 'Basic',
                            bold: true,
                            color: Colors.white
                        ),
                        widgets.greenButton(
                            onPress: (){},
                            label: 'Popular'),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    ///amount of plan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widgets.textWidget(
                          text: ' \$12',
                          bold: true,
                          size: 70,
                          color: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widgets.textWidget(
                              text: '',
                              color: Colors.grey,
                              size: 14,
                              padding: const EdgeInsets.all(0.0),
                            ),
                            widgets.textWidget(
                              text: '/Job',
                              color: Colors.grey,
                              size: 14,
                              padding: const EdgeInsets.all(0.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ///expiry data
                    Center(
                      child: widgets.textWidget(
                          text: 'Job Show for 15 Days',bold: true,color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    Center(
                      child: widgets.textWidget(
                          text: 'Only 10 jobs at a time.',bold: true,color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                ///here*********************************************************************************************************************************************************************///


                var order = await orderRequest(amount: '500');

                var result = jsonDecode(order!);

                amount = '${result["amount"]}';

                print(result["id"]);



                var options = {
                  'key': 'rzp_test_UmiUcM6L6WCULU',
                  // 'key': 'rzp_test_PLUV6vdv6Zjxw6',
                  'amount': result["amount"],
                  'name': 'JobsWay.',
                  'description': 'payment for add job',
                  'timeout': 300,
                  'order_id': result["id"],
                  'currency': result["currency"],
                  'prefill': {
                    'contact': '9746802988',
                    'email': 'arshadzanin786@gmail.com'
                  }
                };
                _razorpay.open(options);
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultPage(),),);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
              ),
              tileColor: const Color(0xFF5B40FF),
              title: Center(
                child: widgets.textWidget(
                  text: 'Select Plan',
                  bold: true,
                  color: Colors.white,
                ),),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> orderRequest({required String amount}) async {

    String id = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("hrId");
    if(idGet != null){
      id = idGet;
    }

    String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/razorpay/addjobpayment/$id';
    print(apiUrl);


    try{

      final response = await http.post(Uri.parse(apiUrl), body: {
        "amount": amount,
      });

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);
        return responseString;
        // return loginFromJson(responseString);
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
      return null;
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    }
  }

  Future<String?> orderConfirm({
  required String planName,
  required String paymentId,
  required String orderId,
}) async {

    String id = '';
    String name = '';

    final preferences = await SharedPreferences.getInstance();
    String? idGet = preferences.getString("id");
    String? nameGet = preferences.getString("name");
    if(idGet != null){
      id = idGet;
    }
    if(nameGet != null){
      name = nameGet;
    }

    try{

      String apiUrl = 'https://jobsway-company.herokuapp.com/api/v1/company/verify-payment';

      final response = await http.post(Uri.parse(apiUrl), body: {
        'id' : id,
        'companyName' : name,
        'amount' : amount,
        'jobId' : widget.jobId,
        'jobTitle' : widget.jobName,
        'planName' : planName,
        'paymentGateway' : "razorpay",
        'razorpay_payment_id': paymentId,
        'razorpay_order_id': orderId
      });

      print(apiUrl);
      print(paymentId);
      print(orderId);
      print(response.body);

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print("hello");
        print(responseString);
        return responseString;
        // return loginFromJson(responseString);
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
      return null;
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    } on Error catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',textAlign: TextAlign.center,),
      ));
      return null;
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    /// Do something when payment succeeds
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Payment Successful',
        textAlign: TextAlign.center,
      ),
    ));


    var result = await orderConfirm(
        planName: 'Basic',
        paymentId: response.paymentId!,
        orderId: '${response.orderId}',
    );
    print(result);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Payment complete',
        textAlign: TextAlign.center,
      ),
    ));

    print('${response.orderId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Payment Failed',
        textAlign: TextAlign.center,
      ),
    ));
    print('********************************on the way***********************************************');
    print('********************************${response.message} - ${response.code}***********************************************');
    print('********************************on the way***********************************************');
    print('failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Trying External Wallet',
        textAlign: TextAlign.center,
      ),
    ));
    print('trying');
  }



  Widget premiumCard(){
    return Card(
      color: const Color(0xFF0A0047),
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        widgets.textWidget(
                            text: 'Premium',
                            bold: true,
                            color: Colors.white
                        ),
                        const FaIcon(FontAwesomeIcons.crown,color: Colors.amber,),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    ///amount of plan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widgets.textWidget(
                          text: ' \$20',
                          bold: true,
                          size: 70,
                          color: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widgets.textWidget(
                              text: '',
                              color: Colors.grey,
                              size: 14,
                              padding: const EdgeInsets.all(0.0),
                            ),
                            widgets.textWidget(
                              text: '/Job',
                              color: Colors.grey,
                              size: 14,
                              padding: const EdgeInsets.all(0.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ///expiry data
                    Center(
                      child: widgets.textWidget(
                          text: 'Job Show for 30 Days',bold: true,color: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * .0001,),
                    Center(
                      child: widgets.textWidget(
                          text: 'Post Unlimited Jobs.',bold: true,color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultPage(),),);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )
              ),
              tileColor: const Color(0xFF5B40FF),
              title: Center(
                child: widgets.textWidget(
                  text: 'Select Plan',
                  bold: true,
                  color: Colors.white,
                ),),
            )
          ],
        ),
      ),
    );
  }



}
