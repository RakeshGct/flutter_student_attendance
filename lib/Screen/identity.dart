import 'package:attendance_management/Screen/attendance_page.dart';
import 'package:flutter/material.dart';

import '../Models/student.dart';

class Identity extends StatelessWidget {
   Identity({super.key});

  final List<Student> students = [
    Student(
      id: '1',
      name: 'Emily Davis',
      className: 'Class 1',
      section: 'B',
      attendance: {
        "2024-12-20": {"entryTime": "9:05 AM", "isPresent": false},
        "2024-12-21": {"entryTime": "9:00 AM", "isPresent": true},
      },
    ),
    Student(
      id: '2',
      name: 'John Doe',
      className: 'Class 1',
      section: 'A',
      attendance: {
        "2024-12-20": {"entryTime": "8:55 AM", "isPresent": true},
        "2024-12-21": {"entryTime": "9:10 AM", "isPresent": false},
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please Select your Identity", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage(students: students, selectedDate: DateTime(2024, 12, 20))));
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,

                  ),
                  child: Center(child: Text("Teacher", style: TextStyle(fontSize: 20, color: Colors.white),)),
                ),
              ),
              //this part will be implemented later, it is for the student where student can check the attendance status
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent
                  ),
                  child: Center(child: Text("Student", style: TextStyle(fontSize: 20, color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
