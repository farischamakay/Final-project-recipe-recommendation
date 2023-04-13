import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Image(image: AssetImage('assets/onboarding2.png')),
          SizedBox(
            height: 30,
          ),
          Text(
            'Simplified Cooking',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Keep it easy with these simple but delicious recipes. From make-ahead lunches and midweek meals to fuss-free sides and moreish cakes, we\'ve got everything you need',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          )
        ],
      ),
    );
  }
}
