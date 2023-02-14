import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/Strings.dart';
import 'package:pet_home/src/option_model.dart';
import 'package:uuid/uuid.dart';

import '../models/message_model.dart';


class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      getuserInfo();
      return result.user;

      // _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  bool islogin() {
    debugPrint("${_auth.currentUser?.uid}");

    return _auth.currentUser != null;
  }

  Future<Map<String, dynamic>?> getuserInfo() async {
    if (_auth.currentUser != null) {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot =
          await ref.child('Userinfo/${_auth.currentUser!.uid}').get();
      if (snapshot.exists) {
        debugPrint('${snapshot.value}');
        return Map<String, dynamic>.from(snapshot.value as Map);

//{uid: zzEyqa8FJHcJl3HdE5h6YBM1G7W2, UserType:: Student, ID: 12345678990, Age: 22, Name: xx}
        /*   debugPrint('${cc['uid']}');
        debugPrint('${cc['UserType']}');
        debugPrint('${cc['ID']}');
        debugPrint('${cc['Age']}');
        debugPrint('${cc['Name']}');
        debugPrint('${cc['Skills']}');
        debugPrint('${cc['Experience']}');
        */
        // print(snapshot.value);
      } else {
        debugPrint('No data available.');
        return null;
      }
    }
    return null;
  }

  Future<List<dynamic>?> getlistInfo(Object? value) async {
    var list = await FirebaseDatabase.instance
        .ref('Userinfo')
        .limitToLast(350)
        //.equalTo('Student', key: 'UserType')
        .get();
    if (list.exists) {
      debugPrint('${list.value}');
    }
    Map<dynamic, dynamic>? map = list.value as Map<dynamic, dynamic>;

    // var liexx = List<Map<String, dynamic>>.from((map.values.toList()));
    List<dynamic> xx = [];
    for (var li in map.entries.toList()) {
      if(value == vet){
        if (li.value['UserType'] == value) {
          Map<String, dynamic> childData = {
            'id': li.key,
            'data': li.value,
          };
          xx.add(childData);
        }
      }else{
        if (li.value['UserType'] == student || li.value['UserType'] == petSitter ) {
          Map<String, dynamic> childData = {
            'id': li.key,
            'data': li.value,
          };
          xx.add(childData);
        }
      }

      debugPrint(li.value['Name']);
      debugPrint(li.value['UserType']);
    }
    debugPrint('${xx.length}');
    return xx;
    //map.values.toList();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => debugPrint("Send"));

      // _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      debugPrint('object');
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // FirebaseUser user = result.user;

      return result.user;
      // _userFromFirebaseUser(result.user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  saveinFirebase(Map<String, dynamic> map, String path) {
    FirebaseDatabase.instance.ref(path).set(map).then((_) {
      // Data saved successfully!
    }).catchError((error) {
      // The write failed...
    });
  }

  saveBoking(Service map) {
    const uuid = Uuid();
    String randomUUID = uuid.v1();
    debugPrint(map.toString());
    debugPrint(map.staff);
    print("UUID VALUE: $randomUUID");

    FirebaseDatabase.instance.ref("Boking").child(randomUUID).set(<String, dynamic>{
      'sander': _auth.currentUser?.uid,
      'serviceType': map.serviceType,
      'petType': map.petType,
      'petsize': map.petsize,
      'location': map.location,
      'packge': map.packge,
      'serviceprice': map.serviceprice,
      'staff': map.staff,
      'status':'pending',
      'messages':[],
      'uid':randomUUID
    }).then((_) {
      debugPrint('Data saved successfully!');
      // Data saved successfully!
    }).catchError((error) {
      // The write failed...
      debugPrint(error.toString());
    });
  }


  Future updateBooking(bookingId,status) async{
    return await FirebaseDatabase.instance.reference().child("Boking").child(bookingId).update({
      "status": status
    });
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
