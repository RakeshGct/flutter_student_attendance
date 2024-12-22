import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../Models/student.dart';

class AttendanceProvider with ChangeNotifier {
  String _selectedClass = '';
  String _selectedSection = '';
  List<Student> _students = [];
  DateTime _selectedDate = DateTime.now();

  // Getters
  DateTime get selectedDate => _selectedDate;
  String get selectedClass => _selectedClass;
  String get selectedSection => _selectedSection;
  List<Student> get students => _students;

  // Update selected class and fetch students
  void updateClass(String newClass) {
    _selectedClass = newClass;
    _fetchStudents();
  }

  // Update selected section and fetch students
  void updateSection(String newSection) {
    _selectedSection = newSection;
    _fetchStudents();
  }

  // Update the selected date
  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners(); // Notify UI to rebuild when the date changes
  }

  // Fetch students from Firestore Database
  Future<void> _fetchStudents() async {
    if (_selectedClass.isEmpty || _selectedSection.isEmpty) return;

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('class', isEqualTo: _selectedClass)
          .where('section', isEqualTo: _selectedSection)
          .get();

      _students = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Student(
          id: doc.id,
          name: data['name'] ?? 'Unknown',
          className: data['class'] ?? '',
          section: data['section'] ?? '',
          attendance: data['attendance'] != null
              ? Map<String, Map<String, dynamic>>.from(data['attendance'])
              : {},
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  // Mark attendance for a specific student based on selected date
  Future<void> markAttendance(String studentId, DateTime date, bool isPresent) async {
    String dateKey = DateFormat('yyyy-MM-dd').format(date);
    String entryTime = DateFormat('h:mm a').format(DateTime.now());

    try {
      // Update Firestore document
      await FirebaseFirestore.instance.collection('students').doc(studentId).update({
        'attendance.$dateKey': {
          'isPresent': isPresent,
          'entryTime': entryTime,
        },
      });

      // Update local state
      final studentIndex = _students.indexWhere((student) => student.id == studentId);
      if (studentIndex != -1) {
        _students[studentIndex].attendance[dateKey] = {
          'isPresent': isPresent,
          'entryTime': entryTime,
        };
        notifyListeners(); // Notify UI to rebuild
      }
    } catch (e) {
      print('Error adding attendance: $e');
    }
  }

}
