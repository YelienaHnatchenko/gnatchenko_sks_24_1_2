import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnatchenko_sks_24_1/models/department.dart';

final departmentsProvider = Provider((ref) {
  return const [
    Department(
      id: 'd1',
      name: 'Finance',
      color: Colors.purple,
      icon: Icons.money,
    ),
    Department(
      id: 'd2',
      name: 'Law',
      color: Colors.red,
      icon: Icons.account_balance,
    ),
    Department(
      id: 'd3',
      name: 'IT',
      color: Colors.blue,
      icon: Icons.computer,
    ),
    Department(
      id: 'd4',
      name: 'Medical',
      color: Colors.green,
      icon: Icons.medication,
    )
  ];
});
