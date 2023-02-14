import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/SitterHome/SitterDashPage.dart';
import 'package:pet_home/join_us.dart';
import 'package:pet_home/main.dart';
//import 'package:pet_home/onboarding/vet_consultation_page.dart';

class suc_pay extends StatefulWidget {
  @override
  State<suc_pay> createState() => _suc_payState();
}

class _suc_payState extends State<suc_pay> {
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
              child:   const Text('Your Payment is  Successfull ', style: TextStyle(
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
                  Navigator.pop(context);
                }, child: Text('Go back ', style: TextStyle(
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
