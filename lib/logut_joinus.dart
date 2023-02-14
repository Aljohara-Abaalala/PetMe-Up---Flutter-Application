import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/join_us.dart';
import 'package:pet_home/main.dart';
//import 'package:pet_home/onboarding/vet_consultation_page.dart';

class JoinUsLoguot extends StatefulWidget {
  @override
  State<JoinUsLoguot> createState() => _JoinUsLoguotState();
}

class _JoinUsLoguotState extends State<JoinUsLoguot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/BG2.png'),
                  fit: BoxFit.cover,
                ),
              ),

            ),
Center(child: Padding(
  padding: const EdgeInsets.only(bottom: 130),
  child:   const Text('You have Successfully loged out ', style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    )),
)),
            Center(
              child: Icon(
                Icons.task_alt,
                size: 100,
                color: Colors.lightGreen,
              ),
            ),
  Center(

    child: Padding(
      padding: const EdgeInsets.only(top:130),
      child: TextButton(onPressed: () {
        Navigator.of(context)
            .pushAndRemoveUntil(
        CupertinoPageRoute(
        builder: (context) => JoinUs()
        ),
        (_) => false,
        );
        }, child: Text('Go back to Join Us page', style: TextStyle(
        fontSize: 22,
        color: Colors.black,
        decoration: TextDecoration.underline, // <-- SEE HERE
      ),)),
    ),
  )

          ],
        ),
      ),
    );
  }
}
