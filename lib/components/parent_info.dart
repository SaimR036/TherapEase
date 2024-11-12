import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/Info_container.dart';
import 'package:flutter_application_1/providers/enlarger_provider.dart';
import 'package:flutter_application_1/providers/parent_info_container.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ParentInfo extends StatefulWidget {
  var isUser = false;
  ParentInfo({required this.isUser});

  @override
  State<ParentInfo> createState() => _ParentInfoState();
}

class _ParentInfoState extends State<ParentInfo> {

  var search_list=[];
  var IndProvider;
 void searchName(String name) async {
  search_list = [];
  if (name.isNotEmpty) {
    print('DOCTORSSSSS');
    print(IndProvider.allDoctors);
    // Assuming IndProvider.allDoctors is a list of maps containing 'Name', 'id', and 'data'.
    final fuse = Fuzzy(IndProvider.allDoctors.map((doc) => doc['data']['Name']).toList());
    final results = fuse.search(name);
    print('RESULTS:');
    print(results);

    if (results.isNotEmpty) {
      // Take up to 3 results, or all if there are less than 3
      final filteredResults = results.take(3).toList();

      for (var val in filteredResults) {
        // Ensure you are using the correct type when accessing the original document
        var originalDocIndex = val.matches[0].arrayIndex;
        if (originalDocIndex >= 0 && originalDocIndex < IndProvider.allDoctors.length) {
          var originalDoc = IndProvider.allDoctors[originalDocIndex];
          search_list.add({
            "id": originalDoc['id'], // Assuming the original document has an 'id' field
            "data": originalDoc['data'], // Add the document data
          });
        }
      }
    }
  }

  IndProvider.setSearchList(search_list);
  print('ASDASDASDASDASDASD');
  print(IndProvider.search_list[0]['data']);
}

DateTime? _selectedDate; // To store the selected date
  List<String> _availableTimings = []; // To store timings for the selected date

  // Sample available slots data (replace with your actual data)
  final Map<DateTime, List<String>> _availableSlots = {
    DateTime(2023, 2, 19): ['5:30'],
    DateTime(2023, 2, 20): ['10:00', '14:00'],
    // ... add more available slots
  };
  DateTime _focusedDay = DateTime.now(); // Currently focused day

  TextEditingController searcher = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ParentInfoContainer>(context);
    IndProvider = Provider.of<EnlargerProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
      var enlarged_height;
  var normal_height;
var ids;
  var enlarged_width;
  var normal_width;

   enlarged_height = height * 0.5;
  normal_height = height * 0.07;
  
  enlarged_width = width *0.85;
  normal_width = width * 0.85;

  return 
Stack(
              children: [
             
          Container(
  decoration: BoxDecoration(color: Colors.white,
  borderRadius: BorderRadius.circular(10)),
  width: width * 0.7,
  height: height * 0.05,
  margin: EdgeInsets.fromLTRB(width * 0.08, height * 0.1, 0, 0),
  padding: EdgeInsets.all(width * 0.01), // Changed to all for uniform padding
  child: TextField(
    
    controller: searcher,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Search',
      hintStyle: TextStyle(color: Colors.black),
    ),
    onSubmitted: (value) {
      provider.toggeCalendarShow(-1);
      IndProvider.toggleInd(-1);
      provider.toggleisLoading(true);
      searchName(value);
      provider.toggleisLoading(false);
      provider.toggleSearchOne(true);
    },
  ),
),


           Container(
  decoration: BoxDecoration(
    color: Color(0xFF29BDBD),
    borderRadius: BorderRadius.circular(10),
  ),
  width: width * 0.10,
  height: height * 0.05,
  margin: EdgeInsets.fromLTRB(width * 0.82, height * 0.1, 0, 0),
  child: FittedBox(
    child: IconButton(
      onPressed: ()
    {
    searcher.text = '';
      provider.toggleSearchOne(false);
      provider.toggeCalendarShow(-1);
      IndProvider.toggleInd(-1);
    }, icon: Icon(Icons.refresh_outlined,)),
  )
),
            // Container(
            //   decoration: BoxDecoration(color: Color(0xFF29BDBD),
            //   borderRadius: BorderRadius.circular(10)
            //   ),
            //   width: width*0.15,
            //   height: height*0.05,
            //   margin:EdgeInsets.fromLTRB(width*0.78,height*0.1,0,0),
            //   child:TextButton(onPressed:(){},
            //   child:Text('Type',style: TextStyle(
            //     fontSize: 20,
            //     fontFamily: 'Font',color: Colors.white),)
            //   )


            // ),,
            Align(
              alignment: Alignment.topCenter,
              child: provider.isLoading==true? 
              Container(
                
                margin: EdgeInsets.fromLTRB(0,height*0.4,0,0),
                child:  CircularProgressIndicator(color: Colors.white,)):
              
               Container(
               
                margin: EdgeInsets.fromLTRB(0,height*0.13,0,0),
                child:  IndProvider.allDoctors.length!=0?
                ListView.builder(
                      itemCount: provider.search_one==true? IndProvider.search_list.length: /*type=='All'?*/  IndProvider.allDoctors.length/*: IndProvider.allDoctors.where((doctor) => doctor['Profession'].toLowerCase() == type.toLowerCase()).toList().length*/,
                      itemBuilder: (context, index) {
                        print(IndProvider.allDoctors);
                        var isSelected=false;
                        var doctor = provider.search_one==true? IndProvider.search_list[index]["data"] :/*type=='All'?*/  IndProvider.allDoctors[index]["data"] ;/*: IndProvider.allDoctors.where((doctor) => doctor['Profession'].toLowerCase() == type.toLowerCase()).toList()[index];*/
                        var id = provider.search_one==true? IndProvider.search_list[index]["id"] :/*type=='All'?*/  IndProvider.allDoctors[index]["id"] ;/*: IndProvider.allDoctors.where((doctor) => doctor['Profession'].toLowerCase() == type.toLowerCase()).toList()[index];*/


                        return 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[TextContainer(id:id,isSelected:false,isUser: widget.isUser,height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: provider.show,index:index, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width)
                    ,AnimatedContainer(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(width*0.075,0,0,0),
                    color: Color(0xFF267979),
                    width: width*0.25,
                    duration: Duration(milliseconds: 200),
                  child:TextButton.icon(onPressed: (){
                         if(IndProvider.ind==index)
                      {
                        provider.toggleAlotDate("");
                        IndProvider.toggleInd(-1);
                         provider.toggeCalendarShow(-1);
                        //_enlarged=false;
                       Future.delayed(Duration(milliseconds: 700),(){
              provider.toggleShow(false);
            });
                      }
                      else{
                        provider.toggleAlotDate("");
                        print(index);
                                                IndProvider.toggleInd(index);
                        provider.toggeCalendarShow(-1);
                        //_enlarged=true;
                      Future.delayed(Duration(milliseconds: 200),(){
                      provider.toggleShow(true);
            
                      });
                      }

                  }, label: FittedBox(child: Text('Reviews',style: TextStyle(color: Colors.white),)),icon:  Icon(IndProvider.ind==index?Icons.arrow_drop_up: Icons.arrow_drop_down,color: Colors.black,),)
                  
                  )
                    ]
                     );
                     
        
                     
                      },
                    ):
                
                
                
                
                
                
                  StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (!snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                        child: Center(child: CircularProgressIndicator(color: Colors.white,)));
                    }
                    
                     // IndProvider.toggleAllDoctors(allDoctors);

                    
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Future.delayed(Duration.zero,(){
                        IndProvider.toggleAllDoctors( snapshot.data!.docs.map((doc) {
      return {
        "id": doc.reference.id,
        "data": doc.data(), // Document data
      };
    }).toList());});

                        var doctor = snapshot.data!.docs[index];
                        var id = snapshot.data!.docs[index].reference.id;
                      //  doctor = doctor.data();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                    children:[TextContainer(id:id, isSelected:false,isUser: widget.isUser,height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: provider.show,index:index, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width)
                    ,AnimatedContainer(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(width*0.075,0,0,0),
                    color: Color(0xFF267979),
                    width: width*0.25,
                    duration: Duration(milliseconds: 200),
                  child:TextButton.icon(onPressed: (){

                    setState(() {
                      
                    });
                         if(IndProvider.ind==index)
                      {
                        provider.toggleAlotDate("");
                        IndProvider.toggleInd(-1);
                         provider.toggeCalendarShow(-1);
                        //_enlarged=false;
                       Future.delayed(Duration(milliseconds: 700),(){
              provider.toggleShow(false);
            });
                      }
                      else{
                        provider.toggleAlotDate("");
                        print(index);
                                                IndProvider.toggleInd(index);
                        provider.toggeCalendarShow(-1);
                        //_enlarged=true;
                      Future.delayed(Duration(milliseconds: 200),(){
                      provider.toggleShow(true);
            
                      });
                      }

                  }, label: FittedBox(child: Text('Reviews',style: TextStyle(color: Colors.white),)),icon:  Icon(IndProvider.ind==index?Icons.arrow_drop_up: Icons.arrow_drop_down,color: Colors.black,),)
                  
                  )
                    ]
                     ); },
                    );
                  },
                )
              ),
            ),
            

              ]);
       
          
          
  }
}