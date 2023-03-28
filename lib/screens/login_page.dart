import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wee/Services/services.dart';
import 'package:wee/screens/driver/driver_homepage.dart';
import 'package:wee/screens/driver/driver_registration.dart';
import 'package:wee/screens/facility/facility_registration.dart';
import 'package:wee/screens/facility/facility_homepage.dart';
import 'package:wee/screens/rto/rto_homepage.dart';
import 'package:wee/screens/rto/rto_registration_page.dart';
import 'package:wee/screens/user/user_home_page.dart';
import 'package:wee/screens/user/user_registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scController = ScrollController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 1)).then((value) {
      scController.animateTo(
        scController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  signUpDialog() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Choose user type'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('User'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserRegistraionPage(),
                        ),
                      );
                    },
                    leading: Icon(Icons.person),
                  ),
                  ListTile(
                    title: Text('Bus Owner'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DriverRegistration(),
                        ),
                      );
                    },
                    leading: Icon(Icons.directions_bus),
                  ),
                  ListTile(
                    title: Text('RTO'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RtoRegistraionPage(),
                        ),
                      );
                    },
                    leading: Icon(Icons.directions_bus),
                  ),
                  ListTile(
                    title: Text('Facility'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FacilityRegistration(),
                        ),
                      );
                    },
                    leading: Icon(Icons.groups),
                  ),
                ],
              ),
            ));
  }

  login() async {
    final data = await Services.postData({
      'username': usernameController.text,
      'password': passwordController.text,
    }, 'rto_login.php');
    if (data['message'] == "User Successfully LoggedIn") {
      final spref = await SharedPreferences.getInstance();
      spref.setString('userId', data['rto_id']);
      spref.setString('type', data['type']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RtoHomepage(),
        ),
      );
    } else {
      final data = await Services.postData({
        'username': usernameController.text,
        'password': passwordController.text,
      }, 'fecility_login.php');
      if (data['message'] == "User Successfully LoggedIn") {
        final spref = await SharedPreferences.getInstance();
        spref.setString('userId', data['fecility_id']);
        spref.setString('type', 'facility');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FacilityHomepage(),
          ),
        );
      } else {
        final data = await Services.postData({
          'username': usernameController.text,
          'password': passwordController.text,
        }, 'driver_login.php');
        if (data['message'] == "User Successfully LoggedIn") {
          final spref = await SharedPreferences.getInstance();
          spref.setString('userId', data['driver_id']);
          spref.setString('type', 'driver');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DriverHomepage(),
            ),
          );
        } else {
          final data = await Services.postData({
            'username': usernameController.text,
            'password': passwordController.text,
          }, 'user_login.php');
          if (data['message'] == "User Successfully LoggedIn") {
            final spref = await SharedPreferences.getInstance();
            spref.setString('userId', data['user_id']);
            spref.setString('type', 'user');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => UserHomePage(),
              ),
            );
          }else{
            Fluttertoast.showToast(msg: 'something went wrong, ${data['message']}');
          }
        }
      }
    }
  }

  final fkey = GlobalKey<FormState>();

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
              padding: EdgeInsets.only(top: height / 3, left: 20),
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
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: fkey,
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
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter username';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('username'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
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
                      ElevatedButton(
                          onPressed: () {
                            if (fkey.currentState!.validate()) {
                              login();
                            }
                          },
                          child: Text('Login')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Do not have an account?'),
                          TextButton(
                              onPressed: signUpDialog, child: Text('Sign up'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
