import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Gender { male, female }


const Map<Gender, Color> genderColors = {
  Gender.female: Colors.pink,
  Gender.male: Colors.blue
};

class Student {
  Student({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.grade,
    required this.gender
    }) : id = id ?? const Uuid().v4();
  
  final String id;
  final String firstName;
  final String lastName;
  final String departmentId;
  final int grade;
  final Gender gender;

  Student copyWith({
    String? firstName,
    String? lastName,
    String? departmentId,
    Gender? gender,
    int? grade,
  }) {
    return Student(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      departmentId: departmentId ?? this.departmentId,
      gender: gender ?? this.gender,
      grade: grade ?? this.grade,
    );
  }
}
