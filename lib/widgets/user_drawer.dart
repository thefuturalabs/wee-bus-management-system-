import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wee/screens/user/view_notification.dart';

import '../screens/login_page.dart';
import '../screens/user/user_profile_page.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

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
                        builder: (_) => UserProfilePage(),
                      ),
                    );
                  },
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            Divider(),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewNotificationScreen(),
                    ),
                  );
                },
                title: Text('Notifications'),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewNotificationScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.notifications)),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
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
                title: Text('Logout'),
                trailing:  Icon(Icons.logout)),
              
            ),
           
          ],
        ),
      ),
    );
  }
}
