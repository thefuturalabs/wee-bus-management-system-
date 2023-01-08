import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getplaceName();
    // Geolocator.checkPermission().then((value) {
    //   print(value.name);
    // });
    // Geolocator.requestPermission().then((value) {
    //   Geolocator.getCurrentPosition().then((value) {
    //     print(value.latitude);
    //     locationFromAddress('nanminda').then((value) {
    //       value.forEach((element) { 
    //         print(
    //           '${element.latitude},${element.longitude}'
    //         );
    //       });
    //     });
    //     placemarkFromCoordinates(value.latitude, value.longitude).then((value) {
    //       value.forEach((element) {
    //         print(element.locality);
    //       });
    //     });
    //   });
    // });
  }

  getplaceName()async{
    final data=await placemarkFromCoordinates(11.4381153,75.8417745);
    print(data.first.locality);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
