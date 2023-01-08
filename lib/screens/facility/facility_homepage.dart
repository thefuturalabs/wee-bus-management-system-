import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wee/Services/services.dart';
import 'package:wee/screens/login_page.dart';

class FacilityHomepage extends StatefulWidget {
  FacilityHomepage({super.key});

  @override
  State<FacilityHomepage> createState() => _FacilityHomepageState();
}

class _FacilityHomepageState extends State<FacilityHomepage> {
  getStatus() async {
    String uid = await Services.getUserId() ?? '2';
    final status = await Services.postData(
        {'fecility_id': uid}, 'fecility_profile_view.php');
    if (status['status'] == '1') {
      setState(() {
        currentStatus = false;
      });
    } else {
      setState(() {
        currentStatus = true;
      });
    }
  }

  closeStatus() async {
    String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'fecility_id': uid}, 'fecility_status.php');
  }

  openStatus() async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'fecility_id': uid}, 'fecility_status_open.php');
  }

  bool currentStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your status'),
        actions: [
          Text(
            currentStatus ? 'open' : 'closed',
            style: TextStyle(
              fontSize: 30,
              color: currentStatus ? Colors.green : Colors.red,
            ),
          ),
          IconButton(
            onPressed: () async {
              SharedPreferences spref = await SharedPreferences.getInstance();
              spref.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Transform.scale(
          scale: 20,
          child: Switch(
            value: currentStatus,
            onChanged: (v) {
              setState(() {
                currentStatus = v;
              });
              if (v) openStatus();
              if (!v) closeStatus();
            },
            inactiveThumbColor: currentStatus ? Colors.green : Colors.red,
            activeColor: currentStatus ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
