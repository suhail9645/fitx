import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/presentation/views/home_screen/cubit/home_cubit.dart';
import 'package:fitx/src/presentation/views/login_screen/login_screen.dart';
import '../admin_profil/admin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final indexState = state as HomeInitial;

        return Scaffold(
          appBar: AppBar(
            title: Text(pagesNames[indexState.index]),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AdminProfile(),
                    ));
                  },
                  icon: const Icon(
                    Icons.manage_accounts_rounded,
                    size: 30,
                  ))
            ],
          ),
          body: pagesList[indexState.index],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                homeCubit.onTapFunctionOfBottemNavigationBar(value);
              },
              currentIndex: indexState.index,
              backgroundColor: const Color.fromARGB(255, 39, 36, 37),
              selectedItemColor: primaryColor,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.image), label: 'Image'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.lock_clock), label: 'Exercise'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.theater_comedy_sharp), label: 'Trainer')
              ]),
        );
      },
    );
  }
}
