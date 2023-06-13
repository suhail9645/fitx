import 'package:fitx/src/config/enums/enums.dart';
import 'package:fitx/src/domain/model/image/image.dart';
import 'package:fitx/src/presentation/widgets/alert_box.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.image,
    required this.screenHeight,
  });
  final ImageModel image;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => CustomAlertBox(
              screenHeight: screenHeight,
              category: ButtonCategory.deleteImage,
              image: image,
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(image.image ?? ''), fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
