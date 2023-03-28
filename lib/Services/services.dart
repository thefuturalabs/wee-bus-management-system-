import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Services {
  static Future<bool> isNotificationRead() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    int number = spref.getInt('noti') ?? 0;
    final data = await Services.getData('view_notification.php');
    return data.length == number;
  }

  static Future<String?> getDate(BuildContext context) async {
    try {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime.now());
      if (pickedDate != null) {
        return DateFormat('dd/MM/yyyy').format(pickedDate);
      }
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: 'something went wrong, $error');
    }
  }

  static Future<dynamic> postData(Map params, String endPoint) async {
    try {
      Response res = await post(
        Uri.parse(Constants.baseUrl + endPoint),
        body: params,
      );
      print('response for $endPoint>>${res.body}');
      return jsonDecode(res.body);
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: 'something went wrong, $error');
    }
  }

  static getData(String endPoint) async {
    try {
      Response res = await get(
        Uri.parse(Constants.baseUrl + endPoint),
      );
      print('response for $endPoint >> ${res.body}');
      return jsonDecode(res.body);
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: 'something went wrong, $error');
    }
  }

  static Future<dynamic> postWithIamge({
    required String endPoint,
    required Map params,
    required File image,
    required String imageParameter,
  }) async {
    try {
      var res;
      var request =
          MultipartRequest("POST", Uri.parse(Constants.baseUrl + endPoint));
      params.entries.forEach((element) {
        request.fields[element.key] = element.value;
      });
      // request.fields['user'] = 'someone@somewhere.com';
      request.files.add(await MultipartFile.fromPath(
        imageParameter,
        image.path,
        // contentType: new MediaType('application', 'x-tar'),
      ));
      final response = await request.send();

      if (response.statusCode == 200) print("Uploaded!");
      final data = await Response.fromStream(response);
      print('image api response: ${data.body}');
      res = jsonDecode(data.body);

      return res;
    } on Exception catch (error) {
      Fluttertoast.showToast(msg: 'something went wrong, $error');
    }
  }

  static Future<File?> pickImage(BuildContext context) async {
    XFile? pickedFile;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Select source'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Text('camera'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Text('gallery'),
                ),
              ],
            ));

    print('>>>>>>>>>${pickedFile!.name}');

    if (pickedFile != null) {
      return File(pickedFile!.path);
    }
  }

  static Future<String?> getUserId() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String? uid = spref.getString('userId');
    print('user id: ${uid ?? "not found"}');
    return spref.getString('userId');
  }

  static Future<String?> getUserType() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String? uid = spref.getString('type');
    print('user type: ${uid ?? "not found"}');
    return spref.getString('type');
  }

  static Future<String> getPlaceName(String latitude, String longitude) async {
    final data = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    // print(data);
    print(
        'placename from coordinates $latitude, $longitude>> ${data.first.locality}');
    return data.first.locality ?? 'unknown place';
  }

  static Future<String> getCoordinates(String placeName) async {
    final data = await locationFromAddress(placeName);
    print(
        'coordinates from placename $placeName >> ${data.first.latitude},${data.first.longitude}');
    return '${data.first.latitude},${data.first.longitude}';
  }

  static checkConnection() {
    Socket.connect(Constants.baseUrl.split('/')[2].trim(), 80,
            timeout: Duration(seconds: 5))
        .then((socket) {
      print("Connection Success");
      socket.destroy();
    }).catchError((error) {
      Socket.connect(Constants.baseUrl.split('/')[2].trim(), 8080,
              timeout: Duration(seconds: 5))
          .then((socket) {
        print("Connection Success");
        socket.destroy();
      }).catchError((error) {
        Fluttertoast.showToast(
            msg:
                'Connection error at ${Constants.baseUrl.split('/')[2].trim()}');
      });
    });
  }
}
