import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String name;
  final DateTime date;
  final DateTime birthDate;

  const SidebarItem({
    super.key,
    required this.isSelected,
    required this.name,
    required this.date,
    required this.onTap,
    required this.birthDate,
  });

  @override
  Widget build(BuildContext context) {
    final age = (DateTime.now().difference(birthDate).inDays / 365.3).floor();

    return Container(
      color: isSelected ? Colors.black : Colors.grey.shade200,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          Icons.person_outline,
          color: isSelected ? Colors.white : Colors.black,
        ),
        title: Text(
          'Name: $name, $age',
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          'Date: ${date.day}/${date.month}/${date.year}',
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
