import 'package:flutter/material.dart';
import 'package:wee/widgets/bus_request_list.dart';
import 'package:wee/widgets/driver_request_list.dart';
import 'package:wee/widgets/rto_drawer.dart';

class RtoHomepage extends StatelessWidget {
 const RtoHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const RtoDrawer(),
        appBar: AppBar(title: Text('Wee'),),
        bottomNavigationBar:Container(
          height: 70,
          color: Colors.white,
          child: const TabBar(
            labelColor:  Colors.blue,
            tabs: [
              Tab(
                icon: Icon(Icons.bus_alert),
                text: 'buses',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'drivers',
              )
            ],
          ),
        ),
        body:const TabBarView(
          // controller: ,
          children: [BusRequestList(), DriverRequestList()],
        ),
      ),
    );
  }
}
