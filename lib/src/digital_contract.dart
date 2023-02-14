import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_home/services/firebase.dart';
import 'option_model.dart';

class DigitalContract extends StatefulWidget {
  const DigitalContract({super.key, required this.myService});

  final Service myService;

  @override
  State<DigitalContract> createState() => _DigitalContractState();
}

class _DigitalContractState extends State<DigitalContract> {
  bool? agree = false;
  final FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/BG.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, //
        appBar: AppBar(
          shadowColor: Colors.transparent,
          //
          backgroundColor: Colors.transparent,
          //
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Colors.grey,
                height: 3.0,
              )),
          title: const Center(
              child: Text(
            'Digital Contract',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[350],
                  ),
                  child: Column(
                    children: [
                      Text('Digital Contract Agreement',
                              style: primaryTextStyle(size: 18))
                          .paddingBottom(5),
                      Container(
                        color: Colors.grey,
                        height: 3.0,
                      ).paddingBottom(5),
                      UL(
                        symbolType: SymbolType.Bullet,
                        children: [
                          Text(
                              'Pet owners are legally confined to  pay the required service fees. ',
                              style: primaryTextStyle()),
                          Text(
                              'Pet Sitters and vets are  legally  confined to pay the required transaction fee, if your payment method fails or  your account past due we may place restrictions on your account ',
                              style: primaryTextStyle()),
                          Text(
                              'You consent to the disclosure of certain personally identifiable information.',
                              style: primaryTextStyle()),
                        ],
                      ).paddingAll(5),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: agree,
                                  onChanged: (v) {
                                    agree = v;
                                    setState(() {});
                                  }),
                              const Text(
                                  'I agree to the Digital Contract Agreement'),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueGrey[600]),
                  child: const Text(
                    'book',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ).onTap(() {
                  showConfirmDialogCustom(
                    context,
                    title: "Do you want to book  ?",
                    dialogType: DialogType.CONFIRMATION,
                    onAccept: (_) {
                      _service.saveBoking(widget.myService);
                      // showDialog(
                      //     context: context,
                      //     builder: (ctx) => AlertDialog(
                      //       content:
                      //       const Text("Your request has been submitted to the service provider\nCheck My Services section"),
                      //       actions: <Widget>[
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pushReplacementNamed('/OwnerBottomNav');
                      //           },
                      //           child: Container(
                      //             color: Color(0xff3f60a0),
                      //             padding: const EdgeInsets.all(14),
                      //             child: const Text("okay",
                      //                 style: TextStyle(
                      //                   color: Colors.white,
                      //                 )),
                      //           ),
                      //         ),
                      //       ],
                      //     ));
                      launchNewScreenWithNewTask(context, '/OwnerBottomNav');
                      snackBar(context,
                          title:
                              'Your Booking has successfully Submitted - \nCheck "My Services Section"',
                          backgroundColor: Colors.indigo);
                    },
                  );
                })
              ],
            ),
          ),
        ).paddingOnly(top: 10),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          iconSize: 35,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff3f60a0),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  int _selectedIndex = 0;

  List<Widget> pages = const [
    SizedBox(
      width: 200,
      height: 200,
    ),
    SizedBox(
      width: 200,
      height: 200,
    ),
    SizedBox(
      width: 200,
      height: 200,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
