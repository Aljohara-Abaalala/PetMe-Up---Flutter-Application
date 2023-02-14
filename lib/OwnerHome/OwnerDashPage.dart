import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/ContactUs.dart';
import 'package:pet_home/join_us.dart';
import 'package:editable_image/editable_image.dart';
import 'package:pet_home/logut_joinus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../src/booking_list.dart';
//import 'main.dart';

class OwnerProfilePage extends StatefulWidget {
  @override
  State<OwnerProfilePage> createState() => _OwnerProfilePageState();
}

class _OwnerProfilePageState extends State<OwnerProfilePage> {
  File? _profilePicFile;

  @override
  void initState() {
    super.initState();
  }

  // A simple usage of EditableImage.
  // This method gets called when trying to change an image.
  void _directUpdateImage(File? file) async {
    if (file == null) return;

    setState(() {
      _profilePicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = (ModalRoute.of(context)!.settings.arguments == null)
        ? "User"
        : ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25, right: 25),
                    child: Text('Profile',
                        style:
                            TextStyle(fontSize: 26, color: Color(0xff222222))),
                  )),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 100),
                EditableImage(
                  // Define the method that will run on the change process of the image.
                  onChange: (file) => _directUpdateImage(file),

                  // Define the source of the image.
                  image: _profilePicFile != null
                      ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                      : null,

                  // Define the size of EditableImage.
                  size: 150.0,

                  // Define the Theme of image picker.
                  imagePickerTheme: ThemeData(
                    // Define the default brightness and colors.
                    primaryColor: Colors.white,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white70,
                    iconTheme: const IconThemeData(color: Colors.black87),

                    // Define the default font family.
                    fontFamily: 'Georgia',
                  ),

                  // Define the border of the image if needed.
                  imageBorder: Border.all(color: Colors.black87, width: 2.0),

                  // Define the border of the icon if needed.
                  editIconBorder: Border.all(color: Colors.black87, width: 2.0),
                ),
                buildText("$name"),
                const Text(
                  'Pet Owner',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff222222),
                  ),
                ),
                const SizedBox(
                  height: 0,
                  width: 200,
                ),
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xffdfdfdf),
                      child: Icon(
                        Icons.pets_rounded,
                        color: Colors.black,
                      ),
                    ),
                    title: const Text(
                      'My Services',
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingList(
                                    userId: FirebaseAuth
                                        ?.instance?.currentUser?.uid,
                                    isPetOwner: true,
                                  )));
                    },
                  ),
                ),
                Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xffed7858),
                        child: Icon(
                          Icons.call,
                          color: Colors.black,
                        ),
                      ),
                      title: const Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUs()),
                        );
                      },
                    )),

                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xffc27bdf),
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        AlertDialog alert = AlertDialog(
                          title: const Text('Please Confirm'),
                          content:
                              const Text('Are you sure you want to Logout?'),
                          actions: [
                            // The "Yes" button
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JoinUsLoguot()),
                                  );
                                  // Remove the box

                                  // Close the dialog
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'))
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Text buildText(String s) {
  return Text(
    s,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}
