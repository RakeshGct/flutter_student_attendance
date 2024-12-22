class Student {
  final String id;
  final String name;
  final String  className;
  final String section;
  final Map<String, Map<String, dynamic>> attendance; //object within the object

  Student({
    required this.id,
    required this.name,
    required this. className,
    required this.section,
    required this.attendance,
  });

  // Factory constructor to create a Student object from a Firestore document
  factory Student.fromFirestore(String id, Map<String, dynamic> data) {
    return Student(
      id: id,
      name: data['name'] ?? '',
      className: data['class'] ?? '',
      section: data['section'] ?? '',
      attendance: (data['attendance'] as Map<String, dynamic>?)
          ?.map((date, attendanceData) => MapEntry(
        date,
        attendanceData as Map<String, dynamic>,
      )) ??
          {},
    );
  }

  // Method to convert a Student object to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'class': className,
      'section': section,
      'attendance': attendance,
    };
  }
}
