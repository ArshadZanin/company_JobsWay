import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/pages/application_page.dart';
import 'package:jobs_way_company/pages/dashboard.dart';
import 'package:jobs_way_company/pages/jobs_page.dart';
import 'package:jobs_way_company/pages/shortlisted_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = Get.put(WidgetController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: widgets.appbarCustom(context),
        body: const TabBarView(
          children: <Widget>[
            DashboardPage(),
            JobsPage(),
            ApplicationPage(),
            ShortListedPage(),
          ],
        ),
        bottomNavigationBar: Material(
          color: const Color(0xFFF2F2F2),
          child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: const Color(0xFF008FAE),
              tabs: <Widget>[
                Tab(icon: const Icon(Icons.home,size: 28,), child: Text('Dashboard',style: GoogleFonts.poppins(fontSize: 12),)),
                Tab(icon: const Icon(Icons.pages,size: 28,), child: Text('Jobs',style: GoogleFonts.poppins(fontSize: 12),)),
                Tab(icon: const Icon(Icons.article,size: 28,), child: Text('Applications',style: GoogleFonts.poppins(fontSize: 12),)),
                Tab(icon: const Icon(Icons.list,size: 28,), child: Text('ShortListed',style: GoogleFonts.poppins(fontSize: 12),)),
              ]),
        ),
      ),
    );
  }
}
