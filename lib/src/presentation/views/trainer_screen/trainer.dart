import 'package:fitx/src/domain/model/trainer_list/result.dart';
import 'package:fitx/src/presentation/views/login_screen/login_screen.dart';
import 'package:fitx/src/presentation/views/message_screen/message.dart';
import '../trainer_profile_screen/trainer_profile.dart';
import 'bloc/trainer_bloc.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // trainerBloc.add(TrainerInitialEvent());
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<TrainerBloc, TrainerState>(
        listener: (context, state) {
          if (state is TrainerFetchErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is TrainerFetchSuccessState) {
            return ListView.builder(
                itemCount: state.allApplication.length,
                itemBuilder: (context, index) {
                  Result trainer = state.allApplication[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MessageScreen(),
                      ));
                    },
                    leading: CircleAvatar(
                      radius: 36,
                      backgroundImage:
                          NetworkImage(trainer.user!.profilePicture!),
                    ),
                    title: Text(trainer.user!.username!),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TrainerElevatedButton(color: Colors.green,text: 'Accept', height: 30,onTap: () {
                         
                       },),
                       TrainerElevatedButton(color: Colors.red,text: 'Reject', height: 30,onTap: () {
                         
                       },),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  TrainerProfileScreen(trainer: trainer,),
                        ));
                      },
                      child: const Icon(
                        Icons.info,
                        size: 30,
                        color: Color.fromARGB(255, 241, 95, 139),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}

class TrainerElevatedButton extends StatelessWidget {
  const TrainerElevatedButton({
    super.key, required this.height, this.width, required this.onTap,required this.text,required this.color
  });
final double height;
final double?width;
final Function()onTap;
final String text;
final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: height,
       width: width,
       child: ElevatedButton(
         style:  ButtonStyle(
             padding:const MaterialStatePropertyAll(
                 EdgeInsets.symmetric(horizontal: 8)),
             backgroundColor:
                 MaterialStatePropertyAll(color)),
         onPressed:onTap,
         child:  Text(text,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
       ),
     );
  }
}
