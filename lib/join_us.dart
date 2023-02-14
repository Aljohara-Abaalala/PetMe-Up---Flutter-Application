import 'package:flutter/material.dart';
//import 'package:pet_home/onboarding/vet_consultation_page.dart';

class JoinUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text(
          'join us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/joinus.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 460),
                  Row(
                    children: [
                      SizedBox(width: 95),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Join ->",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                height: 1.5)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/PetOwner');
                        },
                      ),
                      SizedBox(width: 95),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Join ->",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                height: 1.0)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/PetSitter');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 130),
                  Row(
                    children: [
                      SizedBox(width: 95),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Join ->",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                height: 1.5)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/Student');
                        },
                      ),
                      SizedBox(width: 95),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Join ->",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                height: 1.5)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/Vet');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 38),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
