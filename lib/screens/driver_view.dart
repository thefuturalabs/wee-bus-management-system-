import 'package:flutter/material.dart';
import 'package:wee/Services/services.dart';
import 'package:wee/constants.dart';

class DriverView extends StatefulWidget {
  DriverView({super.key, required this.driverId});
  String driverId;

  @override
  State<DriverView> createState() => _BusViewState();
}

class _BusViewState extends State<DriverView> {
  // int stepIndex = 0;

  Future<dynamic> getDriverDetails() async {
    final data = await Services.postData(
        {'driver_id': widget.driverId}, 'driver_view.php');
    return data.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getDriverDetails(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name',
                        style:
                            TextStyle(color: Color.fromARGB(255, 84, 84, 84)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snap.data['name'],
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snap.data['status'] == '0'
                                ? 'application pending'
                                : snap.data['status'] == '1'
                                    ? 'Approved'
                                    : 'application rejected',
                            style: TextStyle(
                                color: snap.data['status'] == '0'
                                    ? Colors.blue
                                    : snap.data['status'] == '1'
                                        ? Colors.green
                                        : Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        'mobile',
                        style:
                            TextStyle(color: Color.fromARGB(255, 84, 84, 84)),
                      ),
                      Text(
                        snap.data['mobile'],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'license',
                        style:
                            TextStyle(color: Color.fromARGB(255, 84, 84, 84)),
                      ),
                      SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.network(
                              Constants.imageUrl + snap.data['licence']))
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
