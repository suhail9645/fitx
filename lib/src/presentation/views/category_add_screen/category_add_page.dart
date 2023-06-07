import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/config/constants/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/strings.dart';
import '../../../config/enums/enums.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/textFormField.dart';
import 'bloc/categoryadd_bloc.dart';

class CategoryAddPage extends StatelessWidget {
   CategoryAddPage({super.key});
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            spaceforHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<CategoryaddBloc, CategoryaddState>(
                  builder: (context, state) {
                    return Container(
                      height: screenHeight / 3.5,
                      width: screenHeight / 2.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: state is! AddImageState
                                ? const NetworkImage(imageAddPageImage)
                                : FileImage(state.image) as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ],
            ),
            spaceforHeight10,
            PrimartButtonWithoutIcon(
                screenHeight: screenHeight,
                category: ButtonCategory.addCategoryImage),
            spaceforHeight10,
            Form(
              key:_formKey ,
              child: Column(
                children: List.generate(
                  categoryAddPageTextEditingControllerHint.length,
                  (index) => CustomTextFormField(
                      controller: categoryAddPageTextEditingControllers[index],
                      hint: categoryAddPageTextEditingControllerHint[index],
                      obscureText: false),
                ),
              ),
            ),
            const Text('Exercices'),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                          colors: [Colors.white, Colors.grey]),
                      borderRadius: BorderRadius.circular(4),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://media.giphy.com/media/J47Vkh2p67L0ufw0Re/giphy.gif'),
                          fit: BoxFit.fill),
                    ),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.check_box_outline_blank),
                    ),
                  ),
                ),
              ),
            ),
            spaceforHeight20,
            PrimartButtonWithoutIcon(
                screenHeight: screenHeight,
                category: ButtonCategory.saveCategory,formKey: _formKey,),
            spaceforHeight20,
          ],
        ),
      )),
    );
  }
}
