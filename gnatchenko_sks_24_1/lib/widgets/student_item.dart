import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnatchenko_sks_24_1/models/department.dart';
import 'package:gnatchenko_sks_24_1/models/student.dart';
import 'package:gnatchenko_sks_24_1/providers/departments_provider.dart';

class StudentsItem extends ConsumerWidget {
  const StudentsItem({
    super.key,
    required this.student,
    required this.onEditStudent,
  });

  final Student student;
  final void Function(Student student) onEditStudent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableDepartments = ref.watch(departmentsProvider);
    // Find the department for this student
    final department = availableDepartments.firstWhere(
      (department) => department.id == student.departmentId,
      orElse: () => const Department(
          id: '',
          name: 'Unknown',
          color: Colors.grey,
          icon: Icons.error), // Fallback if department is not found
    );
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              const Spacer(),
              Icon(department.icon),
              const SizedBox(width: 10),
              Text(
                "${student.grade}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentsList extends StatelessWidget {
  const StudentsList({
    super.key,
    required this.students,
    required this.onRemoveStudent,
    required this.onEditStudent,
  });

  final List<Student> students;
  final void Function(Student student) onRemoveStudent;
  final void Function(Student student) onEditStudent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(students[index].id),
        background: Container(
          color: Colors.red.withOpacity(0.75),
          margin: const EdgeInsets.symmetric(vertical: 5),
        ),
        child: StudentsItem(
          student: students[index],
          onEditStudent: onEditStudent,
        ),
        onDismissed: (direction) {
          onRemoveStudent(students[index]);
        },
      ),
    );
  }
}


