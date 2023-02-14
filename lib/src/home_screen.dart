//import 'package:pet_home/bottom_navi_bar/chat_page.dart';

import 'package:pet_home/Strings.dart';

import '../OwnerHome/support_page.dart';
import '../OwnerHome/profile_page.dart';
import 'option_model.dart';
import 'package:pet_home/src/option_model_carousel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'vet_pet_selelection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<OptionGroup> list = [];

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List pages = const [
    SizedBox(),
    SupportPage(),
    ProfilePage(),
  ];

  Service myService = Service();

  @override
  void initState() {
    super.initState();
    list = [];
    list.add(
        OptionGroup(title: 'select type of  service', type: 1, listOption: [
      OptionModel(
        no: 1,
        icon: Icons.pets,
        checked: false,
        subtitle: petBoarding,
      ),
      OptionModel(
        no: 2,
        icon: Icons.home,
        checked: false,
        subtitle: petSitting,
      ),
      OptionModel(
        no: 3,
        icon: Icons.local_taxi,
        checked: false,
        subtitle: petTaxi,
      ),
      OptionModel(
        no: 4,
        icon: Icons.local_hospital_rounded,
        checked: false,
        subtitle: petConsultation,
      ),
    ]));

    list.add(
        OptionGroup(title: 'select service duration', type: 2, listOption: [
      OptionModel(
        no: 5,
        // icon: Icons.pets,
        checked: false,
        title: ' 30 Minutes ',
      ),
      OptionModel(
        no: 6,
        // icon: Icons.home,
        checked: false,
        title: ' 1-3 Hours',
      ),
      OptionModel(
        no: 7,
        //icon: Icons.local_taxi,
        checked: false,
        title: '4-8 Hours',
      ),
      OptionModel(
        no: 8,
        //  icon: Icons.local_taxi,
        checked: false,
        title: ' Overnight',
      ),
    ]));
  }

  Widget getpages() {
    return homepage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/BGB2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, //
        appBar: AppBar(
          shadowColor: Colors.transparent, //
          backgroundColor: Colors.transparent, //
          title: const Center(
              child: Text(
            '   ',
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
          padding: const EdgeInsets.only(top: 70),
          child: getpages(),
        )),
        // bottomNavigationBar: Container(
        //   color: Colors.white,
        //   child: BottomNavigationBar(
        //     elevation: 0,
        //     iconSize: 35,
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.dashboard),
        //         label: 'Home',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.chat),
        //         label: 'Chat',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: 'Profile',
        //       ),
        //     ],
        //     onTap: _onItemTapped,
        //   ),
        // ),
      ),
    );
  }

  Widget homepage() => CustomScrollView(
        primary: true,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    title: Center(
                      child: const Text(
                        ''' ''',
                      ).paddingTop(25),
                    ),
                    subtitle: Center(
                      child: const Text(
                        ' ',
                      ).paddingTop(25),
                    ),
                  ),
                ),
                Container(
                  width: context.width(),
                  // height: 200,
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 15, top: 1),
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 15, top: 1),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Theme.of(context).shadowColor,
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ]),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        showlistOption(),
                        5.height,
                        displaylocation(),
                        5.height,
                        displayCategory(),
                        5.height,
                        AppButton(
                          text: "search",
                          textColor: Colors.white,
                          color: const Color.fromARGB(
                              255, 38, 93, 138), // Optional
                          onTap: () {
                            if (myService.location == null ||
                                myService.serviceType == null ||
                                myService.petType == null ||
                                myService.petsize == null ||
                                myService.packge == null) {
                              toast('Select options first');
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => VetPetSelelection(
                                        myService: myService)),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            //),
          ),
        ],
      );

  Widget showlistOption() {
    return Center(
        child: ListView.separated(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, optionGroupIndex) {
        var optionGroup = list.elementAt(optionGroupIndex);

        return Wrap(
          children: <Widget>[
            Center(
              child: Text(
                '${optionGroup.title}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ).paddingAll(5),
            3.height,
            optinsCarouselWidget(
              optionGroup,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return 20.height;
      },
      itemCount: list.length,
      primary: false,
      shrinkWrap: true,
    ));
  }

  Widget optinsCarouselWidget(OptionGroup group) {
    return Center(
      child: Container(
        height: group.type == 2 ? 50 : 80,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: group.listOption!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var p = group.listOption!.elementAt(index);

            p.checked = group.choiceOption?.no == p.no;
            return CarouselOptionWidget(
              onTap: () {
                if (group.choiceOption?.no == p.no) {
                } else {
                  group.choiceOption = p;
                  if (group.type == 1) {
                    myService.serviceType = p.subtitle;
                  } else {
                    myService.packge = p.title;
                  }
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              option: p,
            );
          },
        ),
      ),
    );
  }

  Future<List<String>> getlocation() {
    return Future<List<String>>.value([
      'Al Aziziyah',
      'Al Badiah',
      'Al Bateha',
      'Al Daho',
      'Al Dhahirah',
      'Al Dubiyah',
      'Al Faisaliyyah',
      'Al Hamra',
      'Al Malazz',
      'Al Mansurah',
      'Al Marqab',
      'Al Murabba',
      'Al Nafal',
      'Al Olaya',
      'Al Oud',
      'Al Qiri',
      'Al Rabwah',
      'Al Salihiyah ',
      'Al Wizarat',
      'Al Wusaita',
      'Al Yamamah',
      'Al-Suwaidi',
      'Al-Urayja',
      'Diplomatic Quarter',
      'Al Dirah ',
      'Gabrah',
      'Ghubaira',
      'Al Khalidiyyah',
      'King Salman Park',
      'Manfuhah',
      'Manfuhah Al Jadidah',
      'Sinaiyah Qadeem',
      'Skirina',
      'Sports Boulevard',
      'Ulaysha',
      'Umm Sulaim',
      'Utayqah'
    ]);
  }

  displaylocation() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                ' location: ',
              ),
            ),
            Expanded(
              flex: 7,
              child: dropdownop([
                'Al Aziziyah',
                'Al Badiah',
                'Al Bateha',
                'Al Daho',
                'Al Dhahirah',
                'Al Dubiyah',
                'Al Faisaliyyah',
                'Al Hamra',
                'Al Malazz',
                'Al Mansurah',
                'Al Marqab',
                'Al Murabba',
                'Al Nafal',
                'Al Olaya',
                'Al Oud',
                'Al Qiri',
                'Al Rabwah',
                'Al Salihiyah ',
                'Al Wizarat',
                'Al Wusaita',
                'Al Yamamah',
                'Al-Suwaidi',
                'Al-Urayja',
                'Diplomatic Quarter',
                'Al Dirah ',
                'Gabrah',
                'Ghubaira',
                'Al Khalidiyyah',
                'King Salman Park',
                'Manfuhah',
                'Manfuhah Al Jadidah',
                'Sinaiyah Qadeem',
                'Skirina',
                'Sports Boulevard',
                'Ulaysha',
                'Umm Sulaim',
                'Utayqah'
              ], hint: 'loc'),
            ),
            Expanded(
              flex: 2,
              child: 2.width,
            ),
          ],
        ),
      ],
    );
  }

  Future<List<String>> gettype() {
    return Future<List<String>>.value(['cat', 'dog ', 'bird', 'rabbit']);
  }

  Future<List<String>> getsize() {
    return Future<List<String>>.value(['small', 'medium ', 'large']);
  }

  displayCategory() {
    return Row(
      children: [
        2.width,
        Expanded(
            flex: 6,
            child: dropdownop(['cat', 'dog ', 'bird', 'rabbit'], hint: 'type')),
        5.width,
        Expanded(
            flex: 6,
            child: dropdownop(['small', 'medium ', 'large'], hint: 'size')),
        5.width,
      ],
    );
  }

  Widget dropdownop(List<String> mlist, {String? label, String? hint}) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        //  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w800),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black26),
          gapPadding: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black26),
          gapPadding: 16,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black26),
          gapPadding: 16,
        ),
      ),
      items: mlist.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if ('size' == hint) {
          myService.petsize = value;
          debugPrint('petsize ${myService.petsize}');
        } else if ('type' == hint) {
          myService.petType = value;
          debugPrint('petType ${myService.petType}');
        } else {
          myService.location = value;
          debugPrint('location ${myService.location}');
        }
      },
    );
  }

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }
}
