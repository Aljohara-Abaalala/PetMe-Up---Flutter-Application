import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/BG2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 25, right: 25),
                  child: Text('Contact Us',
                      style: TextStyle(fontSize: 26, color: Color(0xff222222))),
                )),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffdfdfdf),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(35),
                        child: Text('For any inquires please contact us at: ',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.call,
                          color: Colors.black,
                        ),
                        title: Text(
                          '+996-053-220-4789',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                        width: 200,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        title: Text(
                          'PetMeUp.Support@gmail.com',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
