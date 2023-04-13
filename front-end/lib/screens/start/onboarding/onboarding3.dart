import 'package:flutter/material.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Image(image: AssetImage('assets/onboarding3.png')),
          SizedBox(
            height: 30,
          ),
          Text(
            'Try Making Your Own Food Now',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Don\'t wait to long! Lets try make your own food now',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }
}
