import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
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
              margin: EdgeInsets.fromLTRB(width*0.1,height*0.10,width*0.07,0),
              child: Text.rich( // Use Text.rich to style parts of the text differently
      TextSpan(
        children: [
          TextSpan(
            text: 'You have the option to run a psychological test for yourself. This test will give you a better understanding of your psychological needs. Please select the most appropriate answer that applied to you ',
            style: TextStyle(fontFamily: 'Font', color: Colors.white, fontSize: 20),
          ),
          TextSpan(
            text: 'over the past week',
            style: TextStyle(
              fontFamily: 'Font',
              color: Colors.black, // Set text color to black
              fontSize: 20,
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          TextSpan(
            text: '. There are no right or wrong answers. Do not spend too much time on any statement.\n\nWould you like to take this test now? ',
            style: TextStyle(fontFamily: 'Font', color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    ),),
          ),
          Align(
            alignment: Alignment.topCenter,
            child:
          Container(
            width: width*0.6,
            height: height*0.05,
            margin: EdgeInsets.fromLTRB(width*0.2, height*0.7,width*0.2,0),
            decoration: BoxDecoration(color: Color(0xFF0B6E6F),
            borderRadius: BorderRadius.circular(10)
            ),
            child: TextButton(
            onPressed: (){
            var navbar_provider = Provider.of<BottomNavbarProvider>(context,listen: false);
            navbar_provider.toggleIndex(3);
              Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: BottomNavbar(),
    ));
            },
            child: Text('Yes, take test',
            style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize:20 ),
            )),)),
            Container(
            width: width*0.6,
            height: height*0.05,
            margin: EdgeInsets.fromLTRB(width*0.2, height*0.79,width*0.2,0),
            decoration: BoxDecoration(color: Color(0xFF0B6E6F),
            borderRadius: BorderRadius.circular(10)
            ),
            child: TextButton(
            onPressed: (){
              var navbar_provider = Provider.of<BottomNavbarProvider>(context);
            navbar_provider.toggleIndex(2);
              Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: BottomNavbar(),
    ));

            },
            
            child: Text('Not now, explore app',
            style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize:20 ),
            )),)

]));
  }
}