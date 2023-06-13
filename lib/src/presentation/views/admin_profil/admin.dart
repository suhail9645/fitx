import 'package:fitx/src/config/enums/enums.dart';
import 'package:fitx/src/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: PrimartButtonWithoutIcon(
            screenHeight: screenHeight, category: ButtonCategory.logoutAdmin),
      )),
    );
  }
}
