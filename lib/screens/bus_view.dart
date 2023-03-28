import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wee/Services/services.dart';

class BusView extends StatefulWidget {
  BusView({super.key, required this.busId, this.issue = ''});
  String busId;
  String issue;
  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  // int stepIndex = 0;

 

  Future<dynamic> getBusDetails() async {
    final data =
        await Services.postData({'bus_id': widget.busId}, 'bus_view.php');
    return data.first;
  }

// Stream<String> viewBusLocation() async* {
//   while (true) {
//     // Fetch data from API and store it in a variable
//     final data = await _fetchData();

//     // Emit the data to the stream
//     yield data;

//     // Wait for a minute before fetching data again
//     await Future.delayed(const Duration(minutes: 1));
//   }
// }

// Future<String> _fetchData() async {
//   print('hi');
//     // final data =
//     //     await Services.postData({'bus_id': widget.busId}, 'view_location.php');
//     //      data.last['location'];
//     //  return   Services.getPlaceName(data.last['location'].split(',').first, data.last['location'].split(',')[1]);
//     return 'hi';

// }

  Future<String> getCurrentPlace() async {
    final data =
        await Services.postData({'bus_id': widget.busId}, 'view_location.php');
    data.last['location'];
    return await Services.getPlaceName(data.last['location'].split(',').first,
        data.last['location'].split(',')[1]);
  }

  @override
  Widget build(BuildContext context) {
    print('kkkkkkkk${widget.issue}');
    return Scaffold(
      body: FutureBuilder(
          future: getBusDetails(),
          builder: (context, globalSnap) {
            if (!globalSnap.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              print('????????????????${globalSnap.data}');
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        globalSnap.data['name'],
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        globalSnap.data['number'],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Divider(),
                      Text(
                        'Route',
                        style: TextStyle(fontSize: 20),
                      ),

                      Stepper(
                        
                        steps: [
                          Step(isActive: false,
                          
                            title: FutureBuilder(
                                future: Services.getPlaceName(
                                    globalSnap.data['from'].split(',')[0],
                                    globalSnap.data['from'].split(',')[1]),
                                builder: (context, snap) {
                                  if (!snap.hasData) {
                                    return Text('...');
                                  } else {
                                    return Text(snap.data!);
                                  }
                                }),
                            content: Text(''),
                          ),
                          Step(
                            label: Text('data'),
                            title: StreamBuilder(
                                stream: Stream.periodic(Duration(seconds: 5)),
                                builder: (context, snap) {
                                  return widget.issue == ''
                                      ? FutureBuilder(
                                          future: getCurrentPlace(),
                                          builder: (conext, snap) {
                                            if (!snap.hasData) {
                                              return Text('...');
                                            }
                                            {
                                              return Text(snap.data!);
                                            }
                                          })
                                      : Text(
                                          'Reported ${widget.issue}',
                                          style: TextStyle(color: Colors.red),
                                        );
                                }),
                            content: Text(''),
                          ),
                          Step(
                            title: FutureBuilder(
                                future: Services.getPlaceName(
                                    globalSnap.data['to'].split(',')[0],
                                    globalSnap.data['to'].split(',')[1]),
                                builder: (context, snap) {
                                  if (!snap.hasData) {
                                    return Text('...');
                                  }
                                  return Text(snap.data!);
                                }),
                            content: Text(''),
                          ),
                        ],
                      )
                      // Step(title: title, content: content)
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
