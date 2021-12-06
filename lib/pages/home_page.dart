import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobs_way_company/controller/widget_controller.dart';
import 'package:jobs_way_company/pages/dashboard.dart';


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
            DashboardPage(),
            DashboardPage(),
            DashboardPage(),
          ],
        ),
        bottomNavigationBar: const Material(
          color: Color(0xFFF2F2F2),
          child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Color(0xFF008FAE),
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home,size: 28,), child: Text('Dashboard',style: TextStyle(fontSize: 12),)),
                Tab(icon: Icon(Icons.pages,size: 28,), child: Text('Jobs',style: TextStyle(fontSize: 12),)),
                Tab(icon: Icon(Icons.article,size: 28,), child: Text('Applications',style: TextStyle(fontSize: 12),)),
                Tab(icon: Icon(Icons.list,size: 28,), child: Text('ShortListed',style: TextStyle(fontSize: 12),)),
              ]),
        ),
      ),
    );
  }
}
