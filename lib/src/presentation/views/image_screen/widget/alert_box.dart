import 'package:flutter/material.dart';

import '../../login_screen/login.dart';

class ImageAlert extends StatelessWidget {
  const ImageAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('session Expired !'),
      content: const Text('Your session expired please login agin'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            },
            child: const Text('Login page'))
      ],
    );
  }
}
