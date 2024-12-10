import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnatchenko_sks_24_1/models/student.dart';
import 'package:gnatchenko_sks_24_1/providers/students_provider.dart';
import 'package:gnatchenko_sks_24_1/widgets/new_student.dart';
import 'package:gnatchenko_sks_24_1/widgets/student_item.dart';

class Students extends ConsumerWidget {
  const Students({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);

    void _openAddStudentOverlay() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewStudent(
          onAddStudent: (student) {
            ref.read(studentsProvider.notifier).addStudent(student);
          },
        ),
      );
    }

    void _removeStudent(Student student) {
      final studentIndex = students.indexWhere((s) => s.id == student.id);
      final state = ref.read(studentsProvider.notifier);
      state.removeStudent(student);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You’ve deleted a student!'),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              state.insertStudent(student, studentIndex);
            },
          ),
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
            final index = students.indexWhere((s) => s.id == student.id);
            ref
                .read(studentsProvider.notifier)
                .editStudent(updatedStudent, index);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
            onPressed: _openAddStudentOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StudentsList(
              students: students,
              onRemoveStudent: _removeStudent,
              onEditStudent: _editStudent,
            ),
          ),
        ],
      ),
    );
  }
}