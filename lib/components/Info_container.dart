import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Define the reusable Container component
class TextContainer extends StatefulWidget {
  late final bool show;
  late final int ind;
  late final int index;
  late final double enlargedWidth;
  late final double enlargedHeight;
  late final double normalWidth;
  late final double normalHeight;
  late final double height;
  late final double width;
  late final bool enlarged;
  late  var doctor;

  TextContainer({
    required this.show,
    required this.ind,
    required this.index,
    required this.enlargedWidth,
    required this.enlargedHeight,
    required this.normalWidth,
    required this.normalHeight,
    required this.height,
    required this.width,
    required this.enlarged,
    required this.doctor,
  });
  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
    late bool show;
  late int ind;
  late int index;
  late double enlarged_width;
  late double enlarged_height;
  late double normal_width;
  late double normal_height;
  late double height;
  late double width;
  late bool _enlarged;
  late var doctor;
var enlarge= false;

void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    show = widget.show;
    ind = widget.ind;
    index = widget.index;
    enlarged_width = widget.enlargedWidth;
    enlarged_height = widget.enlargedHeight;
    normal_width = widget.normalWidth;
    normal_height = widget.normalHeight;
    height = widget.height;
    width = widget.width;
    _enlarged = widget.enlarged;
    doctor = widget.doctor;
    return Align(
                  alignment:  Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                  border: Border.all(  // Use Border.all to create the border
                  color: Colors.white, 
                  width: 2.0,          // Specify the width of the border
                  ),   
                gradient: LinearGradient( // Define a LinearGradient
                  begin: Alignment.centerLeft, // Start from the left
                  end: Alignment.centerRight,   // End on the right
                  colors: [
                    Color(0xFF267979), // Start color (left)
                    Color(0xFF29BDBD), // End color (right)
                  ], // Add more colors for complex gradients
                ),
              ),
                    margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                    height: ind==index? enlarged_height: normal_height,
                    
                    width: ind==index? enlarged_width: normal_width,
                   
                 
                child:Stack(
                      textDirection: TextDirection.ltr,
                      children: [
                    AnimatedContainer(
            
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                      width: ind==index? width*0.13: width*0.10,
                      height:  ind==index? height*0.09:height * 0.1,
                      padding: EdgeInsets.fromLTRB(0,0,5,0),
                      margin: EdgeInsets.fromLTRB(normal_width*0.03,ind==index?normal_height*0.02: normal_height*0.1,0,normal_height*0.1),
                      child:CircleAvatar(child:Text('HI'))),
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                        width: ind==index? width*0.45: width*0.4,
                        height:  ind==index? height*0.06:height * 0.04,
                        
                        padding: EdgeInsets.fromLTRB(0, 0,0,0),
                        margin: EdgeInsets.fromLTRB(normal_width*0.19,ind==index?normal_height*0.008: normal_height* 0.06, 0,0),
                        child: FittedBox( // <-- Add FittedBox widget
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dr. '+doctor['Name'],
                          
                  
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Font',
                          ),
                        ),)),
                    
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
            
                      width: ind==index? width*0.38:width*0.32,
                      height: ind==index? height*0.03:height * 0.02,
                      padding: EdgeInsets.fromLTRB(0.0001, 0,0,0),
                      
                      margin: EdgeInsets.fromLTRB(normal_width*0.19,ind==index?normal_height*0.65: normal_height* 0.56, 0,0),
                      child: FittedBox( // <-- Add FittedBox widget
                      alignment: Alignment.centerLeft,
                      child: Text(
                        doctor['Profession'],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFCECECE),
                          fontFamily: 'Font',
                        ),
                      ),)),              
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
            
                      width: ind==index? width*0.09: width*0.08,
                      height:  ind==index? height*0.03:height * 0.02,
                      margin: EdgeInsets.fromLTRB(ind==index? width*0.52: width*0.50,ind==index?normal_height*0.65: normal_height* 0.56, 0,0),
                      child: FittedBox( // <-- Add FittedBox widget
                      alignment: Alignment.centerLeft,
                      child: Text(
                        doctor['Rating'].toString(),
                        style: TextStyle(
                          color: Color(0xFFCECECE),
                          fontFamily: 'Font',
                        ),
                      ),)),     
                    Container(
                      height: height*0.01,
                      width: width*0.01,
                      margin: EdgeInsets.fromLTRB(normal_width*0.73,normal_height* 0.38, 0,0),
                      // child: Image.asset('lib/assets/star.png'),),
                                  ),

                    AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color: doctor['Ban']==0? Color(0xFF9B111E): Color(0xFF0F5132)
                        ),
                        width: ind==index? normal_width*0.18: normal_width*0.2,
                        height: normal_height* 0.7,
                        margin:
                         EdgeInsets.fromLTRB(ind==index? normal_width*0.79: normal_width*0.75,ind==index? normal_height*0.3: normal_height*0.1, 0,normal_height*0.1),
                        child: TextButton(
                                
                                child: Text(doctor['Ban']==0? 'Ban': 'Unban',style: TextStyle(fontFamily: 'Font',color: Colors.white),),
                                onPressed: ()
                                {
                                  if (doctor['Ban']==0)
                                  {
                                  FirebaseFirestore.instance
        .collection('Doctors') // Replace with your collection name
        .doc(doctor['Email'])
        .update({'Ban': 1});
                                  }
                                  else{
                                    FirebaseFirestore.instance
        .collection('Doctors') // Replace with your collection name
        .doc(doctor['Email'])
        .update({'Ban': 0});
                                  }
                                },
                                ),),
                    if (show==true && ind ==index)
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),
            
                      height: height*0.1,
                      width:  width*0.5,
            
                      margin: EdgeInsets.fromLTRB(enlarged_width*0.03,enlarged_height* 0.26, 0,0),
                      child: Text('Customer Reviews',style: TextStyle(fontFamily: 'Font',fontSize: 20,color: Colors.white,),)
            
                    ),
                     if (show==true && ind ==index)

                    Container(
                      margin: EdgeInsets.fromLTRB(0,enlarged_height* 0.35, 0,0),
            
                      child: ListView.builder(
                    itemCount: doctor['Reviews'].length,
                    itemBuilder: (context, index) {
                      print(doctor['Reviews'].length);
                      var Review =  doctor['Reviews'].length > 0 ?doctor['Reviews'][index]:null;
                      return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.teal.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Review == null?'No Reviews yet':Review['Name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                           Review == null?'':Review['Description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                  ),
                ),
                      );
                    },
                  ),
                    )
                                  
                                  
                                   ],),
                  )
            
                
                
                  
                );
  }
}
