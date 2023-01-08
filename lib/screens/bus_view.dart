import 'package:flutter/material.dart';
import 'package:wee/Services/services.dart';

class BusView extends StatefulWidget {
  BusView({super.key, required this.busId});
  String busId;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getBusDetails(),
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
                        snap.data['name'],
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        snap.data['number'],
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
                          Step(
                              title: FutureBuilder(
                                  future: Services.getPlaceName(
                                      
                                          snap.data['from'].split(',')[0],
                                      
                                          snap.data['from'].split(',')[1]),
                                  builder: (context, snap) {
                                    if (!snap.hasData) {
                                      return Text('...');
                                    }
                                    return Text(snap.data!);
                                  }),
                              content: Text('')),
                          Step(
                              title: FutureBuilder(
                                  future: Services.getPlaceName(
                                      
                                          snap.data['to'].split(',')[0],
                                      
                                          snap.data['to'].split(',')[1]),
                                  builder: (context, snap) {
                                    if (!snap.hasData) {
                                      return Text('...');
                                    }
                                    return Text(snap.data!);
                                  }),
                              content: Text('')),
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
