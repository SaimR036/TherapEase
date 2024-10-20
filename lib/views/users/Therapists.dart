
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/parent_info.dart';
import 'package:flutter_application_1/providers/parent_info_container.dart';
import 'package:provider/provider.dart';
class Therapists extends StatefulWidget {
  const Therapists({super.key});

  @override
  State<Therapists> createState() => _TherapistsState();
}

class _TherapistsState extends State<Therapists> {

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Stack(
        children:[
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
             margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),  
              child: FittedBox(
                child: Text('Our Therapy Team.',
                style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: 'Font'),
                ),
              ),),
            ),
           Container(
            margin: EdgeInsets.only(top: height*0.05),
            child: ParentInfo(isUser:true))
            
            ]));
  }
}