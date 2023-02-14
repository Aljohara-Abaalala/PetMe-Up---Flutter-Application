import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatelessWidget {
  TextEditingController _EmailTextContorller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text('Password Reset'),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/passres.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                const SizedBox(height: 120),
                Form(
                  key: _FormKey,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              controller: _EmailTextContorller,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                        .hasMatch(value)) {
                                  return "enter correct Email";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    primary: Colors.amber[300],
                  ),
                  child: const Text("Submit",
                      style: TextStyle(
                          fontSize: 25, color: Colors.black, height: 1.5)),
                  onPressed: () {
                    auth
                        .sendPasswordResetEmail(
                            email: _EmailTextContorller.text)
                        .then((value) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          content: const Text(
                              "Email has been sent to reset password"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Login');
                              },
                              child: Container(
                                color: Color(0xff3f60a0),
                                padding: const EdgeInsets.all(14),
                                child: const Text("okay",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                    if (_FormKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                content: const Text("Error."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/PetOwner');
                                    },
                                    child: Container(
                                      color: Color(0xff3f60a0),
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              ));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
