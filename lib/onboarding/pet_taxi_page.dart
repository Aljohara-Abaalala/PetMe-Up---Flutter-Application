import 'package:flutter/material.dart';
import 'package:pet_home/onboarding/pet_boarding_page.dart';
import 'package:pet_home/onboarding/vet_consultation_page.dart';

class TetTaxiPage extends StatefulWidget {
  @override
  _TetTaxiPageState createState() => _TetTaxiPageState();
}

class _TetTaxiPageState extends State<TetTaxiPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      4,
      (index) => Container(),
    );
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/img2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => PetBoardingPage()),
                        );
                      },
                      child: Text(
                        ' Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 6,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 6,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 6,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => VetConsultationPage()),
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
