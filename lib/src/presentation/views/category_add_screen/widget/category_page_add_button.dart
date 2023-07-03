
import '../category_add_barell.dart';

class CategoryAddButton extends StatelessWidget {
  const CategoryAddButton({
    super.key,
    required this.screenHeight,
    required GlobalKey<FormState> formKey,
    required this.music,
    required this.image,
    required this.listId,
    required this.widget,
  }) : _formKey = formKey;

  final double screenHeight;
  final GlobalKey<FormState> _formKey;
  final File? music;
  final File? image;
  final List<int> listId;
  final CategoryAddPage widget;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryAddedSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(contant: 'new category added '));
        }else if(state is CategoryUpdateSuccessState){
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(contant: 'category updated'));
          Navigator.of(context).pop();
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
          } else if (_formKey.currentState!.validate() &&
              widget.type == CategoryAddOrEdit.categoryEdit) {
            categoryBloc.add(CategoryEditEvent(
                image: image,
                music: music,
                controllers: categoryAddPageTextEditingControllers,
                exerciseid: listId,
                id: widget.category!.id!));
          } else if (music == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(contant: 'Please add a music file'));
          } else if (image == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(contant: 'Please add a image file'));
          }
        },
      ),
    );
  }
}
