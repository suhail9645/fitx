import 'package:http/http.dart' as http;

import 'dart:convert';

import 'login_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 25, 25),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight / 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(loginPageImage), fit: BoxFit.cover)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32, left: 20),
                        child: SizedBox(
                            height: screenHeight / 13,
                            width: screenHeight / 7,
                            child: const Column(
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 3,
                                  indent: 28,
                                  endIndent: 28,
                                  height: 2,
                                  color: primaryColor,
                                )
                              ],
                            )),
                      ),
                      const Spacer(),
                      AppLogo(screenHeight: screenHeight),
                      spaceforwidth10
                    ],
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Hello Admin',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 13,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 5.9),
              child: CustomPaint(
                size: Size(double.maxFinite, screenHeight / 3),
                painter: RPSCustomPainter(),
              ),
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: userName,
                hint: 'Username',
                obscureText: false,
              ),
              CustomTextFormField(
                controller: password,
                hint: 'Password',
                obscureText: true,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('error')));
                } else if (state is LoginSuccessState) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                }
              },
              builder: (context, state) {
                return ElevatedButton.icon(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(primaryColor)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      loginBloc.add(LoginButtonClicked(userName: userName.text, password: password.text));
                    }
                  },
                  icon: Text(
                    state is! LoginLoadingState ? 'Login' : 'Wait',
                    style: const TextStyle(fontSize: 20),
                  ),
                  label: state is! LoginLoadingState
                      ? const Icon(
                          Icons.arrow_right,
                        )
                      : const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          )),
                );
              },
            ),
          ],
        )
      ]),
    );
  }
}
