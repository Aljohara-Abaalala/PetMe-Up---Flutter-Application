import 'package:flutter/material.dart';

class pending_req extends StatefulWidget {
  const pending_req({Key? key}) : super(key: key);

  @override
  State<pending_req> createState() => _pending_reqState();
}

class _pending_reqState extends State<pending_req> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BG2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 25, right: 25),
                  child: Text('Profile',
                      style: TextStyle(fontSize: 26, color: Color(0xff222222))),
                )),
          ),
        ]),
      ),
    );
  }
}
