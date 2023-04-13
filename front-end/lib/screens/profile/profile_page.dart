import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatefulWidget {
  static const nameRoute = '/profilpage';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  final _themeData = GetStorage();
  bool _isdarkMode = false;

  @override
  void initState() {
    super.initState();
    _themeData.writeIfNull("darkmode", false);
    _isdarkMode = _themeData.read("darkmode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfff1bb274),
          title: const Text(
            "EasyCook",
            style: TextStyle(
                fontFamily: 'Satisfy',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        body: Container(
            color: _isdarkMode ? Color(0xff2e3233) : Colors.white,
            padding: const EdgeInsets.all(32.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: _isdarkMode
                                  ? const Color.fromARGB(255, 32, 18, 18)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage('assets/profile.png'),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong!");
                              }
                              if (snapshot != null && snapshot.data != null) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.get('username'),
                                        style: TextStyle(
                                          color: _isdarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data!.get('email')}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          color: _isdarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => _bottomSheets(context),
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xff66ff66)),
                              child: Center(
                                child: Text(
                                  'Details',
                                  style: TextStyle(
                                    color: _isdarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'More',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.edit_outlined,
                            color: _isdarkMode ? Colors.white : Colors.black,
                          ),
                          title: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    _isdarkMode ? Colors.white : Colors.black),
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed("/editProfile");
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SwitchListTile(
                          secondary: Icon(Icons.ac_unit),
                          title: const Text(
                            "Theme",
                            style: TextStyle(fontSize: 12),
                          ),
                          value: _isdarkMode,
                          onChanged: (value) {
                            setState(() {
                              _isdarkMode = value;
                            });
                            _isdarkMode
                                ? Get.changeTheme(ThemeData.dark())
                                : Get.changeTheme(ThemeData.light());
                            _themeData.write('darkmode', value);
                          },
                          activeThumbImage:
                              const AssetImage("assets/half-moon.png"),
                          inactiveThumbImage:
                              const AssetImage("assets/sun.png"),
                          activeColor: Colors.blue,
                          inactiveTrackColor: Colors.grey,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.note_outlined,
                            color: _isdarkMode ? Colors.white : Colors.black,
                          ),
                          title: Text('About App',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black)),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed("/about");
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          ),
                          title: const Text(
                            'Log out',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed("/loginpage");
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ])));
  }

  void _bottomSheets(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => SingleChildScrollView(
                child: Container(
              decoration: BoxDecoration(
                  color: _isdarkMode ? Colors.black : Color(0xff9cff88),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong!");
                  }
                  if (snapshot != null && snapshot.data != null) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Details",
                            style: TextStyle(
                              color: _isdarkMode ? Colors.white : Colors.black,
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text(
                              'Username',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.get('username')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color:
                                    _isdarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.get('email')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color:
                                    _isdarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Level',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.get('level')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color:
                                    _isdarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.get('gender')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color:
                                    _isdarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Country',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.get('country')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color:
                                    _isdarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Vegetarian status',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: _isdarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.get('vegetarian')}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color:
                                    _isdarkMode ? Colors.white : Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )));
  }
}
