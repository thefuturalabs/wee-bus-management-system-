import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wee/Services/services.dart';
import 'package:wee/screens/login_page.dart';
import 'package:wee/screens/rto/rto_homepage.dart';

class FacilityRegistration extends StatefulWidget {
  FacilityRegistration({super.key});
  // UserType user;
  @override
  State<FacilityRegistration> createState() => _CommonRegistrationPageState();
}

class _CommonRegistrationPageState extends State<FacilityRegistration> {
  final scController = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  File? pickedImage;
  String? type;
  bool isLoading = false;
  LocationData? loc;
  String? place;

  List<String> categories = [
    'cab',
    'restaurent',
    'hospital',
    'police',
  ];

  signUp() async {
    if (loc == null) {
      place = await Services.getCoordinates(placeController.text);
    } else {
      place = '${loc!.latitude},${loc!.longitude}';
    }
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'fecility_register.php',
          params: {
            'name': nameController.text,
            'email': emailController.text,
            'mobile': phoneController.text,
            'username': usernameController.text,
            'password': passwordController.text,
            'location': place,
            'type': type,
          },
          image: pickedImage!,
          imageParameter: 'f1');
      if (data['result'] == 'done') {
        // final spref = await SharedPreferences.getInstance();
        // spref.setString('userId', data['rto_id']);
        // spref.setString('type', 'rto');
        Fluttertoast.showToast(msg: 'Ask admin for user approval');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoginPage(),
          ),
        );
      }
    } else {
      Fluttertoast.showToast(msg: 'pick image');
    }
  }

  getImage() async {
    pickedImage = await Services.pickImage(context);
    setState(() {});
  }

  fetchLocation() async {
    setState(() {
      isLoading = true;
    });
    loc = await Location().getLocation();
    placeController.text = await Services.getPlaceName(
      '${loc!.latitude!}',
      '${loc!.longitude!}',
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        controller: scController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height / 6, left: 20),
              child: Text(
                'Welcome',
                style: TextStyle(
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 20),
              child: Text(
                'Wee with you',
                style: TextStyle(
                    color: Color.fromARGB(255, 67, 67, 67),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              // height: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'login',
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
                      child: DropdownButtonFormField(
                        items: categories
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (v) {
                          type = v;
                        },
                        decoration: InputDecoration(
                          label: Text('category'),
                          border: OutlineInputBorder(),
                        ),
                      ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter username';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('Username'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: placeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter place';
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: fetchLocation,
                              icon: const Icon(Icons.my_location)),
                          label: isLoading
                              ? CircularProgressIndicator()
                              : Text('place'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter password';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('password'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (pickedImage != null)
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.file(pickedImage!),
                          ),
                        if (pickedImage != null)
                          Expanded(
                              child: Text(pickedImage!.path,
                                  overflow: TextOverflow.fade)),
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed: getImage,
                        )
                      ],
                    ),
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
                    ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        child: Text('SignUp')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginPage(),
                                ),
                              );
                            },
                            child: Text('Sign in'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
