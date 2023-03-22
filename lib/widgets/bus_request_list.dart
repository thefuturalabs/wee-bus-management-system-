import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wee/screens/bus_view.dart';

import '../Services/services.dart';

class BusRequestList extends StatefulWidget {
  const BusRequestList({super.key});

  @override
  State<BusRequestList> createState() => _BusRequestListState();
}

class _BusRequestListState extends State<BusRequestList> {
  Future<dynamic> getBusRequestList() async {
    final uid = await Services.getUserId() ?? '2';
    print(uid);
    final rtoPlaces = await Services.getData('district_list.php');
    print(rtoPlaces);
    final place = (rtoPlaces.firstWhere((e) => e['rto_id'] == uid))['district'];
    print(place);
    print('rto place $place');
    final data = await Services.postData({'district': place}, 'bus_list.php');
    print('district wise buses $data');
    return data;
  }

  approveBus(String busId) async {
    final data = await Services.postData({'bus_id': busId}, 'approve_bus.php');
    if (data['result'] == 'approved') {
      Fluttertoast.showToast(msg: 'bus approved');
      setState(() {});
    }
  }

  rejectBus(String busId) async {
    final data = await Services.postData({'bus_id': busId}, 'remove_bus.php');
    if (data['result'] == 'done') {
      Fluttertoast.showToast(msg: 'bus application rejected');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBusRequestList(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if(snap.data.first['message']=='Failed to View'){
            return Center(child: Text('No Bus Requests yet'));
          }else{
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BusView(busId:snap.data[index]['bus_id'] ),
                          ),
                        );
                      },
                      title: Text(snap.data[index]['name']),
                      subtitle: Row(
                        children: [
                          // Text('from '),
                          FutureBuilder(
                              future: Services.getPlaceName(  
                                  
                                      snap.data[index]['from'].split(',')[0],
                                  
                                      snap.data[index]['from'].split(',')[1]),
                              builder: (context, snap) {
                                if (!snap.hasData) {
                                  return Text('...');
                                }
                                return Text(snap.data!);
                              }),
                          Text(' - '),
                          FutureBuilder(
                              future: Services.getPlaceName(
                                  
                                      snap.data[index]['to'].split(',')[0],
                                  
                                      snap.data[index]['to'].split(',')[1]),
                              builder: (context, snap) {
                                if (!snap.hasData) {
                                  return Text('...');
                                }
                                return Text(snap.data!);
                              })
                        ],
                      ),
                      trailing: snap.data[index]['status'] == '0'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                    onPressed: () {
                                      approveBus(snap.data[index]['bus_id']);
                                    },
                                    child: Text('accept'),
                                    color: Colors.green),
                                SizedBox(
                                  width: 5,
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      rejectBus(snap.data[index]['bus_id']);
                                    },
                                    child: Text('reject'),
                                    color: Colors.red),
                              ],
                            )
                          : snap.data[index]['status'] == '1'
                              ? Text(
                                  'approved',
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  'rejected',
                                  style: TextStyle(color: Colors.red),
                                ),
                    ),
                  );
                });
          }
        });
  }
}
