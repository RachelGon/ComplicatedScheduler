import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  // @override
  // void initState() {
  //   alarmTime = '${DateFormat('hh:mm a').format(DateTime.now())}';
  //   super.initState();
  // }

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
                      showModalBottomSheet<dynamic>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter
                                  modalSetState /*You can rename this!*/) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 2,
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
                                                  // focusColor: Color.fromARGB(255, 147,183, 190),
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
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
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
}
