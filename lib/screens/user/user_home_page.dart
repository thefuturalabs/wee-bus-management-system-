import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:wee/Services/services.dart';
import 'package:wee/screens/bus_view.dart';
import 'package:wee/screens/user/nearby_facility_screen.dart';
import 'package:wee/widgets/user_drawer.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  var allBuses;
  bool fromLoading = false;
  bool toLoading = false;
  LocationData? loc;
  int accuracy = 1;
  bool pointsReversed = false;
  List filteredBuses = [];
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  double rotateAngle = 0.0;
  bool fetchingBuses = false;

  bool searchInstead = false;

  List<Map<String, dynamic>> toFromFields = [];
  final fkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeFieldList();
    getAllBusList();
    fromController.text = 'Your location';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(title: Text('Wee')),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NearbyFaciliyScreen()));
            },
            child: Icon(Icons.wc),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) =>
                          StatefulBuilder(builder: (context, state) {
                        return AlertDialog(
                          title: Text('location accuracy'),
                          content: SizedBox(
                            height: 30,
                            child: Slider(
                                divisions: 4,
                                label: '$accuracy',
                                min: 1,
                                max: 5,
                                value: accuracy.ceilToDouble(),
                                onChanged: (v) {
                                  state(() {
                                    accuracy = v.toInt();
                                  });
                                }),
                          ),
                        );
                      }),
                    );
                  },
                  child: Icon(Icons.more_vert)),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                  onPressed: () {
                    if (fkey.currentState!.validate()) {
                      if (searchInstead) {
                        searchBus();
                      } else {
                        filterBuses();
                      }
                    }
                  },
                  child: Icon(Icons.search)),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            searchInstead
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: searchBus, icon: Icon(Icons.search)),
                        label: Text('enter bus name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: fkey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, top: 20, left: 20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...toFromFields
                                      .map((e) => TextFormField(
                                            textInputAction:
                                                TextInputAction.search,
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return e['label'] ==
                                                        'destination'
                                                    ? 'enter destination place'
                                                    : 'enter starting point';
                                              }
                                            },
                                            onFieldSubmitted: (value) {
                                              // if (e['label'] == 'destination') {
                                              if (fkey.currentState!
                                                  .validate()) {
                                                filterBuses();
                                              }
                                              // }
                                            },
                                            controller: e['controller'],
                                            decoration: InputDecoration(
                                              // hintText: 'asd',
                                              label: Text(e['label']),
                                              border: OutlineInputBorder(),
                                            ),
                                          ))
                                      .toList(),
                                ]),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: AnimatedRotation(
                            turns: rotateAngle,
                            duration: Duration(milliseconds: 300),
                            child: Icon(Icons.keyboard_double_arrow_down)),
                        onPressed: () {
                          setState(() {
                            String temp = fromController.text;
                            fromController.text = toController.text;
                            toController.text = temp;
                            rotateAngle = rotateAngle + .5;
                            toFromFields = toFromFields.reversed.toList();
                          });
                        },
                      )
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        searchInstead = !searchInstead;
                      });
                    },
                    child: Text(searchInstead
                        ? 'search by departure and arrival'
                        : 'search by bus name instead')),
                IconButton(
                    onPressed: () {
                      setState(() {
                        filteredBuses = allBuses;
                      });
                    },
                    icon: Icon(Icons.restart_alt))
              ],
            ),
            Divider(),
            fetchingBuses
                ? Center(
                    child: Text('fetching...'),
                  )
                : Expanded(
                    child: filteredBuses.length < 1
                        ? Center(
                            child: Text('No buses'),
                          )
                        : ListView.builder(
                            itemCount: filteredBuses.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () async {
                                    final data = await Services.postData({
                                      'bus_id': filteredBuses[index]['bus_id']
                                    }, 'view_location.php');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BusView(
                                            busId: filteredBuses[index]
                                                ['bus_id'],
                                            issue: data.last['issue'] ?? '',
                                          ),
                                        ));
                                  },
                                  title: Text(filteredBuses[index]['name']),
                                  subtitle: FutureBuilder(
                                      future: viewIssue(
                                          filteredBuses[index]['bus_id']),
                                      builder: (context, snap) {
                                        if (!snap.hasData) {
                                          return Text('...');
                                        } else {
                                          return Text(
                                            snap.data,
                                            style: TextStyle(color: Colors.red),
                                          );
                                        }
                                      }),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      FutureBuilder(
                                          future: Services.getPlaceName(
                                              filteredBuses[index]['from']
                                                  .split(',')
                                                  .first,
                                              filteredBuses[index]['from']
                                                  .split(',')[1]),
                                          builder: (context, snap) {
                                            if (!snap.hasData) {
                                              return Text('loading...');
                                            } else {
                                              return Text('from: ${snap.data}');
                                            }
                                          }),
                                      FutureBuilder(
                                          future: Services.getPlaceName(
                                              filteredBuses[index]['to']
                                                  .split(',')
                                                  .first,
                                              filteredBuses[index]['to']
                                                  .split(',')[1]),
                                          builder: (context, snap) {
                                            if (!snap.hasData) {
                                              return Text('loading...');
                                            } else {
                                              return Text('from: ${snap.data}');
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  )
          ],
        ),
      ),
    );
  }

  Future<dynamic> getAllBusList() async {
    await Future.delayed(Duration(seconds: 2));
    // allBuses = Constants.dummyBuses;
    allBuses = (await Services.getData('all_bus_list.php') as List)
        .where((element) => element['status'] == '1')
        .toList();

    filteredBuses =
        allBuses.first['message'] == 'Failed to View' ? [] : allBuses;
    setState(() {});
    return filteredBuses;
  }

  searchBus() {
    filteredBuses = (allBuses as List)
        .where((bus) => (bus['name'] as String).contains(searchController.text))
        .toList();
    setState(() {});
  }

  filterBuses() async {
    setState(() {
      fetchingBuses = true;
    });
    String fromCoordinates;
    if (fromController.text == 'Your location') {
      LocationData loc = await Location.instance.getLocation();
      fromCoordinates = '${loc.latitude},${loc.longitude}';
    } else {
      fromCoordinates = await Services.getCoordinates(fromController.text);
    }
    String toCoordinates = await Services.getCoordinates(toController.text);

    print('from $fromCoordinates, to $toCoordinates');

    filteredBuses = allBuses
        .where(
          (bus) =>
              ((double.parse(bus['from'].split(',').first)
                          .round()
                          .toStringAsFixed(accuracy) ==
                      double.parse(fromCoordinates.split(',').first)
                          .round()
                          .toStringAsFixed(accuracy)) &&
                  (double.parse(bus['from'].split(',')[1])
                          .round()
                          .toStringAsFixed(accuracy) ==
                      double.parse(fromCoordinates.split(',')[1])
                          .round()
                          .toStringAsFixed(accuracy))) &&
              ((double.parse(bus['to'].split(',').first)
                          .round()
                          .toStringAsFixed(accuracy) ==
                      double.parse(toCoordinates.split(',').first)
                          .round()
                          .toStringAsFixed(accuracy)) &&
                  (double.parse(bus['to'].split(',')[1])
                          .round()
                          .toStringAsFixed(accuracy) ==
                      double.parse(toCoordinates.split(',')[1])
                          .round()
                          .toStringAsFixed(accuracy))),
        )
        .toList();
    if (filteredBuses.length < 1) {
      Fluttertoast.showToast(msg: 'try adjusting location accuracy');
    }
    setState(() {
      fetchingBuses = false;
    });
  }

  initializeFieldList() {
    toFromFields = [
      {
        'controller': fromController,
        'label': 'starting point',
      },
      {
        'controller': toController,
        'label': 'destination',
      }
    ];
  }

  Future<dynamic> viewIssue(String busId) async {
    final data = await Services.postData({'bus_id': busId}, 'view_issue.php');
    if (data.first['message'] != 'Failed to View') {
      return data.last['issue'];
    } else {
      return '';
    }
  }

  fetchLocation(String fromOrTo) async {
    setState(() {
      fromOrTo == 'from' ? fromLoading = true : toLoading = true;
    });
    loc = await Location().getLocation();
    String locName = await Services.getPlaceName(
      '${loc!.latitude!}',
      '${loc!.longitude!}',
    );
    if (fromOrTo == 'from') {
      fromController.text = locName;
    } else {
      toController.text = locName;
    }
    setState(() {
      fromOrTo == 'from' ? fromLoading = false : toLoading = false;
    });
  }
}
