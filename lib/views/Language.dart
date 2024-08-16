import 'dart:ui';
import 'package:flutter_application_1/views/Login.dart';
import 'package:page_transition/page_transition.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LangSelect extends StatefulWidget {
  const LangSelect({super.key});

  @override
  State<LangSelect> createState() => _LangSelectState();
}

class _LangSelectState extends State<LangSelect> {
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

          // FadeTransition for both Text widgets
          Container(
            margin: EdgeInsets.fromLTRB(0.20 * width, 0.35 * height, 0, 0),
            child: Text(
              'Please select a language',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Font',
                fontSize: 20,
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration( color: Colors.white),
          //   width: width*0.3,
          //   height: height*0.05,
          //   margin: EdgeInsets.fromLTRB(0.36 * width, 0.47 * height, 0, 0),
          //   child: 
            Container(
              width: width*0.3,
              height: height*0.05,    
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(0.36 * width, 0.45 * height, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(  // Set shape to RoundedRectangleBorder
                      borderRadius: BorderRadius.all(Radius.circular(10)), // Set borderRadius to zero
                    ),
                  ), 
                  onPressed: () {
Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: const Login(),
    ));

                  },
                  child: const Text(
                    'English',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Font',
                      fontSize: 15,
                    ),
                  ),
                ),
            ),

          Container(
              width: width*0.3,
              height: height*0.05,    
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(0.36 * width, 0.55 * height, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(  // Set shape to RoundedRectangleBorder
                      borderRadius: BorderRadius.all(Radius.circular(10)), // Set borderRadius to zero
                    ),
                  ), 
                  onPressed: () {},
                  child: const Text(
                    'Urdu',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Font',
                      fontSize: 15,
                    ),
                  ),
                ),
            ),
        ],
      ),
    );
  }
}
