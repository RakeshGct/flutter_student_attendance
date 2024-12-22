import 'package:attendance_management/Database/add_data.dart';
import 'package:attendance_management/Screen/attendance_page.dart';
import 'package:attendance_management/Screen/home_page.dart';
import 'package:attendance_management/Screen/identity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/student.dart';
import 'Provider/attendance_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider(
          create: (_) => AttendanceProvider(),
          child: const MyApp()),
      );
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: Identity(),
    );
  }
}


