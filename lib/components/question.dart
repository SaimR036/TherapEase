import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/Indexes_st.dart';
import 'package:provider/provider.dart';

class Questions extends StatefulWidget {
  late final questions;
  late int index;
  Questions({
    required this.questions,
    required this.index,
  });
  @override
  State<Questions> createState() => _QuestionState();
}

class _QuestionState extends State<Questions> {
  var email='saimr036@gmail.com';
  late var questions;
  late int index;
  var choices =['Never', 'Sometimes','Often','Almost always'];
  
  @override
  Widget build(BuildContext context) {
    var provider =  Provider.of<Indexes>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    questions = widget.questions;
    index = widget.index;
    return 
      Container(
        
        alignment: Alignment.topLeft,
        margin: EdgeInsets.fromLTRB(width*0.05,height*0.11,0,0),
        child: Column(
          children: [
          if(index==20)
           Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                alignment: Alignment.topLeft,
                    child: Text('\u2022' +questions[20]+'\n',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Font',color: Colors.white),),),
           
        Container(
          alignment: Alignment.topLeft,

          height: height*0.03,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Distribute space evenly
            children: [
              for (int i = 0; i < 4; i++)
          Container(
            decoration: BoxDecoration(
            color: provider.indexes[20] == i? Colors.green: Color(0xFF05696A) ,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black,width: 2)
            ),
            margin: EdgeInsets.only(right: width*0.02),
            child: TextButton(
              onPressed: (){
                  provider.setIndexes(20, i);

              },
              child:Text(
              choices[i]+'\n'+'\n'+'\n'+'\n',
              style: TextStyle(fontSize: 16, fontFamily: 'Font', color:  Colors.white),
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
                margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                alignment: Alignment.topLeft,
                    child: Text('\u2022' +questions[j]+'\n',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Font',color: Colors.white),),),
           
        Container(
          alignment: Alignment.topLeft,

          height: height*0.03,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Distribute space evenly
            children: [
              for (int i = 0; i < 4; i++)
          Container(
            decoration: BoxDecoration(
            color: provider.indexes[j] == i? Colors.green: Color(0xFF05696A) ,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black,width: 2)
            ),
            margin: EdgeInsets.only(right: width*0.02),
            child: TextButton(
              onPressed: (){
                  provider.setIndexes(j, i);

              },
              child:Text(
              choices[i]+'\n'+'\n'+'\n'+'\n',
              style: TextStyle(fontSize: 16, fontFamily: 'Font', color:  Colors.white),
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