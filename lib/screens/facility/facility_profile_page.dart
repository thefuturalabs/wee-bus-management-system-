import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Services/services.dart';

class FacilityProfilePage extends StatefulWidget {
  FacilityProfilePage({super.key});

  @override
  State<FacilityProfilePage> createState() => _RtoProfilePageState();
}

class _RtoProfilePageState extends State<FacilityProfilePage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  File? pickedImage;

  getImage() async {
    pickedImage = await Services.pickImage(context);
    setState(() {});
  }

  update() async {
    String uid = await Services.getUserId() ?? '2';
    // if(pickedImage!=null){
    final data = await Services.postData({
      'fecility_id': uid,
      'name': nameController.text,
      'email': emailController.text,
      'phn_no': phoneController.text,
      'location':await Services.getCoordinates(locationController.text) ,
    }, 'fecility_profile_update.php');

    if (data['message'] == 'updated') {
      Fluttertoast.showToast(msg: 'Profile updated');
      Navigator.pop(context);
    }
  }

  getProfileDetails() async {
    final uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'fecility_id': uid}, 'fecility_profile_view.php');
    nameController.text = data['name'];
    emailController.text = data['email'];
    phoneController.text = data['mobile'];
    print('${data['location'].split(',').first},${data['location'].split(',')[1]}');
    locationController.text =await Services.getPlaceName(data['location'].split(',').first,data['location'].split(',')[1]);
// phoneController.text=data['mobile'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 200,
                ),
                const Text(
                  'Edit profile',
                  style: TextStyle(
                      color: Color.fromARGB(255, 67, 67, 67),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('email'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     if (pickedImage != null)
                //       SizedBox(
                //         height: 50,
                //         width: 50,
                //         child: Image.file(pickedImage!),
                //       ),
                //     if (pickedImage != null)
                //       Expanded(
                //           child:
                //               Text(pickedImage!.path, overflow: TextOverflow.fade)),
                //     IconButton(
                //       icon: Icon(Icons.image),
                //       onPressed: getImage,
                //     )
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter phone';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('Phone'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: locationController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter location';
                      }
                    },
                    decoration: InputDecoration(
                      label: Text('Location'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      update();
                    },
                    child: Text('update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
