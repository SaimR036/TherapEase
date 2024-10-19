import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';

class Dr_Appointments extends StatefulWidget {
  const Dr_Appointments({super.key});

  @override
  State<Dr_Appointments> createState() => _Dr_AppointmentsState();
}

class _Dr_AppointmentsState extends State<Dr_Appointments> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      //bottomNavigationBar: BottomNavbar(),
      body: 
    Container(
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
              child: 
    Column(children: [
    Container(
                  alignment: Alignment.topCenter,
                  width: width*0.5,
                  child: FittedBox(child: Text('Sessions',style: TextStyle(color: Colors.white,fontSize: 30),)))
                ,SizedBox(height: height*0.1,),
                
                Container(
                  width: width*0.9,
                  height: height*0.4,
                  
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
                        List<dynamic> appointments = details['Appointments'];
                        return Container(
                          child: ListView.builder(
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              var appointment  = appointments[index];
                              return Container(
                                decoration: BoxDecoration(
                  
                                  color: Color(0xFF05696A),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                width: width*0.9,
                                height: height*0.17,
                                child:Column(
                                 // mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                  children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: width*0.02),
                                width: width*0.3,
                                height: height*0.05,
                                child: FittedBox(child: Text(appointment['Pname'],style: TextStyle(color: Colors.white,fontSize: 20),))),
                                SizedBox(width: width*0.15,),
                                Container(
                                  height: height*0.05,
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,2,0,0),
                                width: width*0.4,
                                child: FittedBox(child: Text(appointment['Date'],style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ]), 
                                Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: height*0.05,
                                margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.3,
                                child: FittedBox(child: Text(appointment['Note'],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 20),))),
                                SizedBox(width: width*0.25,),
                                 Container(
                                  height: height*0.05,
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.3,
                                child: Text(appointment['Time'],style: TextStyle(color: Colors.white,fontSize: 20),)),
                                ]),
                                SizedBox(height: height*0.005,width: width*0.0,),
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: height*0.05,
                                //margin: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                width: width*0.86,
                                child: FittedBox(child: Text('Link: '+appointment['Link'],style: TextStyle(color: Colors.white,fontSize: 20),)))
                                
                              ],));
                              
                              }),
                        );
                      }),
                ),]))));
  }
}