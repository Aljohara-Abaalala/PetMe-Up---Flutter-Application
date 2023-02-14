import 'package:firebase_database/firebase_database.dart';

class Message {
  final String message;
  final String senderName;
  final String timestamp;
  final bool isPetOwner;

  Message({
    required this.message,
    required this.senderName,
    required this.timestamp,
    required this.isPetOwner,
  });


  Message.fromSnapshot(DataSnapshot snapshot):message = (snapshot.value as Map<dynamic, dynamic>)['message'] ?? '',
        senderName = (snapshot.value as Map<dynamic, dynamic>)['senderName'] ?? '',
        timestamp = (snapshot.value as Map<dynamic, dynamic>)['timestamp'] ?? '',
        isPetOwner = (snapshot.value as Map<dynamic, dynamic>)['isPetOwner'] ?? '';


}
