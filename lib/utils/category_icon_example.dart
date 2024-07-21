import 'package:flutter/material.dart';

class CategoryIconExample extends StatelessWidget {
  final String category;

  CategoryIconExample({required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // _getIconForCategory(category),
        SizedBox(width: 8),
        Text(category),
      ],
    );
  }
}