import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/Indexes_st.dart';
import 'package:provider/provider.dart';

class Questions extends StatefulWidget {
  late final questions;
  late int index;
  late final dir;
  Questions({
    required this.questions,
    required this.index,
    required this.dir,
  });
  @override
  State<Questions> createState() => _QuestionState();
}

class _QuestionState extends State<Questions> {
  var email='saimr036@gmail.com';
  late var questions;
  late int index;
  var choices =['Never', 'Sometimes','Often','Almost always'];
  var urdu_choices = ['کبھی نہیں','کبھی کبھی','اکثر','تقریباً ہمیشہ' ];
  var dir;
  @override
  Widget build(BuildContext context) {
    var provider =  Provider.of<Indexes>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    questions = widget.questions;
    index = widget.index;
    dir = widget.dir;
    return 
      Container(
        height: height*0.70,
        alignment: Alignment.topCenter,
        
        child: Column(
          children: [
          if(index==20)
           Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                alignment: Alignment.topLeft,
                    child: Text('\u2022' +questions[20],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Font',color: Colors.white),),),
        SizedBox(height: height*0.02,),
        Container(
          alignment: Alignment.topLeft,
          height: height*0.1,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
            children: [
              for (int i = 0; i < 4; i++)
          Container(
            width: width*0.22,
            height: height*0.05,
            decoration: BoxDecoration(
            color: provider.indexes[20] == i? Colors.green: Color(0xFF05696A) ,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black,width: 2)
            ),
            //margin: EdgeInsets.only(right: width*0.02),
            child: TextButton(
              onPressed: (){
                  provider.setIndexes(20, i);

              },
              child:FittedBox(
                child: Text(
                choices[i],
                style: TextStyle(fontSize: 14, fontFamily: 'Font', color:  Colors.white),
                            ),
              )),
          ),
            ],
          ),

        ) ,
        Container(
          margin: EdgeInsets.only(top: height*0.2),
          alignment: Alignment.center,
          child: Text('Thank You!', style: TextStyle(color: Colors.white,fontFamily: 'Font',fontSize: 40),),)

        ],
          ),
          if(index<20)
          for(int j= index;j<index+4;j++)
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                //margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                alignment: dir=='l'?Alignment.topLeft: Alignment.topRight,
                    child: Text('\u2022' +questions[j],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,fontFamily: 'Font',color: Colors.white)
                    ,textDirection: dir=='l'? TextDirection.ltr:TextDirection.rtl,),),
        SizedBox(height: height*0.015,),
        Container(
          alignment: Alignment.topLeft,

          height: height*0.09,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space evenly
            children: [
              for (int i = dir=='l' ?0:3; dir=='l'?i < 4:i>=0; dir=='l'?i++:i--)
          Container(
            width: width*0.22,
            height: height*0.05,
            decoration: BoxDecoration(
            color: provider.indexes[j] == i? Colors.green: Color(0xFF05696A) ,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black,width: 2)
            ),
            //margin: EdgeInsets.only(right: width*0.02),
            child: TextButton(
              onPressed: (){
                  provider.setIndexes(j, i);

              },
              child:FittedBox(
                child: Text(
                dir=='l'?choices[i]:urdu_choices[i],
                style: TextStyle(fontSize: 14, fontFamily: 'Font', color:  Colors.white),
                            ),
              )),
          ),
            ],
          ),
        ) ],
          ),
        ]),
      );
  }
}