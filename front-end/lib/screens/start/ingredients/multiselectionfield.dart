import 'package:cooking_tutorial_application/screens/start/ingredients/chiplist.dart';
import 'package:flutter/material.dart';

class MyMultiSelectionField<T> extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  MyMultiSelectionField({
    Key? key,
    required this.onChanged,
    required this.values,
  }) : super(key: key);

  ValueChanged<List> onChanged;
  List<String> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          autofocus: true,
          onEditingComplete: (() => FocusNode()),
          controller: _controller,
          decoration: const InputDecoration(
              hintText: "Input the Ingredients one by one",
              border: OutlineInputBorder()),
          onSubmitted: (String value) {
            if (value != "") {
              values.add(value);
              onChanged(values);
              _controller.clear();
            }
          },
        ),
        MyChipList(
            values: values,
            chipBuilder: (String value) {
              return Chip(
                label: Text(value),
                onDeleted: () {
                  values.remove(value);
                  onChanged(values);
                },
              );
            })
      ],
    );
  }
}
