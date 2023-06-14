import 'package:fitx/main.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_page.dart';
import 'package:fitx/src/presentation/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../config/constants/sized_box.dart';
import '../../../config/enums/enums.dart';
import '../../widgets/alert_box.dart';
import '../../widgets/primary_button.dart';
import 'bloc/category_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    categoryBloc.add(CategoryInitialEvent());
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            spaceforHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimartButtonWithoutIcon(
                  screenHeight: screenHeight,
                  category: ButtonCategory.addCategory,
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoryAddPage(
                          type: CategoryAddOrEdit.categoryAdd),
                    ));
                  },
                )
              ],
            ),
            spaceforHeight20,
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CategoryTile(screenHeight: screenHeight)),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryDeleteSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(contant: 'deleted successfully'));
        }
      },
      builder: (context, state) {
        if (state is CategorySuccessState) {
          return Column(
            children: List.generate(
              state.categories.length,
              (index) => Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertBox(
                            screenHeight: screenHeight,
                            category: ButtonCategory.deletCategory,
                            categoryModel: state.categories[index],
                            ontap: () {
                              categoryBloc.add(CategoryDeleteEvent(
                                  id: state.categories[index].id!));
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryAddPage(
                            type: CategoryAddOrEdit.categoryEdit,
                            category: state.categories[index],
                          ),
                        ));
                      },
                      backgroundColor: const Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight / 4.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(state.categories[index].image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceforHeight20,
                          Text(
                            state.categories[index].name!,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${state.categories[index].exercisesCount} Workouts',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is CategoryLoadingState) {
          return const Center(
            child: Text('Please wait'),
          );
        } else if (state is CategoryErrorState) {
          return Center(
            child: Column(
              children: [
                const Text('Something wrong please try again'),
                ElevatedButton(onPressed: () {}, child: const Text('try again'))
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
