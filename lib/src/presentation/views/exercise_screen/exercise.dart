import 'package:fitx/src/config/constants/colors.dart';
import 'package:fitx/src/presentation/views/exercice_add_screen/execice_add.dart';
import 'package:flutter/material.dart';

class ExercisScreen extends StatelessWidget {
  const ExercisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            tileColor: const Color.fromARGB(255, 62, 58, 60),
            leading: Container(
              width: screenHeight / 10,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://media.giphy.com/media/J47Vkh2p67L0ufw0Re/giphy.gif'),
                    fit: BoxFit.fill),
              ),
            ),
            title: const Text('Jumping Jacks',
                style: TextStyle(
                    fontSize: 15,
                    color: primaryColor,
                    fontWeight: FontWeight.bold)),
            subtitle: const Text(
              'Created on 01/9/2030',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            trailing:const Padding(
              padding:  EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerButton(buttonType: ContainerButtonType.exerciseDelete,),
                  ContainerButton(buttonType: ContainerButtonType.exerciseEdit,)
                ],
              ),
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(backgroundColor: primaryColor, onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExerciceAddPage(),));
      },child:const Icon(Icons.add,color: Colors.black,),
      ),
    );
  }
}
enum ContainerButtonType{exerciseDelete,exerciseEdit}

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key, required this.buttonType,
  });
  final ContainerButtonType buttonType;
  @override
  Widget build(BuildContext context) {
    String text='';
    Color color=primaryColor;
    if(buttonType==ContainerButtonType.exerciseDelete){
      text='Delete';
      color=Colors.red;
    }else  if(buttonType==ContainerButtonType.exerciseEdit){
      text='Edit';
      color=Colors.blue;
    }
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        height: 20,
        width: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color:color,
        ),
        child:  Text(
          text,
          textAlign: TextAlign.center,
          style:const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
