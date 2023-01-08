import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wee/screens/driver_view.dart';

import '../Services/services.dart';

class DriverRequestList extends StatefulWidget {
  const DriverRequestList({super.key});

  @override
  State<DriverRequestList> createState() => _DriverRequestListState();
}

class _DriverRequestListState extends State<DriverRequestList> {
  Future<dynamic> getDriverRequestList() async {
    final data = await Services.getData('driver_list.php');
    return data;
  }

 approveDriver(String busId) async {
    final data = await Services.postData({'driver_id': busId}, 'approve_driver.php');
    if (data['result'] == 'approved') {
      Fluttertoast.showToast(msg: 'bus approved');
      setState(() {});
    }
  }

  rejectDriver(String busId) async {
    final data = await Services.postData({'driver_id': busId}, 'remove_driver.php');
    if (data['result'] == 'done') {
      Fluttertoast.showToast(msg: 'bus application rejected');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDriverRequestList(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (_)=>
                        DriverView(driverId: snap.data[index]['driver_id'])));
                      },
                      title: Text(snap.data[index]['name']),
                      subtitle: Text(snap.data[index]['mobile']),
                      trailing: snap.data[index]['status'] == '0'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                    onPressed: () {
                                      approveDriver(snap.data[index]['driver_id']);
                                    },
                                    child: Text('accept'),
                                    color: Colors.green),
                                SizedBox(
                                  width: 5,
                                ),
                                MaterialButton(
                                    onPressed: () {
                                      rejectDriver(snap.data[index]['driver_id']);
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
