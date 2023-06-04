
import 'image_screen.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<ImageBloc, ImageState>(
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
                                  image: state is! AddImageState
                                      ? const NetworkImage(imageAddPageImage)
                                      : FileImage(state.image) as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                    spaceforHeight20,
                 state is !AddImageState?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PrimartButtonWithoutIcon(
                          screenHeight: screenHeight,
                            category: ButtonCategory.add,
                        )
                      ],
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PrimartButtonWithoutIcon(
                          screenHeight: screenHeight,
                            category: ButtonCategory.edit,
                        ),
                        PrimartButtonWithoutIcon(
                          screenHeight: screenHeight,
                          category: ButtonCategory.save,
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
            spaceforHeight20,
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => const ImageContainer(),
                itemCount: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onLongPress: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://64.media.tumblr.com/e084702f3a1abb5675630e1e2e3c1151/5ec1554e06e45f0c-8f/s1280x1920/06185e92001e5fa03d57efdfc80ffb3735356026.png'))),
        ),
      ),
    );
  }
}
