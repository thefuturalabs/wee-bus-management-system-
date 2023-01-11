import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wee/Services/services.dart';
import 'package:wee/screens/driver/bus_add_screen.dart';
import 'package:wee/screens/driver/bus_status_screen.dart';
import 'package:wee/widgets/driver_drawer.dart';

class DriverHomepage extends StatefulWidget {
  const DriverHomepage({super.key});

  @override
  State<DriverHomepage> createState() => _DriverHomepageState();
}

class _DriverHomepageState extends State<DriverHomepage> {
  Future<dynamic> getBusList() async {
    String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'driver_id': uid}, 'driver_bus_list.php');
    return data;
  }
Future<void >refresh()async{
  setState(() {
    
  });
}
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: DriverDrawer(),
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
              if (snap.data[0]['message'] == 'Failed') {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: Padding(
                    padding: EdgeInsets.only(top: height-10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('No buses yet')),
                  ));
              } else {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    
                      itemCount: snap.data.length,
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              print('id passing to bus view>>>>>${snap.data[index]["bus_id"]}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BusStatusScreen(
                                      busId: snap.data[index]['bus_id']),
                                ),
                              );
                            },
                            title: Text(snap.data[index]['name']),
                            subtitle: Text(snap.data[index]['number']),
                          ),
                        );
                      }),
                );
              }
            }
          }),
    );
  }
}
