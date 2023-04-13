import 'package:flutter/material.dart';

class MyChipList<T> extends StatelessWidget {
  const MyChipList({
    required this.values,
    required this.chipBuilder,
  });

  final List<T> values;
  final Chip Function(T) chipBuilder;

  List<Widget> _buildChipList() {
    final List<Widget> items = [];
    for (T value in values) {
      items.add(chipBuilder(value));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChipList(),
    );
  }
}
