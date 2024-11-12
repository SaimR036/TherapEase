import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/doctors/Bank_Details.dart';
import 'package:page_transition/page_transition.dart';

class App_Status extends StatefulWidget {
  const App_Status({super.key});

  @override
  State<App_Status> createState() => _App_StatusState();
}

class _App_StatusState extends State<App_Status> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                      children:[

Container(
  width: width*0.4,
  height: height*0.2,
  child: FittedBox(child:Text('Check Status',style: TextStyle(
  color: Colors.white
),)),),
SizedBox(height: height*0.15,),
Container(
  
  width: width*0.8,
  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
  padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
  child: TextField(controller: email,cursorColor: Colors.black,  decoration: InputDecoration(hintText: 'Enter Email',fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),),),),
  SizedBox(height: height*0.05,),
  Container(
  width: width*0.3,
  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),

  child: TextButton(onPressed: () async{

CollectionReference users = FirebaseFirestore.instance.collection('Therapist_Applications');

  // Query for documents where 'email' field matches the provided email
QuerySnapshot querySnapshot = await users
    .where('Email', isEqualTo: email.text.toLowerCase())
    //.orderBy('createdAt', descending: true) // Make sure 'createdAt' is a field in your documents
    .limit(1)
    .get();
  if (querySnapshot.docs.isNotEmpty) {
    DocumentSnapshot doc1 = querySnapshot.docs.first;
    Map<String, dynamic> doc = {
    ...doc1.data() as Map<String, dynamic>,
    'id': doc1.id, // Append document ID as 'id'
  };
    // Access the 'Name' field of the document
    String status = doc['Status'];
    if (status=='1')
    {
       ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Application Approval Pending',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
    }
    else if(status=='0'){

       ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Application Not Approved',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Colors.blueGrey, // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
    }
  else if(status=='2')
  {
     ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Application Approved.',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Colors.blueGrey, // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Please provide necessary details to complete Sign Up',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Colors.blueGrey, // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
             Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child:  BankDetails(details: doc,),
      ),
        );
  }
  }
  else{
      ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('No Current Applications',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Colors.blueGrey, // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
  }
  }, child: FittedBox(child:Text('Check Status',style: TextStyle(color: Colors.black),))),)
                      ]))));
  }
}