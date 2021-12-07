import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/pages/profile_page.dart';

class WidgetController extends GetxController {
  Widget headingTexts({required String blackText, String colorText = ''}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          blackText,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          colorText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF008FAE),
          ),
        ),
      ],
    );
  }

  Widget headingVersaTexts({String blackText = '', required String colorText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          colorText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF008FAE),
          ),
        ),
        Text(
          blackText,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  Widget buttonWithText({
    required String text,
    required String buttonText,
    required Function() onPress,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xff008080),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldGrey(
      {String label = '', TextEditingController? textController}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFE6E6E6),
      ),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xffAEAEAE),
          ),
        ),
      ),
    );
  }

  Widget textColorButton({
    required String text,
    required Function() onPress,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF008FAE)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  PreferredSizeWidget appbarCustom(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFF2F2F2),
      iconTheme: const IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Jobs',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Way.',
            style: TextStyle(color: Color(0xFF008FAE)),
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.account_circle_outlined,
            )),
      ],
    );
  }

  Widget jobCardBlack({
    required String jobName,
    String? salaryRange,
    String? experience,
    required String postTime,
    String jobTime = 'full time / part time',
    Function()? onTap,
  }) {
    return Card(
      color: const Color(0xFF2C2C2C),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          onTap: onTap,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '₹$salaryRange',
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$experience experience',
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$postTime ago',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                jobTime,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: const Text(
                  'see applicants',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconTextButton(
      {required IconData icon,
      required String text,
      required Function() onPress}) {
    return TextButton(
      onPressed: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xff000000),
            size: 50,
          ),
          Text(
            text,
            style: const TextStyle(color: Color(0xff000000)),
          ), //0xff008080
        ],
      ),
    );
  }

  Widget completeTaskCard({
    required Function() onPress,
    required String srcImage,
    required String companyName,
    String? companyLocation,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: const Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.network(
                            srcImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            companyName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            companyLocation!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Text(
                  'Complete Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Questions\t: 4',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Duration\t: 30 min',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: textColorButton(
                          text: 'Start Task', onPress: onPress)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pendingField(Function()? onPress) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE39C)),
      ),
      onPressed: onPress,
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          'PENDING',
          style: TextStyle(color: Color(0xff945900)),
        ),
      ),
    );
  }

  Widget approvedField(Function()? onPress) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF03C852)),
      ),
      onPressed: onPress,
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          'APPROVED',
          style: TextStyle(color: Color(0xff435737)),
        ),
      ),
    );
  }

  Widget rejectField(Function()? onPress) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFFFF4E4E)),
      ),
      onPressed: onPress,
      child: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Text(
          'REJECTED',
          style: TextStyle(color: Color(0xff4F3030)),
        ),
      ),
    );
  }

  Widget jobDetailsCard({
    required Widget statusWidget,
    required String srcImage,
    required String jobName,
    String jobLocation = '',
  }) {
    return Card(
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Image.network(
              srcImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          jobName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          jobLocation,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        trailing: statusWidget,
      ),
    );
  }

  Widget skillText({required String text}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Widget dashContainer(int count, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFE6E6E6)),
        child: Column(
          children: [
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget applicantList({required String name, required Function() onPress}) {
    return Card(
      color: const Color(0xFFB8E8F2),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF004756),
          ),
        ),
        subtitle: const Text('has completed the task'),
        trailing: Column(
          children: [
            greenButton(label: 'Contact', onPress: onPress),
          ],
        ),
      ),
    );
  }

  Widget greenButton({required Function() onPress, required String label}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFF03C852),
        ),
      ),
      onPressed: onPress,
      child: Text(label),
    );
  }

  Widget redButton({Function()? onPress, required String label}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xFFFF4E4E),
        ),
      ),
      onPressed: onPress,
      child: Text(label),
    );
  }

  Widget blueButton({Function()? onPress, required String label, bool colorGrey = false}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          colorGrey == false ? const Color(0xFF0060A5) : const Color(0xFFE6E6E6),
        ),
      ),
      onPressed: onPress,
      child: Text(
        label,
        style: TextStyle(
            color: colorGrey == false ?
            Colors.white :
            Colors.black,
        ),
      ),
    );
  }

  Widget applicationList(
      {required String imageSrc,
      required String name,
      required String place,
      required String email,
      required String phone,
      required String experience,
      required String jobTitle,
      required Widget button}) {
    return Card(
      color: const Color(0xFFE6E6E6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 140,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  // child: Image.network(imageSrc,fit: BoxFit.cover,),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      iconText(icon: Icons.location_on_outlined, text: place),
                      iconText(icon: Icons.email_outlined, text: email),
                      iconText(icon: Icons.phone_outlined, text: phone),
                      iconText(
                          icon: Icons.person_pin_outlined, text: 'Portfolio'),
                      iconText(
                          icon: Icons.text_snippet_outlined, text: 'Resume'),
                      iconText(
                          icon: Icons.upcoming_outlined,
                          text: '$experience of Experience'),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Applied For : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    jobTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            button,
          ],
        ),
      ),
    );
  }

  Widget iconText({IconData? icon,
    String text = '',
    double textSize = 14.0,
    double? iconSize,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: iconSize,
        ),
        const SizedBox(width: 5,),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: textSize),
        ),
      ],
    );
  }

  Widget textWidget({
    required String text,
    double size = 20.0,
    Color color = Colors.black,
    bool bold = false,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
  }){
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: bold == true ? FontWeight.bold : null,
          fontSize: size
        ),
      ),
    );
  }

}
