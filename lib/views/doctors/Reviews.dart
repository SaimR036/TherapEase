import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
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
                  child: FittedBox(child: Text('Reviews',style: TextStyle(color: Colors.white,fontSize: 50),)))
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
                        List<dynamic> reviews = details['Reviews'];
                        return Container(
                          child: ListView.builder(
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              var review  = reviews[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: height*0.02),
                                decoration: BoxDecoration(
                  
                                  color: Color(0xFF05696A),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                width: width*0.9,
                                child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Container(
                                  width: width*0.4,
                                  margin: EdgeInsets.only(left: width*0.02),
                                  child: FittedBox(child: Text(review['Pname'],style: TextStyle(fontSize: 15,color: Colors.white),)),),
                                SizedBox(width: width*0.09, height: height*0.03,),
                                Container(
                                  alignment: Alignment.topRight,
                                  width: width*0.3,
                                  margin: EdgeInsets.only(top: 2),
                                  child: FittedBox(child: Text(review['Rating'].toString(),style: TextStyle(color: Colors.white,fontSize: 15),)),)
                              ,Container(
                                  alignment: Alignment.topRight,
                                  width: width*0.05,
                                  
                                  child: Icon(Icons.star,color: Colors.white,)),
                      
                              ],),
                              SizedBox(height: height*0.003,),
                              Container(
                                alignment: Alignment.topLeft,
                                // height: height*0.1,
                                // width: width*0.1,
                                margin: EdgeInsets.fromLTRB(width*0.02,0,height*0.02, width*0.02),
                                child: FittedBox(child: Text(review['Review'],style: TextStyle(color: Colors.white,fontSize: 20),)),)
                            ],
                          )
                              );
                              
                              }),
                        );
                      }),
                ),]))));
  }
}