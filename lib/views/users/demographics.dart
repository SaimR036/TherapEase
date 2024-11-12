import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/views/users/Instructions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Demographics extends StatefulWidget {
  const Demographics({super.key});

  @override
  State<Demographics> createState() => _DemographicsState();
}

class _DemographicsState extends State<Demographics> {

  var age_index = -1;
  var gender_index=-1;
  var occup_index=-1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
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
    margin: EdgeInsets.fromLTRB(width*0.05, height*0.07, width*0.05,0),
    child: FittedBox(
      child: Text("Let's get to know you better",style: TextStyle(
        fontSize: 22,
        fontFamily: 'Font',color: Color(0xFF00FDFD)),),
    ),),
),
Container(
    margin: EdgeInsets.fromLTRB(width*0.05, height*0.26, 0,0),
    child: Text("Age range",style: TextStyle(
      fontSize: 20,
      fontFamily: 'Font',color: Colors.white),),),
Container(
    margin: EdgeInsets.fromLTRB(width*0.60, height*0.16, 0,0),
    child: TextButton(
      
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            age_index==0 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){
        setState(() {
          age_index = 0;
        });
      },
      child:Text("Below 18",style: TextStyle(
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),
Container(
    margin: EdgeInsets.fromLTRB(width*0.61, height*0.23, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            age_index==1 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){
        setState(() {
          age_index=1;
        });
        
      },
      child:Text("18 - 24",style: TextStyle(
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),
Container(
    margin: EdgeInsets.fromLTRB(width*0.61, height*0.30, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            age_index ==2 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){

        setState(() {
          age_index = 2;
        });
      },
      child:Text("25 - 40",style: TextStyle(
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),
Container(
    margin: EdgeInsets.fromLTRB(width*0.67, height*0.36, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            age_index ==3 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){

        setState(() {
          age_index =3;
        });
      },
      child:Text("40+",style: TextStyle(
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),

      Align(
  alignment: Alignment.topCenter,
  child: Container(
        width: width*0.8,
        height: 2,
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0,height*0.42,0,0),
      )),


Container(
    margin: EdgeInsets.fromLTRB(width*0.05, height*0.48, 0,0),
    child: Text("Gender",style: TextStyle(
      fontSize: 20,
      fontFamily: 'Font',color: Colors.white),),),
Container(
    margin: EdgeInsets.fromLTRB(width*0.66, height*0.44, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            gender_index==0 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){
        setState(() {
          gender_index = 0;
        });
      },
      child:Text("Male",style: TextStyle(
        
        
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),
Container(
    margin: EdgeInsets.fromLTRB(width*0.63, height*0.51, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            gender_index==1 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){
        setState(() {
          gender_index=1;
        });
        
      },
      child:Text("Female",style: TextStyle(
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),

Align(
  alignment: Alignment.topCenter,
  child: Container(
        width: width*0.8,
        height: 2,
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0,height*0.60,0,0),
      )),
Container(
    margin: EdgeInsets.fromLTRB(width*0.05, height*0.7, 0,0),
    child: Text("Occupation",style: TextStyle(
      fontSize: 20,
      fontFamily: 'Font',color: Colors.white),),),

Container(
    margin: EdgeInsets.fromLTRB(width*0.62, height*0.64, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            occup_index ==0 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){

        setState(() {
          occup_index = 0;
        });
      },
      child:Text("Working",style: TextStyle(
        fontSize: 20,
        fontFamily: 'Font',color: Colors.white),),)),
Container(
    margin: EdgeInsets.fromLTRB(width*0.62, height*0.7, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            occup_index ==1 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){

        setState(() {
          occup_index = 1;
        });
      },
      child:Text("Student",style: TextStyle(
              fontSize: 20,

        fontFamily: 'Font',color: Colors.white),),)),
      
      Container(
        width: width*0.5,
    margin: EdgeInsets.fromLTRB(width*0.49, height*0.76, 0,0),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
 // Set borderRadius to zero
        ),),
          backgroundColor: MaterialStateProperty.all(
            occup_index ==2 ? Colors.green : Colors.transparent,
          )),
      onPressed: (){

        setState(() {
          occup_index = 2;
        });
      },
      child:FittedBox(
        child: Text("None of these",style: TextStyle(
                fontSize: 20,
        
          fontFamily: 'Font',color: Colors.white),),
      ),)),
        
        
        Align(
          alignment: Alignment.topCenter,
          child: Container(
          width: width*0.3,
              margin: EdgeInsets.fromLTRB(0, height*0.85, 0,0),
              child: TextButton(
                style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), 
           // Set borderRadius to zero
          ),),
            backgroundColor: MaterialStateProperty.all(
             Color(0xFF05696A) 
            )),
                onPressed: () async{
                  if (age_index<0 || gender_index<0 || occup_index < 0)
                  {
                       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please complete the details"),
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
                  }
                  else{
                   
        try {
          var age;
          var gender="";
          var occupation;
          if (age_index==0)
          {
              age="Below 18";
          }
          if (age_index==1)
          {
              age="18 - 24";
          }
          if (age_index==2)
          {
              age="25 - 40";
          }
          if (age_index==3)
          {
              age="40+";
          }
          
          
          if (gender_index==0)
          {
              gender="Male";
          }
          if (gender_index==1)
          {
              gender="Female";
          }
          if (occup_index==0)
          {
              occupation="Working";
          }
          if (occup_index==1)
          {
              occupation="Student";
          }
          if(occup_index==2)
          {
            occupation="None of these";
          }
          // 1. Get the Current User's Email
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            final uid = user.uid;

            // 2. Store age_idx in Firestore
            await FirebaseFirestore.instance.collection('users').doc(uid).set({
              'age_range': age,
              'gender':gender,
              'occupation':occupation,
              'Info':'1'

            }, SetOptions(merge: true)); // Merge with existing data
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt('isLoggedIn', 0);
            // 3. Optional: Show Success Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thank you!'),
                backgroundColor: Color(0xFF05696A),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
               Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: Instructions(),
    ));

          } 
        } catch (e) {
          // 5. Error Handling
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error saving data, please try again'),
                backgroundColor: Color(0xFF05696A),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
        }
      
                  }
          
                },
                child:Text("Done",style: TextStyle(
                fontSize: 24,
          
          fontFamily: 'Font',color: Colors.white),),)),
        ),
      
        ]));
  }
}