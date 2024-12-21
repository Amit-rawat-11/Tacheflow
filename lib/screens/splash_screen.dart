import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tacheflow/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
                shape: BoxShape.rectangle),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, right: 14),
              child: SvgPicture.asset(
                'assets/images/todolist.svg',
                height: 275,
                width: double.infinity,
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          SvgPicture.asset('assets/images/logo.svg'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          SizedBox(
            width: 190,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>  HomeScreen(),
                  ),
                );
              },
              child: const Text(
                "Let's Go !!! ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
