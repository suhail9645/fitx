import 'package:fitx/main.dart';
import 'package:fitx/src/presentation/views/image_screen/widget/alert_box.dart';
import 'package:fitx/src/presentation/views/image_screen/widget/image_container.dart';
import 'bloc/add_image_bloc.dart';
import 'image_screen.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    imageBloc.add(ImageInitialEvent());
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<AddImageBloc, AddImageState>(
              listener: (context, state) {
                if (state is AfterImageSavedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image successfully saved'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight / 3.5,
                          width: screenHeight / 2.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: state is! AfterImageState
                                    ? const NetworkImage(imageAddPageImage)
                                    : FileImage(state.image) as ImageProvider,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    spaceforHeight20,
                    state is! AfterImageState
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PrimartButtonWithoutIcon(
                                screenHeight: screenHeight,
                                category: ButtonCategory.add,
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PrimartButtonWithoutIcon(
                                screenHeight: screenHeight,
                                category: ButtonCategory.edit,
                              ),
                              PrimartButtonWithoutIcon(
                                screenHeight: screenHeight,
                                category: ButtonCategory.save,
                                image: state.image,
                              )
                            ],
                          ),
                  ],
                );
              },
            ),
            spaceforHeight20,
            BlocConsumer<ImageBloc, ImageState>(listener: (context, state) {
              if (state is SaveImageErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => const ImageAlert(),
                );
              } else if (state is DeleteImageSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('SuccessFully deleted the Image')));
              }
            }, builder: (context, state) {
              if (state is ImageInitialState) {
                return state.images.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) => ImageContainer(
                            screenHeight: screenHeight,
                            image: state.images[index],
                          ),
                          itemCount: state.images.length,
                        ),
                      )
                    : const Center(
                        child: Text('NO imges to show'),
                      );
              } else if (state is ImageLoadingState) {
                return const Column(
                  children: [Text('Please wait')],
                );
              }
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
