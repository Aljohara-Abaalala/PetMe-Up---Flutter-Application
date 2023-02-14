import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Booking.dart';
import '../services/firebase.dart';
import '../models/message_model.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;
  final Booking booking;
  final String clientName;
  final String staffName;
  final bool isPetOwner;

  const BookingDetailsScreen(
      {super.key,
      required this.bookingId,
      required this.booking,
      required this.clientName,
      required this.staffName,
      required this.isPetOwner});

  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool _updating = false;
  bool _loadingMessages = true;
  final FirebaseService _service = FirebaseService();
  List<Message> _messages = [];
  late String _newMessage = '';
  late StreamSubscription _subscription;
  final TextEditingController _controller = TextEditingController();


  // final messagesRef = FirebaseDatabase.instance
  //     .reference()
  //     .child('booking')
  //     .child(widget.bookingId)
  //     .child('messages');

  @override
  void initState() {
    super.initState();

    final messagesRef = FirebaseDatabase.instance
        .reference()
        .child('Boking')
        .child(widget.bookingId)
        .child('messages');

    _subscription =
        messagesRef.orderByChild('timestamp').onValue.listen((event) {
      if (mounted) {
        setState(() {
          if (event.snapshot.value != null) {
            _messages = (event.snapshot.value as Map<dynamic, dynamic>)
                .map((key, value) => MapEntry(
                    key, Message.fromSnapshot(event.snapshot.child(key))))
                .values
                .toList();
            _messages.sort((a, b) {
              DateFormat format = DateFormat('dd/MMM/yyyy hh:mm:ss a');
              DateTime aDate = format.parse(a.timestamp);
              DateTime bDate = format.parse(b.timestamp);
              return aDate.compareTo(bDate);
            });
            _loadingMessages = false;
          } else {
            _messages = [];
            _loadingMessages = false;
          }
        });
      }
    });
  }

  void _updateBookingStatus(String status) async {
    setState(() {
      _updating = true;
    });
    _service.updateBooking(widget.bookingId, status).then((value) => {
          setState(() {
            _updating = false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The status of the request has been updated'),
            ));

            Navigator.of(context).pop();
          })
        });
    // Update booking status here
  }

  void _sendMessage() {

    if (_newMessage != null && _newMessage.isNotEmpty) {
      setState(() {
        _messages.add(Message(
          message: _newMessage,
          senderName: widget.isPetOwner?widget.clientName:widget.staffName,
          timestamp: DateFormat('dd/MMM/yyyy hh:mm:ss a').format(DateTime.now()),
          isPetOwner: widget.isPetOwner,
        ));

       // _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        _messages.sort((a, b) {
          DateFormat format = DateFormat('dd/MMM/yyyy hh:mm:ss a');
          DateTime aDate = format.parse(a.timestamp);
          DateTime bDate = format.parse(b.timestamp);
          return aDate.compareTo(bDate);
        });

      });
      FirebaseDatabase.instance
          .reference()
          .child("Boking")
          .child(widget.bookingId)
          .child("messages")
          .push()
          .set({
        'senderName': widget.isPetOwner?widget.clientName:widget.staffName,
        'message': _newMessage,
        'timestamp': DateFormat('dd/MMM/yyyy hh:mm:ss a').format(DateTime.now()),
        'isPetOwner': widget.isPetOwner,
      }).then((value) => {
        _newMessage = '',
          _controller.text = ''
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 1),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 25, bottom: 25),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "Requested By: ${widget.clientName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 3, bottom: 3),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bookingInfoSlot("Service Type:", widget.booking.serviceType),
                    bookingInfoSlot("Duration:", widget.booking.packge),
                    bookingInfoSlot("Pet Type:", widget.booking.petType),
                    bookingInfoSlot("Pet Size:", widget.booking.petsize),
                    bookingInfoSlot("Location:", widget.booking.location),
                  ],
                ),
              ),
            ),
          ),
          if (widget.booking.status == 'pending' && !widget.isPetOwner)
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 3),
              child: Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _updating
                          ? null
                          : () => _updateBookingStatus('Accepted'),
                      child: const Text('Accept'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: _updating
                          ? null
                          : () => _updateBookingStatus('Declined'),
                      child: const Text('Decline'),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.booking.status == 'Accepted' && !widget.isPetOwner)
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 3),
              child: Card(
                elevation: 3,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: _updating
                          ? null
                          : () => _updateBookingStatus('Declined'),
                      child: const Text('Decline'),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.booking.status == 'Completed' ||
              widget.booking.status == 'Declined')
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 3),
              child: Card(
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (widget.booking.status == 'Completed')
                        ? 'Completed and Closed'
                        : 'The request is declined',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 7,),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Chat Section',
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            ],
          ),
          if (widget.booking.status == 'Accepted')
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final innerMessage = _messages[index];
                  return Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8,right: 16,left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(innerMessage.message,style:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6,),
                        Text(
                          'by: ${innerMessage.senderName} - ${innerMessage.timestamp}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          if (_messages.isEmpty && widget.booking.status == 'Accepted')
            const Center(
              child: Text('No messages',style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          if (widget.booking.status == 'Accepted')
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _newMessage = value;
                        });
                      },
                      decoration: InputDecoration(hintText: 'Type your message'),
                      controller: _controller,                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
        ]),
      ),
    ));
  }

  Widget bookingInfoSlot(infoTitle, infoValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(infoTitle,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8.0),
          Text(infoValue,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
