import 'package:fitx/src/domain/model/category/category.dart';
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:fitx/src/domain/model/image/image.dart';
import 'package:fitx/src/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../config/constants/sized_box.dart';
import '../../config/enums/enums.dart';

class CustomAlertBox extends StatelessWidget {
  const CustomAlertBox({
    super.key,
    required this.screenHeight,
    this.image,
    required this.category,
    this.exercise,
    this.categoryModel,
    this.ontap,
    required this.content,
  });
  final ButtonCategory category;
  final double screenHeight;
  final ImageModel? image;
  final Exercise? exercise;
  final CategoryModel? categoryModel;
  final Function? ontap;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 10, 9, 9),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7))),
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        height: screenHeight / 2.7,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                        topStart: Radius.circular(7),
                        topEnd: Radius.circular(7)),
                    image: DecorationImage(
                      image: NetworkImage(
                        image?.image ??
                            exercise?.demo ??
                            categoryModel?.image ??
                            'https://manofmany.com/wp-content/uploads/2021/07/No-Equipment-Home-Workout-2.jpg',
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstOut),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, top: screenHeight / 7),
                  child: SizedBox(
                    height: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delete ?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Are you sure to delete this $content?',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 232, 240, 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceforHeight10,
            PrimartButtonWithoutIcon(
              screenHeight: screenHeight,
              category: category,
              id: image?.id ?? exercise?.id ?? categoryModel?.id,
              ontap: ontap,
            ),
            spaceforHeight10,
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }
}
