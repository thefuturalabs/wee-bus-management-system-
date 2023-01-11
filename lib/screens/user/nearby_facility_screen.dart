import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:wee/Services/services.dart';
// import 'package:geolocator/geolocator.dart'as geo;

class NearbyFaciliyScreen extends StatelessWidget {
  NearbyFaciliyScreen({super.key});

  // var facilities ;

  Future<dynamic> getFacilities() async {
    final facilities = await Services.getData('fecility_list.php');
    print('11111 ${facilities.runtimeType}');
    LocationData loc = await Location().getLocation();
    facilities.forEach((element) {
      (element).addAll({
        'distance': calculateDistance(
            myLatitude: loc.latitude!,
            myLongitude: loc.longitude!,
            targetLatitude: double.parse(element['location']!.split(',').first),
            targetLongitude: double.parse(element['location']!.split(',')[1]))
      });
    });
    // print(facilities);
    (facilities as List).sort((a, b) => a['distance'].compareTo(b['distance']));
    return facilities;
  }

  double calculateDistance({
    required double myLatitude,
    required double myLongitude,
    required double targetLatitude,
    required double targetLongitude,
  }) {
    return Geolocator.distanceBetween(
        myLatitude, myLongitude, targetLatitude, targetLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby facilities'),),
      body: FutureBuilder(
          future: getFacilities(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snap.data[index]['name']),
                        subtitle: Text('${(snap.data[index]['distance']/1000).toStringAsFixed(2)} Kms'),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
