import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:pet_home/OwnerHome/OwnerDashPage.dart';
import 'package:pet_home/SitterHome/SitterDashPage.dart';
import 'package:pet_home/Strings.dart';
import 'package:pet_home/StudentHome/StudentDashPage.dart';
import 'package:pet_home/VetHome/VetDashPage.dart';
import 'package:pet_home/onboarding/pet_sitting_page.dart';
import 'package:pet_home/OwnerHome/bottom_navigation_bar.dart';
import 'package:pet_home/SitterHome/bottom_navigation_bar.dart';
import 'package:pet_home/StudentHome/bottom_navigation_bar.dart';
import 'package:pet_home/VetHome/bottom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'ForgotPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth?.instance?.currentUser;
//print('is CURRENT USER NULL? '+ user.);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        nextScreen: PetSittingPage(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 350,
        duration: 2000,
      ),
      routes: <String, WidgetBuilder>{
        //'/JoinUs': (context) => JoinUs(),
        '/PetOwner': (context) => PetOwner(),
        '/PetSitter': (context) => PetSitter(),
        '/PetSitter2': (context) => PetSitter2(),
        '/PetSitter3': (context) => PetSitter3(),
        '/OwnerDashPage': (context) => OwnerProfilePage(),
        '/Student': (context) => Student(),
        '/Student2': (context) => Student2(),
        '/StudentDashPage': (context) => StudentProfilePage(),
        '/SitterDashPage': (context) => SitterProfilePage(),
        '/Vet': (context) => Vet(),
        '/Vet2': (context) => Vet2(),
        '/VetDashPage': (context) => VetProfilePage(),
        '/LoginSitter': (context) => LoginSitter(),
        '/LoginOwner': (context) => LoginOwner(),
        '/LoginStudent': (context) => LoginStudent(),
        '/LoginVet': (context) => LoginVet(),
        '/ForgotPassword': (context) => PasswordReset(),
        '/OwnerBottomNav': (context) => OwnerBottomNav(),
        '/SitterBottomNav': (context) => SitterBottomNav(),
        '/StudentBottomNav': (context) => StudentBottomNav(),
        '/VetBottomNav': (context) => VetBottomNav(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: Colors.amber[300],
              ),
              child: const Text("Join Us",
                  style: TextStyle(
                      fontSize: 25, color: Colors.black, height: 1.5)),
              onPressed: () {
                Navigator.pushNamed(context, '/JoinUs');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PetOwner extends StatefulWidget {
  @override
  State<PetOwner> createState() => _PetOwnerState();
}

class _PetOwnerState extends State<PetOwner> {
  TextEditingController _passwordTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();
  TextEditingController _NameTextContorller = TextEditingController();
  final database = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  bool agree = false;
  final user = FirebaseAuth?.instance?.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Userinfo = database.child('/Userinfo');
    String _password = '';
    String _confirmPassword = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'join us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regowner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 140),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            controller: _NameTextContorller,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Field is required.';
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              controller: _passwordTextContorller,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              onChanged: (value) {
                                _password = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter password ";
                                } else if (_passwordTextContorller.text.length <
                                    8) {
                                  return "password must be 8 charcters";
                                } else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return '''
                                          Password must be at least 8 characters,
                                          include an uppercase letter, number and symbol.
                                         ''';
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              onChanged: (value) {
                                _confirmPassword = value;
                              },
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Conform password is required please enter';
                                }
                                if (value != _password) {
                                  return 'Confirm password not matching';
                                }
                                return null;
                              }),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => const AlertDialog(
                                    title: Text('Password Requirements'),
                                    content: Text(
                                      "password must contain:\n"
                                      "- More Than 8 Characters.\n"
                                      "- Lower and Upper Case Letters.\n"
                                      "- Number and Special Character.\n",
                                    ),
                                  ));
                        },
                        child: const Text(
                          'Check Password Requirements Here!',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => const AlertDialog(
                                    title: Text('Digital Contract Agreement'),
                                    content: Text(
                                      "• Pet owners are legally confined to  pay the required service fees.\n\n"
                                      "• Pet Sitters and vets are  legally  confined to pay the required transaction fee, if your payment method fails or  your account past due we may place restrictions on your account \n\n"
                                      "• PetMe Up is clear of any responsibility regarding harm caused to pets.\n\n"
                                      "• You consent to the disclosure of certain personally identifiable information.\n\n",
                                    ),
                                  ));
                        },
                        child: const Text(
                          '☑ By clicking on "Register"  you are agreeing to the digital contract. click here to read',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.amber[300],
                    ),
                    child: const Text("Register",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black, height: 1.5)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  content: const Text(
                                      "Error, Email Already Exixts."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/PetOwner');
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
                      user?.sendEmailVerification();
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _EmailTextContorller.text,
                              password: _passwordTextContorller.text)
                          .then((value) {
                        print('REGISTRATION DONE ');
                        final userinfo = <String, dynamic>{
                          'UserType': petOwner,
                          'Name': _NameTextContorller.text,
                          'uid': value.user!.uid
                        };
                        database
                            .child('/Userinfo')
                            .child(value.user!.uid)
                            .set(userinfo);
                        firestore.collection("mail").add({
                          'to': _EmailTextContorller.text,
                          'message': {
                            'subject': "Account Successfully created",
                            'text':
                                "you have created an account successfully in PetMe Up mobile application"
                          }
                        });
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  content: const Text(
                                      "You have created a new account successfully"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/LoginOwner');
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
                      });
                    },

                    //isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 65),
                    const Text("Already Have An Account?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        primary: Colors.amber[300],
                      ),
                      child: const Text("Log In",
                          style: TextStyle(
                              fontSize: 16, color: Colors.black, height: 1.5)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/LoginOwner');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PetSitter extends StatefulWidget {
  @override
  State<PetSitter> createState() => _PetSitterState();
}

class _PetSitterState extends State<PetSitter> {
  TextEditingController _NameTextContorller = TextEditingController();

  TextEditingController _AgeTextContorller = TextEditingController();

  TextEditingController _EmailTextContorller = TextEditingController();

  TextEditingController _IDTextContorller = TextEditingController();

  TextEditingController _passwordTextContorller = TextEditingController();

  final database = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>();

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    String _password = '';
    String _confirmPassword = '';
    final Userinfo = database.child('/Userinfo');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'join us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regsitter.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 400,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    const SizedBox(height: 100),
                    Form(
                      key: _formKey,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                  controller: _NameTextContorller,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Field is required.';
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  controller: _AgeTextContorller,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field is required.';
                                    } else if (int.parse(value) < 16) {
                                      return 'Age must be above 15.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                      if (value!.isEmpty) {
                                        return 'Field is required';
                                      }
                                      if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                          .hasMatch(value)) {
                                        return "enter correct Email";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    controller: _IDTextContorller,
                                    decoration: const InputDecoration(
                                      labelText: 'National ID / Iqama',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.person_outline),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (_IDTextContorller.text.length <
                                              10 ||
                                          _IDTextContorller.text.length > 10) {
                                        return "ID must be 10 Numbers only";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    controller: _passwordTextContorller,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.password),
                                    ),
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (_passwordTextContorller
                                              .text.length <
                                          8) {
                                        return "password must be 8 characters";
                                      } else if (!RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(value)) {
                                        return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.lock),
                                    ),
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    onChanged: (value) {
                                      _confirmPassword = value;
                                    },
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Conform password is required please enter';
                                      }
                                      if (value != _password) {
                                        return 'Confirm password not matching';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          title: Text('Password Requirements'),
                                          content: Text(
                                            "password must contain:\n"
                                            "- More Than 8 Characters.\n"
                                            "- Lower and Upper Case Letters.\n"
                                            "- Number and Special Character.\n",
                                          ),
                                        ));
                              },
                              child: const Text(
                                'Check Password Requirements Here!',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          title: Text(
                                              'Digital Contract Agreement'),
                                          content: Text(
                                            "• Pet owners are legally confined to  pay the required service fees.\n\n"
                                            "• Pet Sitters and vets are  legally  confined to pay the required transaction fee, if your payment method fails or  your account past due we may place restrictions on your account \n\n"
                                            "• PetMe Up is clear of any responsibility regarding harm caused to pets.\n\n"
                                            "• You consent to the disclosure of certain personally identifiable information.\n\n",
                                          ),
                                        ));
                              },
                              child: const Text(
                                '☑ By clicking on "Register"  you are agreeing to the digital contract. click here to read',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Register",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                height: 1.5)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      content:
                                          const Text("Email already exists"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/PetSitter');
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
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _EmailTextContorller.text,
                                  password: _passwordTextContorller.text)
                              .then((value) {
                            final userinfo = <String, dynamic>{
                              'UserType': petSitter,
                              'Name': _NameTextContorller.text,
                              'Age': _AgeTextContorller.text,
                              'ID': _IDTextContorller.text,
                              'uid': value.user!.uid
                            };
                            database
                                .child('/Userinfo')
                                .child(value.user!.uid)
                                .set(userinfo);
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      content: const Text(
                                          "You have created a new account successfully"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginSitter()),
                                            );
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
                          });

                          //Navigator.pushNamed(context, '/PetSitter2');
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 65),
                        const Text("Already Have An Account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.amber[300],
                          ),
                          child: const Text("Log In",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  height: 1.5)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginSitter()),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetSitter2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text('join us'),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regsitter.png'),
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
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Skills',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Experience',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                  child: const Text("Next",
                      style: TextStyle(
                          fontSize: 25, color: Colors.black, height: 1.5)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/PetSitter3');
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

class PetSitter3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text('join us'),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/sitterquiz.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                //const Text('Register as a Pet Owner',
                //  textAlign: TextAlign.center ,
                // style: TextStyle(
                // fontSize:28,
                // fontWeight: FontWeight.bold,
                // color: Colors.black54,
                // ),
                // ),
                const SizedBox(height: 120),

                const SizedBox(height: 225),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.amber[300],
                    ),
                    child: const Text("Get Started",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black, height: 1.5)),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.amber[300],
                    ),
                    child: const Text("Register",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black, height: 1.5)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/SitterDashPage');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Student extends StatelessWidget {
  TextEditingController _NameTextContorller = TextEditingController();
  TextEditingController _AgeTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();
  TextEditingController _IDTextContorller = TextEditingController();
  TextEditingController _passwordTextContorller = TextEditingController();
  final database = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _password = '';
    String _confirmPassword = '';
    final Userinfo = database.child('/Userinfo');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'join us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regstudent.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 400,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    const SizedBox(height: 100),
                    Form(
                      key: _formKey,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                  controller: _NameTextContorller,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Field is required.';
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  controller: _AgeTextContorller,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field is required.';
                                    } else if (int.parse(value) < 16) {
                                      return 'Age must be above 15.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                      if (value!.isEmpty) {
                                        return 'Field is required';
                                      }
                                      if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                          .hasMatch(value)) {
                                        return "enter correct Email";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    controller: _IDTextContorller,
                                    decoration: const InputDecoration(
                                      labelText: 'National ID / Iqama',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.person_outline),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (_IDTextContorller.text.length <
                                              10 ||
                                          _IDTextContorller.text.length > 10) {
                                        return "ID must be 10 Numbers only";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    controller: _passwordTextContorller,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.password),
                                    ),
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (_passwordTextContorller
                                              .text.length <
                                          8) {
                                        return "password must be 8 characters";
                                      } else if (!RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(value)) {
                                        return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.lock),
                                    ),
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    onChanged: (value) {
                                      _confirmPassword = value;
                                    },
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Conform password is required please enter';
                                      }
                                      if (value != _password) {
                                        return 'Confirm password not matching';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          title: Text('Password Requirements'),
                                          content: Text(
                                            "password must contain:\n"
                                            "- More Than 8 Characters.\n"
                                            "- Lower and Upper Case Letters.\n"
                                            "- Number and Special Character.\n",
                                          ),
                                        ));
                              },
                              child: const Text(
                                'Check Password Requirements Here!',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          title: Text(
                                              'Digital Contract Agreement'),
                                          content: Text(
                                            "• Pet owners are legally confined to  pay the required service fees.\n\n"
                                            "• Pet Sitters and vets are  legally  confined to pay the required transaction fee, if your payment method fails or  your account past due we may place restrictions on your account \n\n"
                                            "• PetMe Up is clear of any responsibility regarding harm caused to pets.\n\n"
                                            "• You consent to the disclosure of certain personally identifiable information.\n\n",
                                          ),
                                        ));
                              },
                              child: const Text(
                                '☑ By clicking on "Register"  you are agreeing to the digital contract. click here to read',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Register",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                height: 1.5)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      content:
                                          const Text("Email already exists"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/PetSitter');
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
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _EmailTextContorller.text,
                                  password: _passwordTextContorller.text)
                              .then((value) {
                            final userinfo = <String, dynamic>{
                              'UserType': student,
                              'Name': _NameTextContorller.text,
                              'Age': _AgeTextContorller.text,
                              'ID': _IDTextContorller.text,
                              'uid': value.user!.uid
                            };
                            database
                                .child('/Userinfo')
                                .child(value.user!.uid)
                                .set(userinfo);
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      content: const Text(
                                          "You have created a new account successfully"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/LoginStudent');
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
                          });

                          //Navigator.pushNamed(context, '/PetSitter2');
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 65),
                        const Text("Already Have An Account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.amber[300],
                          ),
                          child: const Text("Log In",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  height: 1.5)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/LoginStudent');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text('join us'),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regstudent.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                //const Text('Register as a Pet Owner',
                //  textAlign: TextAlign.center ,
                // style: TextStyle(
                // fontSize:28,
                // fontWeight: FontWeight.bold,
                // color: Colors.black54,
                // ),
                // ),
                const SizedBox(height: 120),
                Form(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Skills',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Experience',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                  child: const Text("Register",
                      style: TextStyle(
                          fontSize: 25, color: Colors.black, height: 1.5)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/StudentDashPage');
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

class Vet extends StatelessWidget {
  TextEditingController _NameTextContorller = TextEditingController();
  TextEditingController _AgeTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();
  TextEditingController _IDTextContorller = TextEditingController();
  TextEditingController _passwordTextContorller = TextEditingController();
  final database = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _password = '';
    String _confirmPassword = '';
    final Userinfo = database.child('/Userinfo');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'join us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regvet.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 400,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    const SizedBox(height: 100),
                    Form(
                      key: _formKey,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                  controller: _NameTextContorller,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Field is required.';
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  controller: _AgeTextContorller,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field is required.';
                                    } else if (int.parse(value) < 16) {
                                      return 'Age must be above 15.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                      if (value!.isEmpty) {
                                        return 'Field is required';
                                      }
                                      if (!RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                          .hasMatch(value)) {
                                        return "enter correct Email";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    controller: _IDTextContorller,
                                    decoration: const InputDecoration(
                                      labelText: 'National ID / Iqama',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.person_outline),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (_IDTextContorller.text.length <
                                              10 ||
                                          _IDTextContorller.text.length > 10) {
                                        return "ID must be 10 Numbers only";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    controller: _passwordTextContorller,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.password),
                                    ),
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field is required";
                                      } else if (_passwordTextContorller
                                              .text.length <
                                          8) {
                                        return "password must be 8 characters";
                                      } else if (!RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(value)) {
                                        return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: 330,
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.lock),
                                    ),
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    onChanged: (value) {
                                      _confirmPassword = value;
                                    },
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Conform password is required please enter';
                                      }
                                      if (value != _password) {
                                        return 'Confirm password not matching';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          title: Text('Password Requirements'),
                                          content: Text(
                                            "password must contain:\n"
                                            "- More Than 8 Characters.\n"
                                            "- Lower and Upper Case Letters.\n"
                                            "- Number and Special Character.\n",
                                          ),
                                        ));
                              },
                              child: const Text(
                                'Check Password Requirements Here!',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          title: Text(
                                              'Digital Contract Agreement'),
                                          content: Text(
                                            "• Pet owners are legally confined to  pay the required service fees.\n\n"
                                            "• Pet Sitters and vets are  legally  confined to pay the required transaction fee, if your payment method fails or  your account past due we may place restrictions on your account \n\n"
                                            "• PetMe Up is clear of any responsibility regarding harm caused to pets.\n\n"
                                            "• You consent to the disclosure of certain personally identifiable information.\n\n",
                                          ),
                                        ));
                              },
                              child: const Text(
                                '☑ By clicking on "Register"  you are agreeing to the digital contract. click here to read',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: Colors.amber[300],
                        ),
                        child: const Text("Register",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                height: 1.5)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      content:
                                          const Text("Email already exists"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/PetSitter');
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
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _EmailTextContorller.text,
                                  password: _passwordTextContorller.text)
                              .then((value) {
                            final userinfo = <String, dynamic>{
                              'UserType': vet,
                              'Name': _NameTextContorller.text,
                              'Age': _AgeTextContorller.text,
                              'ID': _IDTextContorller.text,
                              'uid': value.user!.uid
                            };
                            database
                                .child('/Userinfo')
                                .child(value.user!.uid)
                                .set(userinfo);
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      content: const Text(
                                          "You have created a new account successfully"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/LoginVet');
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
                          });

                          //Navigator.pushNamed(context, '/PetSitter2');
                        },
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 65),
                        const Text("Already Have An Account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.amber[300],
                          ),
                          child: const Text("Log In",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  height: 1.5)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/LoginVet');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Vet2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text('join us'),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/regvet.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                //const Text('Register as a Pet Owner',
                //  textAlign: TextAlign.center ,
                // style: TextStyle(
                // fontSize:28,
                // fontWeight: FontWeight.bold,
                // color: Colors.black54,
                // ),
                // ),
                const SizedBox(height: 120),
                Form(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'profession license number',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'veterinary health card number',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person_outline),
                            ),
                          ),
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
                  child: const Text("Next",
                      style: TextStyle(
                          fontSize: 25, color: Colors.black, height: 1.5)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/VetDashPage');
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

class LoginOwner extends StatelessWidget {
  TextEditingController _passwordTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: Text('Log In'),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login.png'),
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
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              controller: _passwordTextContorller,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.password),
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter password Email";
                                } else if (_passwordTextContorller.text.length <
                                    8) {
                                  return "password must be 8 charcters";
                                } else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ForgotPassword');
                        },
                        child: const Text(
                          'Forgot Password? Click Here!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
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
                  child: const Text("Log In",
                      style: TextStyle(
                          fontSize: 25, color: Colors.black, height: 1.5)),
                  onPressed: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _EmailTextContorller.text,
                            password: _passwordTextContorller.text)
                        .then((value) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          content: const Text("You have Loged In successfully"),
                          actions: <Widget>[
                            GestureDetector(
                              onTap: () {
                                String message = _EmailTextContorller.text;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OwnerBottomNav(),
                                      settings:
                                          RouteSettings(arguments: message)),
                                );
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
                    }).onError((error, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          content: const Text(
                              "incorrect password or Email please try again"),
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

class LoginSitter extends StatelessWidget {
  TextEditingController _passwordTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'Log In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login.png'),
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
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              controller: _passwordTextContorller,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.password),
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter password";
                                } else if (_passwordTextContorller.text.length <
                                    8) {
                                  return "password must be 8 charcters";
                                } else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ForgotPassword');
                        },
                        child: const Text(
                          'Forgot Password? Click Here!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.amber[300],
                    ),
                    child: const Text("Log In",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black, height: 1.5)),
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _EmailTextContorller.text,
                              password: _passwordTextContorller.text)
                          .then((value) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content:
                                const Text("You have Loged In successfully"),
                            actions: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  String message = _EmailTextContorller.text;
                                  print('GO TO PET SITTER SCREENS');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SitterBottomNav(),
                                        settings:
                                            RouteSettings(arguments: message)),
                                  );
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
                      }).onError((error, stackTrace) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: const Text(
                                "incorrect password or Email please try again"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/LoginSitter');
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
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginStudent extends StatelessWidget {
  TextEditingController _passwordTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'Log In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login.png'),
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
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              controller: _passwordTextContorller,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.password),
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter password";
                                } else if (_passwordTextContorller.text.length <
                                    8) {
                                  return "password must be 8 charcters";
                                } else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ForgotPassword');
                        },
                        child: const Text(
                          'Forgot Password? Click Here!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.amber[300],
                    ),
                    child: const Text("Log In",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black, height: 1.5)),
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _EmailTextContorller.text,
                              password: _passwordTextContorller.text)
                          .then((value) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content:
                                const Text("You have Loged In successfully"),
                            actions: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  String message = _EmailTextContorller.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StudentBottomNav(),
                                        settings:
                                            RouteSettings(arguments: message)),
                                  );
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
                      }).onError((error, stackTrace) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: const Text(
                                "incorrect password or Email please try again"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/LoginStudent');
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
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginVet extends StatelessWidget {
  TextEditingController _passwordTextContorller = TextEditingController();
  TextEditingController _EmailTextContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3f60a0),
        title: const Text(
          'Log In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login.png'),
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
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 330,
                          child: TextFormField(
                              controller: _passwordTextContorller,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.password),
                              ),
                              obscureText: true,
                              obscuringCharacter: "*",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter password";
                                } else if (_passwordTextContorller.text.length <
                                    8) {
                                  return "password must be 8 charcters";
                                } else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return "password must contain: Number, Special Character, Upper and Lower Case Letters ";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ForgotPassword');
                        },
                        child: const Text(
                          'Forgot Password? Click Here!',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.amber[300],
                    ),
                    child: const Text("Log In",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black, height: 1.5)),
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _EmailTextContorller.text,
                              password: _passwordTextContorller.text)
                          .then((value) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content:
                                const Text("You have Loged In successfully"),
                            actions: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  String message = _EmailTextContorller.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VetBottomNav(),
                                        settings:
                                            RouteSettings(arguments: message)),
                                  );
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
                      }).onError((error, stackTrace) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            content: const Text(
                                "incorrect password or Email please try again"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/LoginVet');
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
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
