import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff1bb274),
        title: const Text('About'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                "EasyCook",
                style: TextStyle(fontFamily: "Satisfy", fontSize: 30),
              )),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/splash.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              RichText(
                text: const TextSpan(
                  text: '\teasycook ',
                  style: TextStyle(
                      fontSize: 20, fontFamily: "Satisfy", color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          'is a cookbook android-based application was created by Farischa Makay as a final project for her thesis. The application provides recipes to users with a feature that recommends recipes based on the similarity of the input title and ingredients. Users can also save their favorite recipes by pressing the love button. Additionally, users can search for recipes using the search feature in the application. ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Version"), Text("1.0.0")],
              )
            ],
          )),
    );
  }
}
