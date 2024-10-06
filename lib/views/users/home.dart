import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex=0;
   
  var paths = ['lib/assets/Deep_breath.png','lib/assets/Meditate.png','lib/assets/Brain.png'];
  var names = ['Deep breathing','Meditation','Brain Exercise'];
  var username = 'Zia';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF29BDBD),
        height: height*0.07,
        buttonBackgroundColor: Color(0xFF05696A),
        color: Color(0xFF05696A),
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Column(children: [Image.asset('lib/assets/home.png', height: 25),Text('Home',style: TextStyle(fontSize: 10),),
          ],),
          Column(children: [Image.asset('lib/assets/appointments.png', height: 25),Text('Bookings',style: TextStyle(fontSize: 10)),
          ],),
          Column(children: [Image.asset('lib/assets/book.png', height: 24),Text('Book',style: TextStyle(fontSize: 10)),
          ],),
          Column(children: [Image.asset('lib/assets/exercises.png', height: 25),Text('Exercises',style: TextStyle(fontSize: 10)),
          ],),
          Column(children: [Image.asset('lib/assets/settings.png', height: 25),Text('Settings',style: TextStyle(fontSize: 10)),
          ],),
          // const Icon(icon:Image.asset('lib/assets/home.png', height: 30), size: 26, color: Colors.white,),
          // const Icon(Image.asset('lib/assets/appointments.png', height: 30), size: 26, color: Colors.white),
          // const Icon(Image.asset('lib/assets/book.png', height: 30), size: 26, color: Colors.white),
          // const Icon(Image.asset('lib/assets/exercises.png', height: 30), size: 26, color: Colors.white),
          // const Icon(Image.asset('lib/assets/settings.png', height: 30), size: 26, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      //     backgroundColor: Color(0xFF05696A),
      //     icon: Image.asset('lib/assets/home.png', height: 30),
      //     label: 'Home',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Image.asset('lib/assets/appointments.png', height: 30),
      //     label: 'Appointments',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Image.asset('lib/assets/book.png', height: 30),
      //     label: 'Book',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Image.asset('lib/assets/exercises.png', height: 30),
      //     label: 'Exercises',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Image.asset('lib/assets/settings.png', height: 30),
      //     label: 'Settings',
      //   ),
      // ],  
      // currentIndex: _selectedIndex,
      // selectedItemColor: Colors.white,
      // unselectedItemColor: Color(0xFF239494),
      // selectedFontSize: 10,
      // unselectedFontSize: 6,
      // onTap: (index) {
      //   setState(() {
      //     _selectedIndex = index; // Update the selected index directly
      //   });
      // },
            

      
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
            
            child:SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                    
              Container(
                margin: EdgeInsets.only(left: width*0.30,top: height*0.05),
                width: width*0.4,
                child: FittedBox(child: Text('Welcome Back $username!',style: TextStyle(color: Colors.white,fontSize: 20),)),)
              ,
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
                  SizedBox(height: height*0.05,),
                Container(
                  margin: EdgeInsets.only(left: width*0.05),
                  width: width*0.5,
                  child: FittedBox(child: Text('Upcoming Sessions',style: TextStyle(color: Colors.white),)))
                ,SizedBox(height: height*0.02,),
                
                Container(
                  width: width*0.9,
                  height: height*0.4,
                  margin: EdgeInsets.only(left: width*0.05),
                  child: StreamBuilder( //
                      stream: FirebaseFirestore.instance.collection('Appointments').where('Puid', isEqualTo:context.read<LoginProvider>().uid).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  
                        if (!snapshot.hasData) {
                          return Container(
                            width: width*0.1,
                            height: height*0.1,
                            margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                            child: CircularProgressIndicator(color: Colors.white,));
                        }
                        
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var details = snapshot.data!.docs[index];
                              return Container(
                                decoration: BoxDecoration(
                  
                                  color: Color(0xFF05696A),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                width: width*0.9,
                                height: height*0.17,
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                  children: [
                                Container(
                                margin: EdgeInsets.only(left: width*0.02),
                                width: width*0.4,
                                height: height*0.05,
                                child: Text(details['Doctor'],style: TextStyle(color: Colors.white,fontSize: 20),)),
                                SizedBox(width: width*0.2,),
                                Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.25,
                                child: Text(details['Date'],style: TextStyle(color: Colors.white,fontSize: 20),)),
                                  ]),
                                Row(children: [
                                Container(
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.3,
                                child: Text(details['Profession'],style: TextStyle(color: Colors.white,fontSize: 15),)),
                                SizedBox(width: width*0.35,),
                                Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.2,
                                child: Text(details['Time'],style: TextStyle(color: Colors.white,fontSize: 15),)),
                                ]),
                                SizedBox(height: height*0.02,),
                                Container(
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.7,
                                child: Text(details['Link'],style: TextStyle(color: Colors.white,fontSize: 20),))
                                
                              ],));
                              
                              }),
                        );
                      }),
                )
              
              
              
              ]),
            )
            
            ));
  }
}