import 'package:flutter/material.dart';

class VersionPage extends StatelessWidget {
  static const nameRoute = '/versionpage';
  const VersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xff297061),
              )),
          title: const Text(
            'Versi Aplikasi',
            style: TextStyle(color: Color(0xff297061), fontFamily: 'Poppins'),
          )),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Versi Aplikasi',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            Text(
              '1.0.0',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            )
          ],
        ),
      ),
    );
  }
}
