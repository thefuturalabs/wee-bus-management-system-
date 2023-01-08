import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wee/screens/rto/rto_profile_page.dart';

import '../screens/login_page.dart';

class RtoDrawer extends StatelessWidget {
  const RtoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 60,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RtoProfilePage(),
                      ),
                    );
                  },
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            Divider(),
            CircleAvatar(
              radius: 80,
              child: IconButton(
                  onPressed: () {
                  SharedPreferences.getInstance().then(
                    (value) => value.clear(),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  );
                },
                  icon: Icon(
                    Icons.power_settings_new,
                    size: 70,
                    color: Colors.white,
                  )),
            ),
            Text('Logout',style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}
