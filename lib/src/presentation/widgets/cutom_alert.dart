
import 'package:fitx/src/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../config/enums/enums.dart';

class CustomAlertBoxWithoutImage extends StatelessWidget {
  const CustomAlertBoxWithoutImage({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logout ?'),
        ],
      ),
      content:const Text('Are You Logout from admin app'),
      actions: [
        PrimartButtonWithoutIcon(
            screenHeight: screenHeight,
            category: ButtonCategory.cancelLogoutAdmin),
        PrimartButtonWithoutIcon(
            screenHeight: screenHeight,
            category: ButtonCategory.confirmLogoutAdmin)
      ],
    );
  }
}
