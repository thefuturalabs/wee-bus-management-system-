import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wee/screens/driver/driver_homepage.dart';
import 'package:wee/screens/facility/facility_homepage.dart';
import 'package:wee/screens/login_page.dart';
import 'package:wee/screens/rto/rto_homepage.dart';
import 'package:wee/screens/user/user_home_page.dart';
// import 'package:wee/screens/user/user_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getUserType() async {
    final spref = await SharedPreferences.getInstance();
      // spref.setString('userId', '10');
      // await spref.setString('type', 'facility');
    print(spref.getString('type'));
    return spref.getString('type');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.amber,
        primarySwatch: Colors.blue,
      ),
      home:
      // UserHomePage()
       FutureBuilder(
          future: getUserType(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return LoginPage();
            } else if (snap.data == 'rto') {
              return RtoHomepage();
            } else if(snap.data=='facility'){
              return FacilityHomepage();
            }else if(snap.data=='driver'){
              return DriverHomepage();
            }else if(snap.data=='user'){
              return UserHomePage();
            }else{
              return LoginPage();
            }
          }),
    );
  }
}
