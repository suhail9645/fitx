import 'package:flutter/material.dart';

import '../../../config/constants/colors.dart';
import '../../../config/constants/sized_box.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Trainer 1'),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://leadership.ng/wp-content/uploads/2023/03/davido.png'),
          ),
          spaceforwidth10
        ],
      ),
      body: const SafeArea(
          child: Center(
        child: Text('MessageScreen'),
      )),
    );
  }
}
