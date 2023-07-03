import 'package:flutter/material.dart';

class Event {
  final String name;
  final DateTime date;
  final String notes;
  final Color color;
  final IconData icon;

  Event({
    required this.name,
    required this.date,
    this.notes = '',
    required this.color,
    required this.icon,
  });

  int get daysUntil {
    final now = DateTime.now();
    final difference = date.difference(now);
    return difference.inDays;
  }
}
