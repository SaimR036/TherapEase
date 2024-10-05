import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:provider/provider.dart';

class TherapTest extends StatefulWidget {
  const TherapTest({super.key});

  @override
  State<TherapTest> createState() => _TherapTestState();
}

class _TherapTestState extends State<TherapTest> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
                  width: width*0.9,
                  height: height*0.4,
                  margin: EdgeInsets.only(left: width*0.05),
                  child: StreamBuilder( //
                      stream: FirebaseFirestore.instance.collection('Appointments').where('Tuid', isEqualTo:context.read<LoginProvider>().uid).snapshots(),
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
                                child: Text(details['Patient'],style: TextStyle(color: Colors.white,fontSize: 20),)),
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
                );
  }
}