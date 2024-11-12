import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/components/question.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/Indexes_st.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  var email ='saimr036@gmail.com';
List<String> questions=["I found it hard to wind down ",
"I was aware of dryness of my mouth ","I couldn’t seem to experience any positive feeling at all ", "I experienced breathing difficulty (e.g. excessively rapid breathing, breathlessness in the absence of physical exertion)",
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

List<String> urdu_questions =["میرے لیے اپنے غصے پر قابو پانا مشکل ہو جاتا ہے۔",
"۔مجھے یہ محسوس ہوتا رہا ہے جیسے میرا منہ خشک ہو رہا ہے",
"مجھے کسی قسم کے مثبت جذبات محسوس نہیں ہوتے۔",
"مجھے کسی جسمانی مشقت والے کام کے بغیر سانس لينے ميں دشواری محسوس ہوتی رہی ہے۔",
"مجھے کسی کام کے ليے اغاذ کرنا مشکل محسوس ہوتا رہا ہے۔",
"ميں نے بعض حالات ميں غير ضروری ردعمل کا اضہار کيا ہے۔",
"ميں نے اپنے جسم ميں کپکپاہٹ محسوس کی۔",
"ميں نے محسوس کيا ہے کہ ميں نے کام کرنے کيليے پہت زيادہ زہنی توانائ صرف کی۔",
"ميں اپنے حالات کے متعلق پريشان ہوا جن ميں ميرے بےوقوف بننے اور ميری بے چينی بڑھنے کا خدشہ تھا۔",
"ميں نے اپنا مستقبل تاريک محسوس کيا۔",
"ميں نےاپنے آپ ميں چڑچڑاپن اور ضد محسوس کيا۔",
"ميں زہنی طور پہ بے سکونی محسوس کرتا/کرتی رہی ہوں۔",
"ميں نے محسوس کيا جيسے ميرا دل بيٹھ گيا ہو اور ميں اداس ہوں۔",
"ميرے ليے اس چيز يا شخص کو برداشت کرنا مشکل رہا ہے جو ميرے کام ميں رکاوٹ پيدا کرے۔",
"مجھے محسوس ہوتا رہا ہے جيسے مجھے دورہ پڑنے لگا ہے۔",
"مجھے کسی بھی کام ميں دلچسپی نہيں رہی۔",
"ميں نے محسوس کيا ہے کہ ميری کويی اہميت نہيں ہے۔",
"مجھے محسوس ہوتا رہا کہ ميں حساس ہوں اور جزباتی ہوتا رہا/رہی ہوں۔",
"مجھے بغير جسمانی مشقت کے دل کی دھڑکن تيز محسوس ہوتی رہی ہے۔",
"ميں بغير کسی مناسب وجہ کے خوفزدہ ہو جاتا/جاتی ہوں۔",
"ميں نے محسوس کيا ہے کہ زندگی بے معنی اور بے مقصد ہے۔"
];
var st=0;
var results =2;
var dep_word="";
var eng=0;
var anx_word="";
var str_word="";
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Indexes>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var bottom_navbar_provider =  Provider.of<BottomNavbarProvider>(context);
    return  WillPopScope(
      onWillPop: () async {
        // Navigate to the Home() page when the back button is pressed
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNavbar()),
        );
        return false; // Prevent default back action
      },
      child:  Scaffold(
      
      body:  Container(
        width: width,
        height: height,
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
              if(results==2)
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(0,height*0.35,0,height*0.05),
                child:Text('Please select a language',style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
              if(results==2)
                Container(
                alignment: Alignment.topCenter,
                height: height*0.05,
                width: width*0.3,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color(0xFF05696A)
                ),
                    child: Center(child: TextButton(child: FittedBox(child: Text('English',style: TextStyle(color: Colors.white,fontSize: 30),)),onPressed: ()
                    {
                      
                      setState(() {
                        eng=0;
                        results=0;
                      });
                    },),)),
              if(results==2)
                Container(
                  margin: EdgeInsets.only(top: height*0.05),
                alignment: Alignment.topCenter,
                height: height*0.05,
                width: width*0.3,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color(0xFF05696A)
                ),
                    child: Center(child: TextButton(child: FittedBox(child: Text('Urdu',style: TextStyle(fontSize: 30,color: Colors.white),)),onPressed: ()
                    {
                      
                      setState(() {
                        eng=1;
                        results=0;
                      });
                    },),)),
              if(results==1)
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(0,height*0.15,0,height*0.05),
                child:Text('Results',style: TextStyle(fontFamily: 'Font',color: Color(0xFF29BDBD),fontSize: 50,fontWeight: FontWeight.bold),),),
              if(results==1)
              Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.05),
                alignment: Alignment.topCenter,
                child:Text("${dep_word+anx_word+str_word}",style: TextStyle(fontFamily: 'Font',color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),),
              if(results==1)
               Container(
                alignment: Alignment.topCenter,
                height: height*0.05,
                width: width*0.25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color(0xFF05696A)
                ),
                    child: Center(child: TextButton(child: Text('Home',style: TextStyle(color: Colors.white),),onPressed: ()
                    {
                      
                      bottom_navbar_provider.toggleIndex(2);
                    },),)),
              if(results==0)
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(0,height*0.04,0,0),
                child:Text('Statements',style: TextStyle(fontFamily: 'Font',color: Color(0xFF29BDBD),fontSize: 33,fontWeight: FontWeight.bold),),),
              if(results==0)

              SizedBox(height: height*0.02,),
              if(results==0)
              Questions(questions: eng==0?questions:urdu_questions, index: st,dir: eng==0?'l':'r'), 
              if(results==0)
              Container(
                              width: width*0.7,
        
                alignment: Alignment.topCenter,
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
        if(results==0)
        SizedBox(height: height*0.015,),
               if(results==0)
               Row(
                  children: [
                    if(st>=4)
                Container(
                height: height*0.05,
                width: width*0.25,
                margin: EdgeInsets.only(left: width*0.05),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color(0xFF05696A)
                ),
                child:Center(
                  child: TextButton(
                  onPressed: (){
        
                    
                    st-=4;
                    setState(() {
                      
                    });
                    },
                  
                  child: Text('Back',style: TextStyle(fontFamily: 'Font',fontSize: 14,color: Colors.white),),),
                )),
                   Container(
                alignment: Alignment.bottomRight,
                height: height*0.05,
                width: width*0.25,
                margin: EdgeInsets.only(left: width*0.4),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Color(0xFF05696A)
                ),
                    child: Center(
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
                           showDialog(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(width: 16),
            Text(
              "Calculating...",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    },
  );
                          
                          final CollectionReference testsCollection = 
                            FirebaseFirestore.instance.collection('users');
                            
                              // Check if a document with the desired ID already exists
                            //   final documentSnapshot = await testsCollection.doc(email).get(); // Replace 'your_document_id' with the actual ID you want to use
                            
                            //   if (documentSnapshot.exists) {
                            //     // Document exists, overwrite it
                            //     await testsCollection.doc('0udrDWeB2NTRglYz1E4htrucTkk2').update({
                            // 'Test_Results': provider.indexes, // Update the 'indexes' field
                            //     });
                            //   }
                            //   else {
                            //     // Document doesn't exist, create a new one
                            //     await testsCollection.doc('0udrDWeB2NTRglYz1E4htrucTkk2').set({
                            // 'Test_Results': provider.indexes,
                            //     });
                            //   }
                        var d_score = provider.indexes[2] + provider.indexes[4] + provider.indexes[9] + provider.indexes[12] + provider.indexes[15] + provider.indexes[16] + provider.indexes[20];
                        var a_score = provider.indexes[1] + provider.indexes[3] + provider.indexes[6] + provider.indexes[8] + provider.indexes[14] + provider.indexes[18] + provider.indexes[19];
                        var s_score = provider.indexes[0] + provider.indexes[5] + provider.indexes[7] + provider.indexes[10] + provider.indexes[11] + provider.indexes[13] + provider.indexes[17];
                        if (d_score <=4)
                        {
                          dep_word = "You rarely feel down, usually find joy in life, and can generally look forward to things. Moreover, ";
                        }
                        if (d_score >= 5 && d_score <=6)
                        {
                          dep_word = "You sometimes feel down, occasionally struggle to find joy, and may find it hard to feel positive. Moreover, ";
                        }
                        if (d_score >= 7 && d_score <= 10)
                        {
                          dep_word = "You often feel down, struggle to find joy, and may find it difficult to look forward to anything. Moreover, ";
                        }
                        if (d_score >= 11 && d_score <=13)
                        {
                          dep_word = "You frequently feel very down, struggle to find joy, and may feel that life lacks meaning or enthusiasm. Moreover, ";
                        }
                        if (d_score >=14)
                        {
                          dep_word = "You almost always feel deeply down, find little to no joy, and may feel that life is meaningless and without worth. Moreover, ";
                        }

                        if (a_score <=3)
                        {
                          anx_word = "you rarelyfeel anxious, almost never experience panic, and generally do not have breathing difficulties or feel scared.";
                        }
                        if (a_score >=4 && a_score <=5)
                        {
                          anx_word = "you sometimes feel anxious, may occasionally experience panic, and might notice mild trembling or slight breathing difficulties.";
                        }
                        if (a_score >= 6 && a_score <=7)
                        {
                          anx_word = "you often feel anxious, may experience panic at times, and can notice trembling, breathing difficulties, or feeling scared in certain situations.";
                        }
                        if (a_score >=8 && a_score <=9)
                        {
                          anx_word = "you almost always feel very anxious, often experience panic, and regularly have symptoms like trembling, breathing difficulties, or feeling scared without clear reasons.";
                        }
                        if (a_score >=10)
                        {
                          anx_word = "you always feel extremely anxious, often experience intense panic, and may struggle with severe trembling, breathing difficulties, and overwhelming fear.";
                        }
                        if (s_score <=7)
                        {
                          str_word = "Furthermore, you rarely feel stressed, usually remain calm, and find it easy to relax without feeling agitated or intolerant.";
                        }
                        if(s_score >=8 && s_score <=9)
                        {
                          str_word = "Furthermore, you sometimes feel stressed, may occasionally over-react, and might find it slightly difficult to relax or become agitated.";
                        }
                        if(s_score >=10 && s_score >=12)
                        {
                          str_word = "Furthermore, you often ( feel stressed, tend to over-react in certain situations, and can find it difficult to relax or may feel agitated at times.";
                        }
                        if(s_score >= 13 && s_score <= 16)
                        {
                          str_word = "Furthermore, you frequently (baar baar) feel very stressed, often over-react, and regularly struggle to relax, feeling agitated or intolerant towards interruptions.";
                        }
                        if(s_score >=17)
                        {
                          str_word = "Furthermore, you almost always (taqreeban hamesha) feel extremely stressed, frequently over-react, and find it nearly impossible to relax, feeling constantly agitated and intolerant.";
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Thank you for submitting."), // Use display name if available
                          backgroundColor: Color(0xFF05696A),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      );
                        Future.delayed(Duration(seconds: 1), () {
                            setState(() {
                            results =1;

                            });
    Navigator.of(context).pop();
    for(int i=0;i<21;i++)
    provider.setIndexes(i, -1);
                          });
                          
                      }
                      }
                      else{
                        setState(() {
                          
                      st+=4;
                                             });

                      }
                                      },
                                      child: Text(st>=17? 'Submit': 'Next',style: TextStyle(fontFamily: 'Font',fontSize: 14,color: Colors.white),),),
                    ),
                  ),
                
          ])
              
              ]),
      ))));
  }
}