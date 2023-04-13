import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_tutorial_application/screens/start/ingredients/multiselection.dart';
import 'package:flutter/material.dart';

class InputIngredientsPage extends StatefulWidget {
  static const nameRoute = 'inputingredientsPage';
  const InputIngredientsPage({super.key});

  @override
  State<InputIngredientsPage> createState() => _InputIngredientsPageState();
}

class _InputIngredientsPageState extends State<InputIngredientsPage> {
  final _formKey = GlobalKey<FormState>();
  final DocumentReference myDocument = FirebaseFirestore.instance
      .collection('recommendations')
      .doc('first_recommendation');
  final docSnapshot = FirebaseFirestore.instance
      .collection('recommendations')
      .doc('first_recommendation')
      .get();
  List _ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "What's on your fridge?",
                      style: TextStyle(fontSize: 30),
                    ),
                    MyMultiSelectionFormField(
                      validator: (ingredients) => (ingredients?.length ?? 0) < 3
                          ? 'Please add at least 3 ingredients'
                          : null,
                      onSaved: (ingredients) {
                        _ingredients = ingredients!;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _formKey.currentState!.save();
                          });

                          myDocument.set({'ingredients': _ingredients});

                          // ignore: use_build_context_synchronously
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/listRec");
                        }
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
