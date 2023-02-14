import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_home/Strings.dart';
//import 'package:pet_home/bottom_navi_bar/chat_page.dart';
import 'package:pet_home/services/firebase.dart';
import 'package:pet_home/src/digital_contract.dart';
import '../OwnerHome/profile_page.dart';
import 'option_model.dart';
import 'Porson_Model.dart';

class VetPetSelelection extends StatefulWidget {
  const VetPetSelelection({super.key, required this.myService});
  final Service myService;
  final String userType = "";

  @override
  State<VetPetSelelection> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<VetPetSelelection> {
  int _selectedIndex = 0;
  List pages = const [
    SizedBox(),
   // ChatPage(),
    ProfilePage(),
  ];

  List<PorsonModel> list = [];

  final FirebaseService _service = FirebaseService();

  String userType = student;
  @override
  void initState() {
    super.initState();
    //print('SERVICE TYPE IS'+ widget.myService.serviceType.toString());
    switch (widget.myService.serviceType.toString()) {
      case petBoarding:
        userType = student;
        break;
      case petSitting:
        userType = petSitter;
        break;
      case petTaxi:
        userType = student;
        break;
      case petConsultation:
        userType = vet;
        break;
      default:
        userType = student;
        break;
    }    init();
  }

  Future<void> init() async {
    var xlist = await _service.getlistInfo(userType); //PetSitter//Vet
    if (xlist != null) {
      list.clear();

      for (var element in xlist) {
        list.add(PorsonModel(
            no: element['id'],
            name: element['data']['Name'],
            subtitle: element['data']['UserType'],
            detile: element['data']['Experience'],
            rating: 2,
            img: ""));
      }
      setState(() {});
    }
  }

  Widget getpages() {
    return homepage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/BGB3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, //
        appBar: AppBar(
          backgroundColor: Colors.transparent, //
          shadowColor: Colors.transparent, //
          iconTheme: IconThemeData(
            color: Colors.grey[900],
          ),
          centerTitle: true,
        ),
        body: Center(child: Padding(
          padding: const EdgeInsets.only(top: 65),
          child: getpages(),
        )),
      ),
    );
  }

  Widget homepage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Expanded(
        child: CustomScrollView(
          primary: true,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  5.height,
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    title: Center(
                      child: Text(
                        '',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    subtitle: Center(
                        child: Text(
                      '',

                      // overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.button,
                    ) //.paddingTop(15),
                        ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      showlistOption(),
                      5.height,
                      5.height,
                    ],
                  ),
                ],
              ),
              //),
            ),
          ],
        ),
      ),
    );
  }

  Widget showlistOption() {
    return SizedBox(
      height: 500,
      child: GridView.builder(
        shrinkWrap: true,
        //   controller: controller,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.1),
        itemCount: list.length,
        itemBuilder: (_, int index) {
          var item = list[index];
          return InkWell(
              onTap:(() {
            showConfirmDialogCustom(
              context,
              title: "Do you want to book  ?",
              dialogType: DialogType.CONFIRMATION,
              onAccept: (_) {
                  var ser = widget.myService;
                  debugPrint(item.no);
                  ser.staff = item.no;
                _service.saveBoking(ser);
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
            // onTap: () {
            //   var ser = widget.myService;
            //   debugPrint(item.no);
            //   ser.staff = item.no;
            //   setState(() {});
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DigitalContract(
            //               myService: ser,
            //             )),
            //   );
            // },
              ,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 10,
                        offset: const Offset(0, 3))
                  ]),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: '${item.no ?? index}',
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 80 / 3.5,
                        height: 80 / 3.5,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('images/Vetpic.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.height,
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${item.name}',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${item.subtitle}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 9),
                        ),
                        Text(
                          '${item.detile}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 2,
                        ),

                        2.height,
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
