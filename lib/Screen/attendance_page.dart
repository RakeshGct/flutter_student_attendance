import 'package:attendance_management/Database/add_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/student.dart';
import '../Provider/attendance_provider.dart';

class AttendancePage extends StatelessWidget {
  final List<String> classes = ['Class 1', 'Class 2', 'Class 3'];
  final List<String> sections = ['A', 'B', 'C'];

  final List<Student> students;
  final DateTime selectedDate;

  AttendancePage({required this.students, required this.selectedDate});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);
    String dateKey = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";


    return Scaffold(
      appBar: AppBar(
          title: Text('Student Attendance'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddData()));
            },
                icon: Icon(Icons.add))
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: provider.selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      provider.updateSelectedDate(pickedDate);
                    }
                  },child: Text("Select Date"),
                ),
                Text(
                  'Date: ${provider.selectedDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: provider.selectedClass.isEmpty ? null : provider.selectedClass,
                  hint: Text('Select Class'),
                  onChanged: (value) => provider.updateClass(value!),
                  items: classes.map((classItem) {
                    return DropdownMenuItem(value: classItem, child: Text(classItem));
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: provider.selectedSection.isEmpty ? null : provider.selectedSection,
                  hint: Text('Select Section'),
                  onChanged: (value) => provider.updateSection(value!),
                  items: sections.map((sectionItem) {
                    return DropdownMenuItem(value: sectionItem, child: Text(sectionItem));
                  }).toList(),
                ),
              ],
            ),


            Expanded(
              child: provider.students.isEmpty
                  ? Center(child: Text('No students found.'))
                  : ListView.builder(
                itemCount: provider.students.length,
                itemBuilder: (context, index) {
                  final student = provider.students[index];
                  final attendanceData = student.attendance[dateKey] ?? {'entryTime': 'N/A', 'isPresent': false};
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text('Entry Time: ${attendanceData['entryTime']}'),
                    trailing: Text(
                      attendanceData['isPresent'] ? 'Present' : 'Absent',
                      style: TextStyle(
                        color: attendanceData['isPresent'] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _showAttendanceDialog(context, student, provider),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //it is the function when user will click on list the it will show the popup to mark the attendance(Present or Absent)
  void _showAttendanceDialog(BuildContext context, Student student, AttendanceProvider provider) {
    DateTime selectedDate = provider.selectedDate;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mark Attendance for ${student.name}'),
          content: Text('Select attendance status for ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
          actions: [
            TextButton(
              onPressed: () {
                provider.markAttendance(student.id, selectedDate, true);
                Navigator.of(context).pop();
              },
              child: Text('Present'),
            ),
            TextButton(
              onPressed: () {
                provider.markAttendance(student.id, selectedDate, false);
                Navigator.of(context).pop();
              },
              child: Text('Absent'),
            ),
          ],
        );
      },
    );
  }

}