import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? level;
  String? vegetarian;
  String? gender;
  int val = -1;

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green, content: Text(message.toString())));
  }

  Future editUserDetails(String userName, String userLevel, String userGender,
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
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong!");
              }
              if (snapshot != null && snapshot.data != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Update Profile',
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
                                decoration: InputDecoration(
                                  hintText:
                                      "Current Username : ${snapshot.data!.get('username')}",
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
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText:
                                        "Current level : ${snapshot.data!.get('level')}",
                                    labelStyle:
                                        TextStyle(fontFamily: 'OpenSans'),
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
                                      'Please let us know your gender : ',
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'OpenSans'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: val,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender = 'Male';
                                                    val = 1;

                                                    print(gender);
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
                                                    gender = 'Female';
                                                    val = 2;

                                                    print(gender);
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
                                decoration: InputDecoration(
                                    hintText:
                                        "Current country : ${snapshot.data!.get('country')}",
                                    hintStyle:
                                        TextStyle(fontFamily: 'OpenSans'),
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
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText:
                                        "Current status : ${snapshot.data!.get('vegetarian')}",
                                    labelStyle:
                                        TextStyle(fontFamily: 'OpenSans'),
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
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xfff1bb274)),
                                  child: const Text('Update profile'),
                                  onPressed: () {
                                    try {
                                      if (_formKey.currentState!.validate()) {
                                        editUserDetails(
                                            _usernameController.text.trim(),
                                            level.toString(),
                                            gender.toString(),
                                            _countryController.text.toString(),
                                            vegetarian.toString());
                                        showNotification(
                                            context, "Update data successful!");
                                        Navigator.pop(context);
                                      }
                                    } on FirebaseException catch (e) {
                                      showNotification(
                                          context, e.message.toString());
                                    }
                                  })
                            ],
                          ))
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
