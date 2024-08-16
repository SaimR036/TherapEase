
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
class Therapists extends StatefulWidget {
  const Therapists({super.key});

  @override
  State<Therapists> createState() => _TherapistsState();
}

class _TherapistsState extends State<Therapists> {
  var _enlarged = false;
  var curr_height;
  var curr_width;
  var show=false;
  @override
  Widget build(BuildContext context) {
 final String username = 'Dr. Imtiaz Cheema';
  final List<String> texts = [
    'Text 1: Patient report summary',
    'Text 2: Therapy session notes',
    'Text 3: Upcoming appointment reminder',
    'Text 4: New therapy techniques',
    'Text 5: Follow-up dassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'
  ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var enlarged_height = height * 0.4;
  var normal_height = height * 0.07;
  var enlarged_width = width *0.8;
  var normal_width = width * 0.8;
  _enlarged == true? curr_height = enlarged_height: curr_height = normal_height;
  _enlarged == true? curr_width = enlarged_width: curr_width = normal_width;

    return Scaffold(
      body:GestureDetector(
      onTap: () {
        if (_enlarged) {
          // When tapped outside, minimize if the container is enlarged
          setState(() {
            _enlarged = false;
          });
          print('Whole Unenlarged now');
        }
        print('Came');
      },
      
      child:Stack(
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
              margin: EdgeInsets.fromLTRB(width*0.1,height*0.1,width*0.1,0),  
              child: Text('Our Therapy Team.',
              style: TextStyle(fontSize: 40,color: Colors.white),
              ),),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(10)
              ),
              width: width*0.55,
              height: height*0.05,
              margin:EdgeInsets.fromLTRB(width*0.07,height*0.2,0,0),
              padding: EdgeInsets.fromLTRB(width*0.01,0,height*0.005,width*0.01),
              child:TextField(
              decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black)
              ),)


            ),
            Container(
              decoration: BoxDecoration(color: Color(0xFF29BDBD),
              borderRadius: BorderRadius.circular(10)
              ),
              width: width*0.25,
              height: height*0.05,
              margin:EdgeInsets.fromLTRB(width*0.65,height*0.2,0,0),
              child:TextButton(onPressed:(){},
              child:Text('Filters',style: TextStyle(
                fontSize: 20,
                fontFamily: 'Font',color: Colors.white),)
              )


            ),
            // 
            Align(
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
                margin: EdgeInsets.fromLTRB(0,height*0.3,0,0),
                height: curr_height,
                
                width: curr_width,
               
             
            child:GestureDetector(
                onTap: ()
                {
                  if(_enlarged)
                  {
                    setState(() {
                    _enlarged=false;
                  });
                   Future.delayed(Duration(milliseconds: 700),(){
setState(() {
  show=false;
});});
                  }
                  else{
                  setState(() {
                    _enlarged=true;
                  });
                  Future.delayed(Duration(milliseconds: 200),(){
setState(() {
  show=true;
});

                  });
                  }
                },
                child: Stack(
                  textDirection: TextDirection.ltr,
                  children: [
                AnimatedContainer(

                  duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                  width: _enlarged==true? width*0.13: width*0.10,
                  height:  _enlarged==true? height*0.09:height * 0.1,
                  padding: EdgeInsets.fromLTRB(0,0,5,0),
                  margin: EdgeInsets.fromLTRB(normal_width*0.03,_enlarged==true?normal_height*0.02: normal_height*0.1,0,normal_height*0.1),
                  child:CircleAvatar(child:Text('HI'))),
                AnimatedContainer(
                  duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                    width: _enlarged==true? width*0.45: width*0.4,
                    height:  _enlarged==true? height*0.06:height * 0.04,
                    
                    padding: EdgeInsets.fromLTRB(0, 0,0,0),
                    margin: EdgeInsets.fromLTRB(normal_width*0.19,_enlarged==true?normal_height*0.008: normal_height* 0.06, 0,0),
                    child: FittedBox( // <-- Add FittedBox widget
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Dr. Imtiaz Cheema',
                      
              
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Font',
                      ),
                    ),)),
                
                AnimatedContainer(
                  duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),

                  width: _enlarged==true? width*0.38:width*0.32,
                  height: _enlarged==true? height*0.03:height * 0.02,
                  padding: EdgeInsets.fromLTRB(0.0001, 0,0,0),
                  
                  margin: EdgeInsets.fromLTRB(normal_width*0.19,_enlarged==true?normal_height*0.65: normal_height* 0.56, 0,0),
                  child: FittedBox( // <-- Add FittedBox widget
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Psychologist',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFFCECECE),
                      fontFamily: 'Font',
                    ),
                  ),)),              
                AnimatedContainer(
                  duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),

                  width: _enlarged==true? width*0.09: width*0.08,
                  height:  _enlarged==true? height*0.03:height * 0.02,
                  margin: EdgeInsets.fromLTRB(normal_width*0.85,normal_height* 0.35, 0,0),
                  child: FittedBox( // <-- Add FittedBox widget
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4.7',
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
                if (show==true)
                AnimatedContainer(
                  duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),

                  height: height*0.1,
                  width:  width*0.5,

                  margin: EdgeInsets.fromLTRB(enlarged_width*0.03,enlarged_height* 0.26, 0,0),
                  child: Text('Customer Reviews',style: TextStyle(fontFamily: 'Font',fontSize: 20,color: Colors.white,),)

                ),
                if(show==true)
                Container(
                  margin: EdgeInsets.fromLTRB(0,enlarged_height* 0.35, 0,0),

                  child: ListView.builder(
        itemCount: texts.length,
        itemBuilder: (context, index) {
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
                      username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      texts[index],
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

            
            
              ),
            )
            
            ]),
            
            
    ));
  }
}