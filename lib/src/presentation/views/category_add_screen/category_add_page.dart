import 'package:fitx/src/presentation/views/category_screen/category.dart';

import 'category_add_barell.dart';

enum CategoryAddOrEdit { categoryAdd, categoryEdit }

// ignore: must_be_immutable
class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({super.key, required this.type, this.category});
  final CategoryAddOrEdit type;
  final CategoryModel? category;

  @override
  State<CategoryAddPage> createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  List<int> listId = [];
  final _formKey = GlobalKey<FormState>();
  File? music;
  File? image;

  @override
  void initState() {
    if (widget.type == CategoryAddOrEdit.categoryEdit) {
      categoryAddPageTextEditingControllers[0].text = widget.category!.name!;
      categoryAddPageTextEditingControllers[1].text =
          widget.category!.description!;
      categoryAddPageTextEditingControllers[2].text =
          widget.category!.music!.split('/').last;
      for (var element in widget.category!.exercises!) {
        listId.add(element.id!);
      }
    }
    super.initState();
  }

  // File? image;

  // File? image;

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
                    if (state is AddImageState) {
                      image = state.image;
                    }
                    return Container(
                      height: screenHeight / 3.5,
                      width: screenHeight / 2.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: state is! AddImageState
                                ? NetworkImage(
                                    widget.category?.image ?? imageAddPageImage)
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
              key: _formKey,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        music = await Mp3PickerOperations.mp3Picker(context);
                        if (music != null) {
                          categoryAddPageTextEditingControllers.last.text =
                              music!.path.split('/').last;
                        }
                      },
                      child: const Text('Add Music'))
                ],
              ),
            ),
            const Text('Exercices'),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: CategoryAddPageExercises(listId: listId),
              ),
            ),
            spaceforHeight20,
            BlocListener<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryAddedSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(contant: 'new category added '));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CategoryPage(),
                  ));
                }
              },
              child: PrimartButtonWithoutIcon(
                screenHeight: screenHeight,
                category: ButtonCategory.saveCategory,
                formKey: _formKey,
                ontap: () {
                  if (_formKey.currentState!.validate() &&
                      music != null &&
                      image != null) {
                    categoryBloc.add(CategoryAddEvent(
                        image: image!,
                        music: music!,
                        controllers: categoryAddPageTextEditingControllers,
                        exerciseid: listId));
                  } else if (music == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(contant: 'Please add a music file'));
                  } else if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(contant: 'Please add a image file'));
                  }
                },
              ),
            ),
            spaceforHeight20,
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    categoryaddBloc.add(CategoryAddPagePopEvent());
    super.dispose();
  }
}
