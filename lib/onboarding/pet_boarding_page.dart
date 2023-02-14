import 'package:flutter/material.dart';
import 'package:pet_home/onboarding/pet_sitting_page.dart';
import 'package:pet_home/onboarding/pet_taxi_page.dart';

class PetBoardingPage extends StatefulWidget {
  @override
  _PetBoardingPageState createState() => _PetBoardingPageState();
}

class _PetBoardingPageState extends State<PetBoardingPage> {
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
                      image: AssetImage('images/img1.png'),
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
                          MaterialPageRoute(builder: (_) => PetSittingPage()),
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
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey,
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
                          MaterialPageRoute(builder: (_) => TetTaxiPage()),
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
