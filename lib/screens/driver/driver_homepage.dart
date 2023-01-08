import 'package:flutter/material.dart';
import 'package:location/location.dart' ;
import 'package:wee/Services/services.dart';
import 'package:wee/screens/driver/bus_add_screen.dart';
import 'package:wee/screens/driver/bus_status_screen.dart';

class DriverHomepage extends StatelessWidget {
  const DriverHomepage({super.key});

  Future<dynamic> getBusList() async {
    String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'driver_id': uid}, 'driver_bus_list.php');
    return data;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wee'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BusAddScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
          future: getBusList(),
          builder: (_, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BusStatusScreen(busId: snap.data[index]['bus_id']),
                            ),
                          );
                        },
                        title: Text(snap.data[index]['name']),
                        subtitle: Text(snap.data[index]['number']),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
