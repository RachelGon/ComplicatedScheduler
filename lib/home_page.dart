import 'dart:typed_data';

import 'package:complicated_scheduler/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

int id = 0;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyHomePage extends StatefulWidget {

  const MyHomePage({
    super.key, 
    required this.title
  });
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize();
  }

  String alarmTime = '${DateFormat('hh:mm a').format(DateTime.now())}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      //*********************************** BOTTOM SHEET START *******************************************************
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter
                                  modalSetState /*You can rename this!*/) {
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      
                                      // ************************************* TIME PICKER START *****************************************************
                                      Builder(
                                        builder: (context) => Expanded(
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Time: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Theme.of(
                                                            context)
                                                        .secondaryHeaderColor,
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12), // <-- Radius
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    TimeOfDay? pickedTime =
                                                        await showTimePicker(
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      context: context,
                                                    );
                                                    if (pickedTime != null) {
                                                      modalSetState(() {
                                                        alarmTime =
                                                            '${pickedTime.format(context).toString()}'; //set the value of text field.
                                                      });
                                                    } else {
                                                      print(
                                                          "Time is not selected");
                                                    }
                                                  },
                                                  child: Text(
                                                    "$alarmTime",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Repeat Every ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              TextField(
                                                autofocus: false,
                                                style: TextStyle(color: Theme.of(context)
                                                            .primaryColor), 
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Theme.of(context)
                                                            .primaryColor), //<-- SEE HERE
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor), //<-- SEE HERE
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  hintText: 'Number',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ], // Only numbers can be entered
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Days ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // ************************************* BUTTON FOR TIME PICKER END *****************************************************
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .secondaryHeaderColor,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12), // <-- Radius
                                                ),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12), // <-- Radius
                                                  ),
                                                ),
                                                child: Text(
                                                  'Create',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                                onPressed: () async {
                                                  // Navigator.pop(context);
                                                  await _showInsistentNotification();


                                                }),
                                          ),
                                        ],
                                      )

                                      // const Text('Modal BottomSheet'),
                                      // ElevatedButton(
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor: Theme.of(context)
                                      //         .secondaryHeaderColor,
                                      //     padding: const EdgeInsets.fromLTRB(
                                      //         10, 10, 10, 10),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(
                                      //           12), // <-- Radius
                                      //     ),
                                      //   ),
                                      //   child: Text(
                                      //     'Cancel',
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .bodyMedium,
                                      //   ),
                                      //   onPressed: () => Navigator.pop(context),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      );
                      //*********************************** BOTTOM SHEET END *******************************************************
                    }),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
                    child: Column(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ALARM NAME',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '00:00',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Next Ring:',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Monday January 1st',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      // TODO:// USE FOR SMALL CALENDAR VIEW
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                      //   child: ExpansionTile(
                      //     title: Text('Details ${entries[index]}'),
                      //     children: const <Widget>[
                      //       Text('Big Bang'),
                      //       Text('Birth of the Sun'),
                      //       Text('Earth is Born'),
                      //     ],
                      //   ),
                      // ),
                    ]),
                  ),
                ));
              },
              // separatorBuilder: (BuildContext context, int index) =>
              //     const Divider(),
            )),
          ],
        ),
      ),
    );
  }
  Future<void> _showInsistentNotification() async {
    // // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
    // const int insistentFlag = 4;

    // final AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails('your channel id', 'your channel name',
    //         channelDescription: 'your channel description',
    //         importance: Importance.max,
    //         priority: Priority.high,
    //         ticker: 'ticker',
    //         additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    
    // final NotificationDetails notificationDetails =
    //     NotificationDetails(android: androidNotificationDetails);
    //     print(id);
    //     print("HERE");

    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   id++,
    //   'insistent title',
    //   'insistent body',
    //   tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      
    //   notificationDetails,
    //   androidScheduleMode: AndroidScheduleMode.alarmClock,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
        iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++,
        'title of time sensitive notification',
        'body of time sensitive notification',
        notificationDetails,
        payload: 'item x');
  }



  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

}
