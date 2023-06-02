import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
     Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Scaffold(
      
    body: ListView(children: [
       CustomPaint(
  painter: RPSCustomPainter(),
  size: Size(double.infinity,screenHeight/2),
),
    ]),
    );
  }
}
class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
     
         
    Path path0 = Path();
    path0.moveTo(size.width*0.4296034,size.height*0.2487145);
    path0.lineTo(size.width*0.4293103,size.height*0.6580963);
    path0.lineTo(size.width*0.6439655,size.height*0.4956236);
    path0.lineTo(size.width*0.6433793,size.height*0.2463184);
    path0.lineTo(size.width*0.4296034,size.height*0.2487145);
    path0.close();

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

