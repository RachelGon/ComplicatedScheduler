import 'package:flutter/material.dart';
import 'package:complicated_scheduler/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 27, 41, 75),
        secondaryHeaderColor: const Color.fromARGB(255, 147,183, 190),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 147,183, 190),
        
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontFamily: 'montserrat',fontWeight: FontWeight.bold, color: Color.fromARGB(255, 27, 41, 75)),
          
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 27, 41, 75)),
          bodyMedium: TextStyle(fontSize: 18, fontFamily: 'montserrat', color: Color.fromARGB(255, 27, 41, 75)),
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: const MyHomePage(title: 'Alarms'),

    );
  }
}
