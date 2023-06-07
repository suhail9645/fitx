import 'package:fitx/src/presentation/views/login_screen/login_screen.dart';
import 'package:fitx/src/presentation/views/message_screen/message.dart';
import 'package:flutter/material.dart';
import '../trainer_profile_screen/trainer_profile.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MessageScreen(),
            ));
          },
          leading: const CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(
                'https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg'),
          ),
          title: Text('Trainer $index'),
          subtitle: Text(
            DateTime.now().toString(),
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TrainerProfileScreen(),
              ));
            },
            child: const Icon(
              Icons.info,
              size: 30,
              color: Color.fromARGB(255, 241, 95, 139),
            ),
          ),
        ),
      )),
    );
  }
}
