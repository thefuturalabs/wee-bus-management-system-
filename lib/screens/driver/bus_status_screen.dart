import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:wee/Services/services.dart';

class BusStatusScreen extends StatefulWidget {
  BusStatusScreen({super.key, required this.busId});
  String busId;

  @override
  State<BusStatusScreen> createState() => _BusStatusScreenState();
}

class _BusStatusScreenState extends State<BusStatusScreen> {
  String? issue;
  bool start = false;

  reportIssue(String issue) async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'driver_id': uid, 'bus_id': widget.busId, 'issue': issue},
        'add_issue.php');
    if (data['result'] == 'done') {
      Fluttertoast.showToast(msg: 'issue reported');
      getCurrentIssue();
    }
  }

  getCurrentIssue() async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData({
      'bus_id': widget.busId,
    }, 'view_issue.php');
    setState(() {
      issue = data.last['issue'];
    });
  }

  updateLocation() async {
    String uid = await Services.getUserId() ?? '2';
    if (start) {
      Location().onLocationChanged.listen((event) {
        Services.postData({
          'bus_id': widget.busId,
          'location': '${event.latitude},${event.longitude}',
          'driver_id': uid,
        }, 'location_update.php');
      });
    }
  }

  stopBus() async {
    String uid = await Services.getUserId() ?? '2';
    LocationData loc = await Location().getLocation();
    final data = await Services.postData({
      'bus_id': widget.busId,
      'location': '${loc.latitude},${loc.longitude}',
      'driver_id': uid,
    }, 'stop_bus.php');
    if (data['result'] == 'done') {
      setState(() {
        start = false;
      });
      Fluttertoast.showToast(msg: 'Bus stopped');
    }
  }

  startBus() async {
    String uid = await Services.getUserId() ?? '2';
    LocationData loc = await Location().getLocation();
    final data = await Services.postData({
      'bus_id': widget.busId,
      'location': '${loc.latitude},${loc.longitude}',
      'driver_id': uid,
    }, 'start_bus.php');
    if (data['result'] == 'done') {
      setState(() {
        start = true;
      });
      Fluttertoast.showToast(msg: 'Bus started');
    }
    updateLocation();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentIssue();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    color: start ? Colors.white : Colors.transparent,
                    child: MaterialButton(
                      color: Colors.green,
                      onPressed: startBus,
                      child: SizedBox(
                        height: 100,
                        child: Center(
                          child: Text('START'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    color: !start ? Colors.white : Colors.transparent,
                    child: MaterialButton(
                      elevation: 5,
                      color: Colors.red,
                      onPressed: stopBus,
                      child: const SizedBox(
                        height: 100,
                        child: Center(
                          child: Text('STOP'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    color: issue == 'block' ? Colors.white : Colors.transparent,
                    child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          reportIssue('block');
                        },
                        child: SizedBox(
                            height: 100, child: Center(child: Text('BLOCK')))),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    color: issue == 'breakdown'
                        ? Colors.white
                        : Colors.transparent,
                    child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          reportIssue('breakdown');
                        },
                        child: SizedBox(
                            height: 100,
                            child: Center(child: Text('BREAKDOWN')))),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(2),
                color: issue == 'accident' ? Colors.white : Colors.transparent,
                child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      reportIssue('accident');
                    },
                    child: SizedBox(
                        height: 100,
                        width: width / 2,
                        child: Center(child: Text('ACCIDENT')))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
