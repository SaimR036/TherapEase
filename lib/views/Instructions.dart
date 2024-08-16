import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
class Instructions extends StatefulWidget {
  const Instructions({super.key});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter, // Gradient starting point
            end: Alignment.bottomCenter, // Gradient ending point
            colors: [
            Color(0xFF05696A), // First hex color (Blue)
            Color(0xFF29BDBD), // Second hex color (Red)
            ],
            ),
            ),
            ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.fromLTRB(width*0.2,height*0.10,width*0.2,0),
              child: Text('You have the option to run a psychological test for yourself. This test will give us a better understanding of your psychological needs.\n\nWould you like to take this test now?',
              style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize:26 ),
              ),),
          ),
          Align(
            alignment: Alignment.topCenter,
            child:
          Container(
            width: width*0.6,
            height: height*0.05,
            margin: EdgeInsets.fromLTRB(width*0.2, height*0.65,width*0.2,0),
            decoration: BoxDecoration(color: Color(0xFF0B6E6F),
            borderRadius: BorderRadius.circular(10)
            ),
            child: TextButton(
            onPressed: (){},
            
            child: Text('Yes, take test',
            style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize:20 ),
            )),)),
            Container(
            width: width*0.6,
            height: height*0.05,
            margin: EdgeInsets.fromLTRB(width*0.2, height*0.75,width*0.2,0),
            decoration: BoxDecoration(color: Color(0xFF0B6E6F),
            borderRadius: BorderRadius.circular(10)
            ),
            child: TextButton(
            onPressed: (){},
            
            child: Text('Not now, explore app',
            style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize:20 ),
            )),)

]));
  }
}