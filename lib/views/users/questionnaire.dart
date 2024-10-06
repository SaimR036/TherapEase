import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/question.dart';
import 'package:provider/provider.dart';

import '../../providers/Indexes_st.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  var email ='saimr036@gmail.com';
List<String> questions=["I found it hard to wind down ","I was aware of dryness of my mouth ","I couldn’t seem to experience any positive feeling at all ", "I experienced breathing difficulty (e.g. excessively rapid breathing, breathlessness in the absence of physical exertion)",
"I found it difficult to work up the initiative to do things",
"I tended to over-react to situations",
"I experienced trembling (e.g. in the hands)",
"I felt that I was using a lot of nervous energy",
"I was worried about situations in which I might panic and make a fool of myself",
"I felt that I had nothing to look forward to",
"I found myself getting agitated",
"I found it difficult to relax",
"I felt down-hearted and blue",
"I was intolerant of anything that kept me from getting on with what I was doing ",
"I felt I was close to panic ",
"I was unable to become enthusiastic about anything",
"I felt I wasn’t worth much as a person",
"I felt that I was rather touchy",
"I was aware of the action of my heart in the absence of physical exertion (e.g. sense of heart rate increase, heart missing a beat) ",
"I felt scared without any good reason",
"I felt that life was meaningless",
];
var st=0;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Indexes>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  Scaffold(
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
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(0,height*0.04,0,0),
              child:Text('Statements',style: TextStyle(fontFamily: 'Font',color: Color(0xFF29BDBD),fontSize: 50,fontWeight: FontWeight.bold),),),
            Questions(questions: questions, index: st), 
            Container(
                            width: width*0.7,

              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(width*0.15,height*0.88,0,0),
              child: TweenAnimationBuilder<double>(
    duration: Duration(milliseconds: 300), // Adjust duration as needed
    tween: Tween<double>(begin: 0, end: (provider.indexes
            .where((index) => index != -1)
            .length /
        provider.indexes.length)),
    builder: (context, value, child) => LinearProgressIndicator(
      
      borderRadius: BorderRadius.circular(10),
      minHeight: height*0.008,
      value: value,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF05696A)), 
    
    ),
  ),),


            Container(
              height: height*0.05,
              width: width*0.15,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Color(0xFF05696A)
              ),
              margin: EdgeInsets.fromLTRB(width*0.8,height*0.91,0,0),
              child:Center(
                child: TextButton(
                onPressed: () async{
                  if (st>=17)
                  {
                    var check=-1;
                    for(int i=0;i<21;i++)
                    {
                      if (provider.indexes[i]==-1)
                      {
                            ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please submit all answers."), // Use display name if available
                      backgroundColor: Color(0xFF05696A),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                  );
                  check=1;
                      }
                      break;
                    }
                    

                    if(check==-1) {
                      final CollectionReference testsCollection = 
      FirebaseFirestore.instance.collection('Tests');

  // Check if a document with the desired ID already exists
  final documentSnapshot = await testsCollection.doc(email).get(); // Replace 'your_document_id' with the actual ID you want to use

  if (documentSnapshot.exists) {
    // Document exists, overwrite it
    await testsCollection.doc('your_document_id').update({
      'indexes': provider.indexes, // Update the 'indexes' field
    });
  }
  else {
    // Document doesn't exist, create a new one
    await testsCollection.doc('your_document_id').set({
      'indexes': provider.indexes,
    });
  }
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Thank you for submitting."), // Use display name if available
                      backgroundColor: Color(0xFF05696A),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                  );
                    
                  }
                  }
                  else{
                  st+=4;
                  setState(() {
                    
                  });
                  }
                },
                child: Text(st>=17? 'Submit': 'Next',style: TextStyle(fontFamily: 'Font',fontSize: 14,color: Colors.white),),),
              )),
              if(st>=4)
              Container(
              height: height*0.05,
              width: width*0.15,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Color(0xFF05696A)
              ),
              margin: EdgeInsets.fromLTRB(width*0.05,height*0.91,0,0),
              child:Center(
                child: TextButton(
                onPressed: (){

                  
                  st-=4;
                  setState(() {
                    
                  });
                  },
                
                child: Text('Back',style: TextStyle(fontFamily: 'Font',fontSize: 14,color: Colors.white),),),
              ))
            
            
            ]));
  }
}