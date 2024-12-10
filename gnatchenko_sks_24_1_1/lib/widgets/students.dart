import 'package:flutter/material.dart';
import 'package:gnatchenko_sks_24_1/models/student.dart';
import 'package:gnatchenko_sks_24_1/widgets/new_student.dart';
import 'package:gnatchenko_sks_24_1/widgets/student_item.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StudentsState();
  }
}

class _StudentsState extends State<Students> {
  // ignore: non_constant_identifier_names
  final List<Student> _students_list = [
    Student(
        firstName: 'Bill',
        lastName: 'Gates',
        department: Department.finance,
        grade: 12,
        gender: Gender.male),
    Student(
        firstName: 'Dr',
        lastName: 'House',
        department: Department.medical,
        grade: 10,
        gender: Gender.male),
    Student(
        firstName: 'Lena',
        lastName: 'Headey',
        department: Department.law,
        grade: 12,
        gender: Gender.female),
    Student(
        firstName: 'Mark',
        lastName: 'Zukor',
        department: Department.it,
        grade: 11,
        gender: Gender.male)
  ];

   void addStudent(Student student) {
    setState(() {
      _students_list.add(student);
    });
  }

  void _removeStudent(Student student) {
    final studentIndex = _students_list.indexOf(student);
    setState(() {
      _students_list.remove(student);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('You`ve deleted a student!'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _students_list.insert(studentIndex, student);
              });
            }),
      ),
    );
  }

  void _editStudent(Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewStudent(
        existingStudent: student,
        onAddStudent: (updatedStudent) {
          setState(() {
            final index = _students_list.indexOf(student);
            _students_list[index] = updatedStudent; // Update the student
          });
        },
      ),
    );
  }

  void _openAddStudentOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewStudent(onAddStudent: addStudent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
              onPressed: _openAddStudentOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        Expanded(
          child: StudentsList(
              students: _students_list, onRemoveStudent: _removeStudent, onEditStudent: _editStudent),
        ),
      ]),
    );
  }
}
