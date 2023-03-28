import 'package:flutter/material.dart';
import 'package:wee/Services/services.dart';

class ViewNotificationScreen extends StatelessWidget {
  const ViewNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder<dynamic>(
          future: Services.getData('view_notification.php'),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snap.data.first['message'] == 'Failed') {
              return const Center(
                child: Text('No notifications for now'),
              );
            } else {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snap.data[index]['title'],
                              style: TextStyle(fontSize: 30)),
                          Text(snap.data[index]['content']),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
