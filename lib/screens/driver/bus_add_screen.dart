import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wee/Services/services.dart';

class BusAddScreen extends StatelessWidget {
  BusAddScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  add(BuildContext context) async {
    String from = await Services.getCoordinates(fromController.text);
    String to = await Services.getCoordinates(toController.text);
  String uid=await Services.getUserId()??'2';
    print('from $from and to $to');
    final data=await Services.postData({
      'driver_id':uid,
      'name': nameController.text,
      'number': phoneController.text,
      'district': placeController.text,
      'from': from,
      'to': to,
    }, 'add_bus.php');
    if(data['result']=='done'){
      Fluttertoast.showToast(msg: 'Bus added');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
      
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding:  EdgeInsets.only(top: 100),
                    child:  Text(
                      'Add bus',
                      style: TextStyle(
                          color: Color.fromARGB(255, 67, 67, 67),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
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
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone';
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: Text('phone'),
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
                        label: Text('place'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: fromController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter from';
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('from'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: toController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter to';
                        }
                      },
                      decoration: InputDecoration(
                        label: Text('to'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        add(context);
                      },
                      child: Text('Add Bus')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
