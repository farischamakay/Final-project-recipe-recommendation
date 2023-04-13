import 'package:cooking_tutorial_application/screens/start/screens/user_preferences.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../widgets/rounded_button.dart';

class CompleteProfilPage extends StatefulWidget {
  static const nameRoute = 'completeprofile';
  const CompleteProfilPage({super.key});

  @override
  State<CompleteProfilPage> createState() => _CompleteProfilPageState();
}

class _CompleteProfilPageState extends State<CompleteProfilPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? level;
  String? vegetarian;
  String? radioButtonItem;
  int val = -1;
  bool loading = false;

  Future addUserDetails(String userName, String userLevel, String userGender,
      String userCountry, String userVegetarian) async {
    FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': userEmail,
      'username': userName,
      'level': userLevel,
      'gender': userGender,
      'country': userCountry,
      'vegetarian': userVegetarian
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Complete your profile',
              style: TextStyle(fontSize: 30, fontFamily: 'Satoshi'),
            ),
            const SizedBox(
              height: 45,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      cursorColor: const Color(0xfff1bb274),
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(fontFamily: 'OpenSans'),
                        border: OutlineInputBorder(),
                      ),
                      validator: Validators.compose([
                        Validators.required('Username is required'),
                      ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownSearch<String>(
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                      ),
                      items: ["Beginner", "Middle", "Expert"],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Level",
                          labelStyle: TextStyle(fontFamily: 'OpenSans'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (String? val) {
                        level = val;
                        setState(() {
                          level = val;
                        });
                      },
                      //selectedItem: "",
                      validator: (String? item) {
                        if (item == null) return "Required field";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Please Let us know your gender : ',
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          radioButtonItem = 'Male';
                                          val = 1;

                                          print(radioButtonItem);
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Male'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: val,
                                      onChanged: (value) {
                                        setState(() {
                                          radioButtonItem = 'Female';
                                          val = 2;

                                          print(radioButtonItem);
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Female'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: _countryController,
                      cursorColor: const Color(0xfff1bb274),
                      decoration: const InputDecoration(
                          hintText: 'Country',
                          hintStyle: TextStyle(fontFamily: 'OpenSans'),
                          border: OutlineInputBorder()),
                      validator: Validators.compose([
                        Validators.required('Country is required'),
                      ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownSearch<String>(
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                      ),
                      items: ["Vegetarian", "Vegan"],
                      selectedItem: vegetarian,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Are you vegetarian?",
                          labelStyle: TextStyle(fontFamily: 'OpenSans'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (String? val) {
                        vegetarian = val;
                        setState(() {
                          vegetarian = val;
                        });
                      },
                      //selectedItem: "",
                      validator: (String? item) {
                        if (item == null) return "Required field";
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loading
                        ? CircularProgressIndicator()
                        : RoundedButton(
                            text: 'NEXT',
                            press: () {
                              setState(() {
                                loading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                addUserDetails(
                                    _usernameController.text.trim(),
                                    level.toString(),
                                    radioButtonItem.toString(),
                                    _countryController.text.toString(),
                                    vegetarian.toString());
                                const Duration(milliseconds: 500);
                                Navigator.pushNamed(
                                    context, UserPreferencesPage.routeName);
                              }
                              setState(() {
                                loading = false;
                              });
                            })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
