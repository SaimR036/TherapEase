import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Add this package to format dates

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _selectedIndex=0;
  var  Name='';
  var paths = ['lib/assets/Deep_breath.png','lib/assets/Meditate.png','lib/assets/Brain.png'];
  var names = ['Deep breathing','Meditation','Brain Exercise'];
  var username = 'Zia';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
    
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
                      stream: FirebaseFirestore.instance.collection('users').doc('0udrDWeB2NTRglYz1E4htrucTkk2').snapshots(),
                      builder: (context, snapshot) {
                  
                        if (!snapshot.hasData) {
                          return Container(
                            width: width*0.1,
                            height: height*0.1,
                            margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                            child: CircularProgressIndicator(color: Colors.white,));
                        }
                        var details = snapshot.data!.data() as Map<String, dynamic>;
                        List<dynamic> Appointments = details['Appointments'];
                        Name = details['name'];
                        DateTime currentTime = DateTime.now();
                        var check=0;
                     for (var appointment in Appointments) {
              // Ensure appointment contains the expected fields
              if (appointment.containsKey('Date') && appointment.containsKey('Time')) {
                try {
                  // Corrected date format
                  DateTime appointmentTime = DateFormat("EEEE, MMMM d, yyyy 'at' h:mm a")
                      .parse("${appointment['Date']} at ${appointment['Time']}");

                  if (check==0 && appointmentTime.isBefore(currentTime.subtract(Duration(hours: 1)))) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                    //_showReviewDialog(appointment);
                    });
                    check=1;
                  }
                } catch (e) {
                  print('Error parsing appointment date/time: $e');
                }
              }
            }
                        return Container(
                          child: ListView.builder(
                            itemCount: Appointments.length,
                            itemBuilder: (context, index) {
                              var details = Appointments[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: height*0.03),
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
                                  alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: width*0.02),
                                width: width*0.35,
                                height: height*0.05,
                                child: FittedBox(child: Text('Dr. '+details['Doctor'],style: TextStyle(color: Colors.white,fontSize: 20),))),
                                SizedBox(width: width*0.1,),
                                Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.4,
                                child: FittedBox(child: Text(details['Date'],style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ]),
                                Row(children: [
                                Container(
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.35,
                                child: Text(details['Profession'],style: TextStyle(color: Colors.white,fontSize: 15),)),
                                SizedBox(width: width*0.30,),
                                Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.2,
                                child: FittedBox(child: Text(details['Time'],style: TextStyle(color: Colors.white,fontSize: 15),))),
                                ]),
                                SizedBox(height: height*0.02,),
                                Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.65,
                                height: height*0.05,
                                child: FittedBox(child: Text(details['Link'],style: TextStyle(color: Colors.white,fontSize: 20),)))
                                ,SizedBox(width: width*0.03,),
                                Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.15,
                                height: height*0.05,
                                child: FittedBox(child: Text('Rs. '+details['Price'],style: TextStyle(color: Colors.white,fontSize: 20),)))
                                ])
                              ],));
                              
                              }),
                        );
                      }),
                )
              
              
              
              ]),
            )
            
            ));
  }
   void _showReviewDialog(Map<String, dynamic> appointment) {
    String rating = '';
    String review = '';

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review Appointment with Dr. ${appointment['Doctor']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  rating = value;
                },
                decoration: InputDecoration(labelText: 'Rating (1-5)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) {
                  review = value;
                },
                decoration: InputDecoration(labelText: 'Your Review'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (rating.isNotEmpty && review.isNotEmpty) {
                  _submitReview('0udrDWeB2NTRglYz1E4htrucTkk2', rating, review);
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show error message if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _submitReview(String doctorId, String rating, String review) {
    var reviewData = {
      'Rating': rating,
      'Review': review,
      'Pname': Name + '.'
    };

    FirebaseFirestore.instance
        .collection('Doctors')
        .doc(doctorId) // Make sure to use the correct field for Doctor ID
        .update({
      'Reviews': FieldValue.arrayUnion([reviewData]), // Append to reviews field
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $error')),
      );
    });
  }

}
