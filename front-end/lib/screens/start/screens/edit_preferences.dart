import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
import 'dart:convert';

class AddPreferences extends StatefulWidget {
  const AddPreferences({super.key});

  @override
  State<AddPreferences> createState() => _AddPreferencesState();
}

class _AddPreferencesState extends State<AddPreferences> {
  final _formkey = GlobalKey<FormState>();
  String title = "";
  bool loading = false;
  //function to validate and save user form
  Future<void> _savingData() async {
    final validation = _formkey.currentState?.validate();
    if (!validation!) {
      return;
    }
    _formkey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Any preferences?',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Get better recommendations with your preferences',
              style: TextStyle(
                  color: Colors.grey, fontSize: 11, fontFamily: 'Poppins'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/user_preference.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: TextFormField(
                autofocus: true,
                cursorColor: const Color(0xfff1bb274),
                decoration: const InputDecoration(
                  hintText: 'Input the title of your favorite recipe..',
                  hintStyle: TextStyle(fontFamily: 'OpenSans'),
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) => title = newValue.toString(),
              ),
            ),
            const SizedBox(
              height: 270,
            ),
            loading
                ? const CircularProgressIndicator()
                : RoundedButton(
                    text: 'Done',
                    press: () async {
                      setState(() {
                        loading = true;
                      });
                      _savingData();
                      final url = 'http://10.0.2.2:5000/title';

                      final response = await http.post(Uri.parse(url),
                          body: json.encode({'title': title}));
                      print('${title}');

                      // ignore: use_build_context_synchronously
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed("/bottomnav");
                      setState(() {
                        loading = false;
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}
