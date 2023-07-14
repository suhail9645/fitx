import 'package:fitx/src/config/constants/lists.dart';
import 'package:fitx/src/config/enums/enums.dart';
import 'package:fitx/src/domain/model/trainer_list/result.dart';
import 'package:fitx/src/presentation/views/login_screen/login_screen.dart';
import 'package:fitx/src/presentation/views/trainer_screen/trainer.dart';
import 'package:fitx/src/presentation/widgets/primary_button.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key, required this.trainer});
  final Result trainer;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenHeight / 12,
                    child: CircleAvatar(
                      radius: screenHeight / 14,
                      backgroundImage:
                          NetworkImage(trainer.user!.profilePicture!),
                    ),
                  )
                ],
              ),
              Column(
                  children: List.generate(trainerDetailes.length, (index) {
                List<String> detailesValue = [
                  trainer.user!.name!,
                  trainer.user!.dateOfBirth!,
                  trainer.user!.gender!,
                  trainer.experience!,
                  trainer.phone!,
                  trainer.user!.email!
                ];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
                  child: Container(
                    height: screenHeight / 13,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 222, 65, 211),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${trainerDetailes[index]}:',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 62, 49, 49),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        Text(detailesValue[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17))
                      ],
                    ),
                  ),
                );
              })),
              const Text('Cirtificates'),
              Container(
                padding: const EdgeInsets.all(10),
                height: screenHeight * 0.21,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      trainer.certificates!.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: screenHeight * 0.14,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(trainer.certificates![index].file!)),
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                        );
                      },
                    ),
                  ),
                ),
              ),
              spaceforHeight20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TrainerElevatedButton(color: Colors.green, height: 40,width: 130, onTap: () {
                  
                }, text:'Accept Trainer'),
                 TrainerElevatedButton(color: Colors.red,height: 40,width: 130, onTap: () {
              
            }, text:'Reject Trainer')
              ],
            ),
              spaceforHeight20,
            ],
          ),
        ),
      ),
    );
  }
}
