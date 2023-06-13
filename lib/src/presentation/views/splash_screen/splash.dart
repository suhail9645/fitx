import 'package:fitx/src/presentation/views/login_screen/login.dart';
import 'package:fitx/src/presentation/views/login_screen/login_screen.dart';
import 'package:fitx/src/presentation/views/splash_screen/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    splashBloc.add(SplashInitialEvent());
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is AdminLoginState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
        } else if (state is AdminLogoutState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        }
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(splashScreenImage), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: screenHeight / 1.2,
            left: screenWidth / 6.1,
            child: SizedBox(
              height: screenHeight / 14,
              width: screenWidth / 1.2,
              child: Row(
                children: [
                  AppLogo(screenHeight: screenHeight),
                  spaceforwidth10,
                  const Column(
                    children: [
                      Text(
                        'ENERGY & PERSISTENCE\nCONQUER ALL THINGS',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
