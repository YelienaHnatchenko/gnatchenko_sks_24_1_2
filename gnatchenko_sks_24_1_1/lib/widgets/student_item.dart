import 'package:flutter/material.dart';
import 'package:gnatchenko_sks_24_1/models/student.dart';

class StudentsItem extends StatelessWidget {
  const StudentsItem({
    super.key,
    required this.student,
    required this.onEditStudent,
  });

  final Student student;
  final void Function(Student student) onEditStudent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onEditStudent(student),
      child: Card(
        color: genderColors[student.gender],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Text(
                "${student.firstName} ${student.lastName}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(departmentIcons[student.department]),
              const SizedBox(width: 10),
              Text("${student.grade}"),
            ],
          ),
        ),
      ),
    );
  }
}


class StudentsList extends StatelessWidget {
 const StudentsList(
      {super.key, required this.students, required this.onRemoveStudent, required this.onEditStudent});

  final List<Student> students;
  final void Function(Student student) onRemoveStudent;
    final void Function(Student student) onEditStudent;

  @override
 Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (contest, index) => Dismissible(
              key: ValueKey(students[index]),
              child: StudentsItem(student: students[index], onEditStudent: onEditStudent),
              onDismissed: (direction) {
                onRemoveStudent(students[index]);
              },
            ));
  }
}