import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Tawk(
      directChatLink: 'https://tawk.to/chat/63d76ec0c2f1ac1e203049e1/1go0oh8ps',
      visitor: TawkVisitor(name: 'PetMe Up Team', email: ''),
    ));
  }
}
