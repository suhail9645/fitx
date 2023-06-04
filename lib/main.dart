import 'package:fitx/src/presentation/views/home_screen/cubit/home_cubit.dart';
import 'package:fitx/src/presentation/views/image_screen/bloc/image_bloc.dart';
import 'package:fitx/src/presentation/views/login_screen/bloc/login_bloc.dart';
import 'package:fitx/src/presentation/views/login_screen/login.dart';
import 'package:fitx/src/presentation/views/splash_screen/bloc/splash_bloc.dart';
import 'package:fitx/src/presentation/views/splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

LoginBloc loginBloc = LoginBloc();
SplashBloc splashBloc = SplashBloc();
HomeCubit homeCubit = HomeCubit();
ImageBloc imageBloc=ImageBloc();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => loginBloc),
        BlocProvider(
          create: (context) => splashBloc,
        ),
        BlocProvider<HomeCubit>(
          create: (context) => homeCubit,
        ),
        BlocProvider(
          create: (context) => imageBloc,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitx',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
