import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.separated(
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
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ],
        ),
      ),
    );
  }
}
