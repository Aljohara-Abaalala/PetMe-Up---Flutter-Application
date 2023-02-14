import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/Strings.dart';

import '../models/Booking.dart';
import 'booking_details_screen.dart';

class BookingList extends StatefulWidget {
  final String? userId;
  final bool isPetOwner;

  BookingList({
    required this.userId,
    required this.isPetOwner,
  });

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  List<Booking> _bookings = [];
  Map<String, dynamic> _userInfo = {};
  bool loading = true;
  bool loadingUserInfo = true;

  @override
  void initState() {
    super.initState();
    loading = true;
    loadingUserInfo = true;

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child('Boking');
    if (widget.isPetOwner) {
      reference
          .orderByChild('sander')
          .equalTo(widget.userId)
          .onValue
          .listen((event) {
        setState(() {
          if (event.snapshot.value != null) {
            _bookings = (event.snapshot.value as Map<dynamic, dynamic>)
                .map((key, value) => MapEntry(
                    key, Booking.fromSnapshot(event.snapshot.child(key))))
                .values
                .toList();
            loading = false;
          } else {
            _bookings = [];
            loading = false;
          }
        });
      });
    } else {
      reference
          .orderByChild('staff')
          .equalTo(widget.userId)
          .onValue
          .listen((event) {
        setState(() {
          if (event.snapshot.value != null) {
            _bookings = (event.snapshot.value as Map<dynamic, dynamic>)
                .map((key, value) => MapEntry(
                    key, Booking.fromSnapshot(event.snapshot.child(key))))
                .values
                .toList();
            loading = false;
          } else {
            _bookings = [];
            loading = false;
          }
        });
      });
    }
    FirebaseDatabase.instance
        .reference()
        .child('Userinfo')
        .onValue
        .listen((event) {
      setState(() {
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> temp =
              event.snapshot.value as Map<dynamic, dynamic>;
          _userInfo = temp.map((key, value) => MapEntry(key.toString(), value));
          loadingUserInfo = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading||loadingUserInfo)
          ? const Center(child: Text('Fetching data...'))
          : (_bookings.isEmpty)
              ? const Center(child: Text('You do not have requests'))
              : ListView.builder(
                  itemCount: _bookings.length,
                  itemBuilder: (context, index) {
                    String sander = _bookings[index].sander;
                    String staff = _bookings[index].staff;
                    String status = _bookings[index].status;
                    String serviceType = _bookings[index].serviceType;

                    if (_userInfo.containsKey(sander)) {
                      print("SENDER NAME: " +
                          _userInfo[sander]['Name'].toString());
                      // sander = _userInfo[sander]['name'];
                    }
                    if (_userInfo.containsKey(staff)) {
                      print(
                          "STAFF NAME: " + _userInfo[staff]['Name'].toString());

                      // staff = _userInfo[staff]['name'];
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: GestureDetector(
                        onTap: () =>{
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingDetailsScreen(
                                    bookingId: _bookings[index].uid,
                                    booking: _bookings[index],
                                    clientName: _userInfo![sander]['Name'],
                                    staffName: _userInfo![staff]['Name'],
                                    isPetOwner: widget.isPetOwner
                                  ),
                                ))
                              },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.lightBlue,
                                  child: Icon(
                                    (_bookings[index].serviceType ==
                                                petSitting ||
                                            _bookings[index].serviceType ==
                                                petBoarding)
                                        ? Icons.chair
                                        : (_bookings[index].serviceType ==
                                                petTaxi)
                                            ? Icons.local_taxi_rounded
                                            : Icons.local_hospital_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.isPetOwner
                                          ? _userInfo![staff]['Name']
                                          : _userInfo![sander]['Name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      _bookings[index].serviceType,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        _bookings[index].status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: (_bookings[index].status ==
                                                    'pending')
                                                ? Colors.orangeAccent
                                                : (_bookings[index].status ==
                                                        'Declined')
                                                    ? Colors.redAccent
                                                    : Colors.greenAccent),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
