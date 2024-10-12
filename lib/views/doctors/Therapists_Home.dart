import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Therapists_Home extends StatefulWidget {
  const Therapists_Home({super.key});

  @override
  State<Therapists_Home> createState() => _Therapists_HomeState();
}

class _Therapists_HomeState extends State<Therapists_Home> {
  var _selectedIndex=0;
   
  var paths = ['lib/assets/Deep_breath.png','lib/assets/Meditate.png','lib/assets/Brain.png'];
  var names = ['Deep breathing','Meditation','Brain Exercise'];
  var username = 'Zia';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      
    bottomNavigationBar: BottomNavbar(),
      
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
              Container(
                margin: EdgeInsets.only(left: width*0.05),
                width: width*0.20,
                child: FittedBox(child: Text('Reviews',style: TextStyle(color: Colors.white,fontSize: 20),)),)
            ,
               
              
              
             
                SizedBox(height: height*0.01,),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: width*0.05),
                  width: width*0.9,
                  height: height*0.18,
                  decoration: BoxDecoration(
                    color: Color(0xFF17A2A3),
                    borderRadius: BorderRadius.circular(10)),
                  child: StreamBuilder( //
                  stream: FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2').snapshots(),
                  builder: (context,  snapshot) {
                                    
                    if (!snapshot.hasData) {
                      return Container(
                        width: width*0.1,
                        height: height*0.1,
                        margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                        child: CircularProgressIndicator(color: Colors.white,));
                    }
                    var details = snapshot.data!.data() as Map<String, dynamic>;
                    var reviews = details['Reviews'];
                    return Container(
                      margin: EdgeInsets.fromLTRB(width*0.025, height*0.01,0,0),
                       width: width*0.85,
                  height: height*0.16,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                      
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          var review = reviews[index];
                          
                          return Container(
                            padding: EdgeInsets.fromLTRB(width*0.02, height*0.01, width*0.02, height*0.01),
                            margin: EdgeInsets.only(right: width*0.04),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF05696A)
                          ),
                          width: width*0.45,
                          height: height*0.17,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(children: [
                                Container(
                                  width: width*0.27,
                                  child: Text(review['Pname'],style: TextStyle(fontSize: 16,color: Colors.white),),),
                                SizedBox(width: width*0.09, height: height*0.03,),
                                Container(child: Text( review['Rating'].toString(),style: TextStyle(color: Colors.white),),)
                      
                              ],),
                              SizedBox(height: height*0.003,),
                              Container(
                                alignment: Alignment.topLeft,
                                // height: height*0.1,
                                // width: width*0.1,
                                child: Text(review['Review'],maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),)
                            ],
                          )
                          );
                        }),
                    );
                  })
                                      
                    ),
                  
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
                      stream: FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2').snapshots(),
                      builder: (context,  snapshot) {
                  
                        if (!snapshot.hasData) {
                          return Container(
                            width: width*0.1,
                            height: height*0.1,
                            margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                            child: CircularProgressIndicator(color: Colors.white,));
                        }
                        var details = snapshot.data!.data() as Map<String, dynamic>;
                        var appointments = details['Appointments'];
                        return Container(
                          child: ListView.builder(
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              var appointment  = appointments[index];
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
                                width: width*0.4,
                                height: height*0.05,
                                child: FittedBox(child: Text(appointment['Pname'],style: TextStyle(color: Colors.white,fontSize: 20),))),
                                SizedBox(width: width*0.1,),
                                Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.35,
                                height: height*0.05,
                                child: FittedBox(child: Text(appointment['Date'],style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ]), 
                                Row(children: [
                                Container(alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.3,
                                height: height*0.05,
                                child: FittedBox(child: Text(appointment['Note'],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 15),))),
                                SizedBox(width: width*0.33,),
                                 Container(
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.22,
                                height: height*0.05,
                                child: FittedBox(child: Text(appointment['Time'],style: TextStyle(color: Colors.white,fontSize: 15),))),
                                ]),
                                SizedBox(height: height*0.02,),
                                Container(
                                  alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.85,
                                height: 
                                height*0.05,
                                child: FittedBox(child: Text('Link: '+appointment['Link'],style: TextStyle(color: Colors.white,fontSize: 20),)))
                                
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