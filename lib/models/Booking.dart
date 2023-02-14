import 'package:firebase_database/firebase_database.dart';

class Booking {
  String serviceType;
  String packge;
  String location;
  String petType;
  String petsize;
  String sander;
  String staff;
  String status;
  String uid;

  Booking(
      {required this.serviceType,
      required this.packge,
      required this.location,
      required this.petType,
      required this.petsize,
      required this.sander,
      required this.staff,
      required this.status,
      required this.uid});

  Booking.fromSnapshot(DataSnapshot snapshot)
      : serviceType =
            (snapshot.value as Map<dynamic, dynamic>)['serviceType'] ?? '',
        packge = (snapshot.value as Map<dynamic, dynamic>)['packge'] ?? '',
        location = (snapshot.value as Map<dynamic, dynamic>)['location'] ?? '',
        petType = (snapshot.value as Map<dynamic, dynamic>)['petType'] ?? '',
        petsize = (snapshot.value as Map<dynamic, dynamic>)['petsize'] ?? '',
        sander = (snapshot.value as Map<dynamic, dynamic>)['sander'] ?? '',
        staff = (snapshot.value as Map<dynamic, dynamic>)['staff'] ?? '',
        status = (snapshot.value as Map<dynamic, dynamic>)['status'] ?? '',
        uid = (snapshot.value as Map<dynamic, dynamic>)['uid'] ?? '';
}
