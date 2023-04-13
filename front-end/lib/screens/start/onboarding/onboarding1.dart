import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Image(image: AssetImage('assets/onboarding1.png')),
          SizedBox(
            height: 30,
          ),
          Text(
            'Get Recommendation Recipes',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Get the recommendation food and drink ideas based on your profile and preferences.',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }
}
