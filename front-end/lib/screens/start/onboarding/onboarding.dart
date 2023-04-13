import 'package:cooking_tutorial_application/screens/start/onboarding/onboarding1.dart';
import 'package:cooking_tutorial_application/screens/start/onboarding/onboarding2.dart';
import 'package:cooking_tutorial_application/screens/start/onboarding/onboarding3.dart';
import 'package:cooking_tutorial_application/screens/start/screens/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboardingpage';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              OnboardingPage1(),
              OnboardingPage2(),
              OnBoardingPage3()
            ],
          ),
          Container(
              padding: const EdgeInsets.all(20),
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfff1bb274)),
                            onPressed: () {
                              const Duration(milliseconds: 1000);
                              Navigator.pushNamed(
                                  context, LoginScreen.nameRoute);
                            },
                            child: const Text(
                              'Start',
                            ),
                          ))
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Row(
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(Icons.navigate_next_rounded),
                            ],
                          ),
                        )
                ],
              ))
        ],
      ),
    );
  }
}
