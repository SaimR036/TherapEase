import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var paths = ['lib/assets/Deep_breath.png','lib/assets/Meditate.png','lib/assets/Brain.png'];
  var names = ['Deep breathing','Meditation','Brain Exercise'];
  var username = 'Zia';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body:Container(
        height: height,
        width: width,
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
            
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
        children:[
      
            Container(
              
              child: Text('Welcome Back ${username}!'),
            
            
            ),
            SizedBox(height: height*0.1,),
            Row(
              children: [
            Container(
              margin: EdgeInsets.only(left: width*0.05),
              width: width*0.25,
              child: FittedBox(child: Text('Daily Exercises',style: TextStyle(color: Colors.white,fontSize: 20),)),)
            ,SizedBox(width: width*0.3,),
            Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
                alignment: Alignment.centerLeft,
              width: width*0.1,
              child: FittedBox(child: Text('Progress',style: TextStyle(color: Colors.white,fontSize: 30),)),)
              ,SizedBox(width: width*0.2),
              Container(
                
              width: width*0.05,
              child: FittedBox(child: Text('33%',style: TextStyle(color: Colors.white,fontSize: 20),)),)
              
                ]
              ),
               Container(
                width: width*0.35,
              alignment: Alignment.topCenter,
              child: TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 300), // Adjust duration as needed
    tween: Tween<double>(begin: 0, end:3/5),
    builder: (context, value, child) => LinearProgressIndicator(
      
      borderRadius: BorderRadius.circular(10),
      minHeight: height*0.008,
      value: value,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF05696A)), 
    
    ),
  ),),


            ],)
              ]),
              SizedBox(height: height*0.02,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: width*0.05),
                width: width*0.9,
                height: height*0.2,
                decoration: BoxDecoration(
                  color: Color(0xFF239494),
                  borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  for (int i = 0; i < paths.length; i++)
                  Container(
                    //margin: EdgeInsets.only(left:width*0.03, right: width*0.05),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: height*0.13,
                          margin: EdgeInsets.only(top: height*0.02),
                          child: Image.asset(paths[i])),
                          Container(
                            child: Icon(Icons.approval),)
                                           ]                   ),
                    ),
                    Container(child: FittedBox(child: Text(names[i],style: TextStyle(color: Colors.white),))),
                  
                  ],
                  )
                  ),
                ],)),
              Container(
                margin: EdgeInsets.only(left: width*0.05),
                width: width*0.5,
                child: FittedBox(child: Text('Upcoming Sessions',style: TextStyle(color: Colors.white),)))
              ,SizedBox(height: height*0.1,)
              ,
              

            
            ])
            
            ));
  }
}