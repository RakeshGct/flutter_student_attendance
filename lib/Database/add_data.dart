import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  Future<void> addBulkStudents() async {

    final List<Map<String, dynamic>> students = [
      {
        "name": "John Doe",
        "class": "Class 1",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "9:00 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:05 AM"}
        }
      },
      {
        "name": "Jane Smith",
        "class": "Class 1",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:10 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:15 AM"}
        }
      },
      {
        "name": "Emily Davis",
        "class": "Class 2",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "8:55 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:00 AM"}
        }
      },
      {
        "name": "Michael Brown",
        "class": "Class 2",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "9:20 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:10 AM"}
        }
      },
      {
        "name": "Sarah Wilson",
        "class": "Class 3",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:05 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:00 AM"}
        }
      },
      {
        "name": "David Johnson",
        "class": "Class 3",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "8:50 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:15 AM"}
        }
      },
      {
        "name": "Sophia Martinez",
        "class": "Class 1",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "9:25 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:10 AM"}
        }
      },
      {
        "name": "William Anderson",
        "class": "Class 1",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:15 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:30 AM"}
        }
      },
      {
        "name": "Olivia Moore",
        "class": "Class 2",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "8:45 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "8:50 AM"}
        }
      },
      {
        "name": "James Taylor",
        "class": "Class 2",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "9:10 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:05 AM"}
        }
      },
      {
        "name": "Mia Thomas",
        "class": "Class 3",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:00 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:15 AM"}
        }
      },
      {
        "name": "Alexander Clark",
        "class": "Class 3",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:25 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:20 AM"}
        }
      },
      {
        "name": "Amelia Jackson",
        "class": "Class 1",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "9:30 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:15 AM"}
        }
      },
      {
        "name": "Ethan Lewis",
        "class": "Class 1",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "8:55 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "8:50 AM"}
        }
      },
      {
        "name": "Isabella Walker",
        "class": "Class 2",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:20 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:10 AM"}
        }
      },
      {
        "name": "Liam Hall",
        "class": "Class 2",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "9:05 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:00 AM"}
        }
      },
      {
        "name": "Charlotte Allen",
        "class": "Class 3",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:15 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:25 AM"}
        }
      },
      {
        "name": "Benjamin Young",
        "class": "Class 3",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": false, "entryTime": "8:50 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "9:15 AM"}
        }
      },
      {
        "name": "Emma King",
        "class": "Class 1",
        "section": "A",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "9:05 AM"},
          "2024-12-20": {"isPresent": false, "entryTime": "9:10 AM"}
        }
      },
      {
        "name": "Daniel Wright",
        "class": "Class 1",
        "section": "B",
        "attendance": {
          "2024-12-21": {"isPresent": true, "entryTime": "8:45 AM"},
          "2024-12-20": {"isPresent": true, "entryTime": "8:50 AM"}
        }
      }
    ];


    for (var student in students) {
      await FirebaseFirestore.instance.collection('students').add(student);
    }
    print('Bulk students added successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await addBulkStudents();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bulk student data added!')),
            );
          },
          child: Text('Add Bulk Students'),
        ),
      ),
    );
  }
}
