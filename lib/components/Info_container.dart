import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/enlarger_provider.dart';
import 'package:flutter_application_1/providers/parent_info_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// Define the reusable Container component
class TextContainer extends StatefulWidget {
  late final bool show;
  late final int index;
  late final double enlargedWidth;
  late final double enlargedHeight;
  late final double normalWidth;
  late final double normalHeight;
  late final double height;
  late final double width;
  late  var doctor;
  var isSelected;
  var isUser;
  TextContainer({
    required this.show,
    required this.index,
    required this.enlargedWidth,
    required this.enlargedHeight,
    required this.normalWidth,
    required this.normalHeight,
    required this.isSelected,
    required this.height,
    required this.width,
    required this.doctor,
    required this.isUser
  });
  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
    late bool show;
    var slots;
var Slots;
  var selected=0;
  late int index;
  late double enlarged_width;
  late double enlarged_height;
  late double normal_width;
  late double normal_height;
  late double height;
  late double width;
  var time='';
  late var doctor;
  late List search_list;
    var isSelected;

  DateTime _focusedDay = DateTime.now(); // Currently focused day
  DateTime? _selectedDay; // Selected day (if any)
  late List allDoctors;
var enlarge= false;

var opened=false;
 
  var date='';
void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }
  var parentProvider;
void _showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,  // Prevent closing when tapping outside the dialog
    builder: (BuildContext context) {
      return
Center(
                          child: Container(
                              alignment: Alignment.center,
                                                  width: width*0.6,
                                                   height: height*0.4,
                                                  
                                                  decoration: BoxDecoration(color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.black,width: 2)
                                                  ),
                                                  child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(children:[
                                
                                IconButton(onPressed: (){
                                                        parentProvider.toggleAlotDate("");
                                                      Navigator.of(context).pop();
                          
                              
                                                      }, icon: Icon(Icons.arrow_back)),
                                                    
                                                    
                                                    FittedBox(
                          
                                                      child: Container(
                                                        width: width*0.5,
                                                        //margin: EdgeInsets.only(left: width*0.03),
                                                        alignment: Alignment.topCenter, child: Text(parentProvider.alotDate,style: TextStyle(fontFamily: 'Font',fontWeight: FontWeight.bold),)),
                                                    )
                            ])
                                                  , 
                                                  Container(
                                                    alignment: Alignment.topCenter,
                                                    //margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                                                    child: Text('Slots',style: TextStyle(fontFamily: 'Font',fontSize: 22,fontWeight: FontWeight.bold),))
                                                  ,
                                                  Container(                            
                                                    width: width*0.3,
                                                    height: height*0.16,
                                                    //margin: EdgeInsets.fromLTRB(width*0.05, height*0.11,0,0),
                                                    child: ListView.builder(
                                                                          itemCount: Slots.length,
                                                                          itemBuilder: (context, index) {
                                                                            var slot = Slots[index];
                                                                            return Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                color: selected==index? Colors.green:Colors.transparent),
                                                                              child: TextButton(
                                                                                onPressed: (){
                                                                                  setState(() {
                                                                                    time=slot;
                                                                                  selected= index;
                                                                  });
                                                                                },
                                                                                child:Text(slot,style: TextStyle(fontFamily: 'Font',color: Colors.black,fontSize: 15),)
                                                                              ),
                                                                            );}),
                                                                            
                                                  ),
                          Center(
                            child: Container(
                              width: width*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF05696A)
                            ),
                            alignment: Alignment.topCenter,
                            
                            child: TextButton(onPressed: ()
                            async{
DocumentReference doctorRef = FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2');
DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc('0udrDWeB2NTRglYz1E4htrucTkk2');
String doctorName='';
String userName='';
var profession='';

    // Fetch the doctor document
    DocumentSnapshot doctorSnapshot = await doctorRef.get();
    if (doctorSnapshot.exists) {
        profession = doctorSnapshot['Profession'];
       doctorName= doctorSnapshot['Name']; // Assuming 'name' is the field
      print('Doctor Name: $doctorName');
    } else {
      print('Doctor document does not exist.');
    }

    // Fetch the user document
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      userName = userSnapshot['name']; // Assuming 'name' is the field
      print('User Name: $userName');
    } else {
      print('User document does not exist.');
    }
 
 

    String pname = userName; // Replace with actual patient's name
    String date = parentProvider.alotDate;
   String dName = doctorName;  // Replace with the doctor's name
    String userId = "0udrDWeB2NTRglYz1E4htrucTkk2";       // Replace with actual user ID
    String doctorId = "0udrDWeB2NTRglYz1E4htrucTkk2";   // Replace with actual doctor ID
    String Link='';
 List<dynamic> slots = doctorSnapshot['Slots']; // Assuming 'slots' is the field name
      
      for (var i = 0; i < slots.length; i++) {
        var slot = slots[i];

        if (slot['Date'] == date && slot['Time'] == time) {
          // Set booked status to 1
          Link = slot['Link'];
          break;
        }
      }

 
    // Reference to the doctor's document in Firestore

    // Reference to the user's document in Firestore

    // The new appointment map for the doctor
    Map<String, String> doctorAppointment = {
      'Pname': pname,
      'Date': date,
      'Time': time,
      'Link': Link,
      'Note': 'New person'
    };

    // The new appointment map for the user
    Map<String, String> userAppointment = {
      'Doctor': dName,
      'Date': date,
      'Time': time,
      'Link': Link,
    };

    // Update the doctor's appointments array
    await doctorRef.update({
      'Appointments': FieldValue.arrayUnion([doctorAppointment])
    }).then((_) {
      print('Doctor\'s appointment added successfully');
    }).catchError((error) {
      print('Failed to add doctor\'s appointment: $error');
    });

    // Update the user's appointments array
    await userRef.update({
      'Appointments': FieldValue.arrayUnion([userAppointment])
    }).then((_) {
      print('User\'s appointment added successfully');
    }).catchError((error) {
      print('Failed to add user\'s appointment: $error');
    });
      
      // Find the slot with the specified date and time
      bool slotFound = false;
      for (var i = 0; i < slots.length; i++) {
        var slot = slots[i];

        // Check if the slot matches the specified date and time
        if (slot['Date'] == date && slot['Time'] == time) {
          // Set booked status to 1
          slot['Booked'] = 1; // Update the slot to booked
          slotFound = true;
          break;
        }
      }

      if (slotFound) {
        // Update the doctor's document with the modified slots array
        await doctorRef.update({
          'Slots': slots, // Save the modified slots array
        });
        print('Slot booked successfully!');
      }
    // You can also show a confirmation message or snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Appointment added successfully!"),
        backgroundColor: Color(0xFF05696A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
Navigator.of(context).pop();

                            }, child: Text('Get Link!',style: TextStyle(color: Colors.white,fontFamily: 'Font'),)),),
                          ) 
                                                  ]),
                                                ),
                        );
});}



  @override
  Widget build(BuildContext context) {
    var IndProvider = Provider.of<EnlargerProvider>(context);
    show = widget.show;
    
    index = widget.index;
    enlarged_width = widget.enlargedWidth;
    enlarged_height = widget.enlargedHeight;
    normal_width = widget.normalWidth;
    normal_height = widget.normalHeight;
    height = widget.height;
    width = widget.width;
    doctor = widget.doctor;
    search_list = IndProvider.search_list;
    allDoctors = IndProvider.allDoctors;
    parentProvider = Provider.of<ParentInfoContainer>(context);
        return Align(
                  alignment:  Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                  border: Border.all(  // Use Border.all to create the border
                  color: Colors.white, 
                  width: 2.0,          // Specify the width of the border
                  ),   
                gradient: LinearGradient( // Define a LinearGradient
                  begin: Alignment.centerLeft, // Start from the left
                  end: Alignment.centerRight,   // End on the right
                  colors: [
                    Color(0xFF267979), // Start color (left)
                    Color(0xFF29BDBD), // End color (right)
                  ], // Add more colors for complex gradients
                ),
              ),
                    margin: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                    height: IndProvider.ind==index? enlarged_height: normal_height,
                    
                    width: IndProvider.ind==index? enlarged_width: normal_width,
                   
                 
                child:Stack(
                      
                      children: [
                    AnimatedContainer(
            
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                      width: IndProvider.ind==index? width*0.13: width*0.10,
                      height:  IndProvider.ind==index? height*0.09:height * 0.1,
                      padding: EdgeInsets.fromLTRB(0,0,5,0),
                      margin: EdgeInsets.fromLTRB(normal_width*0.03,IndProvider.ind==index?normal_height*0.02: normal_height*0.1,0,normal_height*0.1),
                      child:CircleAvatar(child:Text('HI'))),
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
                        width: IndProvider.ind==index? width*0.45: width*0.4,
                        height:  IndProvider.ind==index? height*0.06:height * 0.04,
                        
                        padding: EdgeInsets.fromLTRB(0, 0,0,0),
                        margin: EdgeInsets.fromLTRB(normal_width*0.19,IndProvider.ind==index?normal_height*0.008: normal_height* 0.06, 0,0),
                        child: FittedBox( // <-- Add FittedBox widget
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dr. '+doctor['Name'],
                          
                  
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Font',
                          ),
                        ),)),
                    
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
            
                      width: IndProvider.ind==index? width*0.38:width*0.32,
                      height: IndProvider.ind==index? height*0.03:height * 0.02,
                      padding: EdgeInsets.fromLTRB(0.0001, 0,0,0),
                      
                      margin: EdgeInsets.fromLTRB(normal_width*0.19,IndProvider.ind==index?normal_height*0.65: normal_height* 0.56, 0,0),
                      child: FittedBox( // <-- Add FittedBox widget
                      alignment: Alignment.centerLeft,
                      child: Text(
                        doctor['Profession'],
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFCECECE),
                          fontFamily: 'Font',
                        ),
                      ),)),              
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 700,microseconds:0),
            
                      width: IndProvider.ind==index? width*0.09: width*0.08,
                      height:  IndProvider.ind==index? height*0.03:height * 0.02,
                      margin: EdgeInsets.fromLTRB(IndProvider.ind==index? width*0.52: width*0.50,IndProvider.ind==index?normal_height*0.65: normal_height* 0.56, 0,0),
                      child: FittedBox( // <-- Add FittedBox widget
                      alignment: Alignment.centerLeft,
                      child: Text(
                        doctor['Rating'].toString(),
                        style: TextStyle(
                          color: Color(0xFFCECECE),
                          fontFamily: 'Font',
                        ),
                      ),)),     
                    Container(
                      height: height*0.01,
                      width: width*0.01,
                      margin: EdgeInsets.fromLTRB(normal_width*0.73,normal_height* 0.38, 0,0),
                      // child: Image.asset('lib/assets/star.png'),),
                                  ),

                    AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color:  widget.isUser==true? parentProvider.calendar_show==index? Colors.blueGrey:Color(0xFF05696A):   doctor['Ban']==0? Color(0xFF9B111E): Color(0xFF0F5132)
                        ),
                        width: normal_width*0.20,
                        height:  normal_height* 0.7,
                        margin:
                         EdgeInsets.fromLTRB(IndProvider.ind==index? normal_width*0.77: normal_width*0.74,IndProvider.ind==index? normal_height*0.3: normal_height*0.1, 0,normal_height*0.1),
                        child:
                        widget.isUser==true?
                        FittedBox(
                          child: TextButton.icon( // Use TextButton.icon for both text and icon
                            onPressed: () async{

                              if(parentProvider.calendar_show== index && IndProvider.ind==index && opened==false)
                              {
                                print('yay1');
                                parentProvider.toggleAlotDate("");
                                parentProvider.toggeCalendarShow(-1);
                                //IndProvider.toggleInd(-1);
                              }//turn off calendar
                              else if(IndProvider.ind == index && parentProvider.calendar_show!=index)
                              {
                                DocumentReference docRef = FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2');

  try {
    // Get the document snapshot
    DocumentSnapshot docSnapshot = await docRef.get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Retrieve the 'Slots' field, which is expected to be a list of maps
      setState(() {
        slots = docSnapshot['Slots'];
      });
      
      print(slots);
      if (slots != null) {
        // Return the list of slots
      } else {
        print("No slots found.");
        return null; // No slots found
      }
    } else {
      print("Document does not exist.");
      return null; // Document does not exist
    }
  } catch (error) {
    // Handle any errors that occur
    print("Error retrieving slots: $error");
    return null; // Return null on error
  }
                                          print('yay4');
                          parentProvider.toggleAlotDate("");
                                parentProvider.toggeCalendarShow(index);  
                          
                                }//open and turn on calendar
                              else if(parentProvider.calendar_show==index && IndProvider.ind==index && opened==true)
                              {
                                print('yay2');
                                parentProvider.toggleAlotDate("");
                                parentProvider.toggeCalendarShow(-1);
                                IndProvider.toggleInd(-1);
                                opened=false;
                              } //close and turn off calendar
                              else if(IndProvider.ind != index && parentProvider.calendar_show!=index)
                              {

                                DocumentReference docRef = FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2');

  try {
    // Get the document snapshot
    DocumentSnapshot docSnapshot = await docRef.get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Retrieve the 'Slots' field, which is expected to be a list of maps
      setState(() {
        slots = docSnapshot['Slots'];
      });
      
      print(slots);
      if (slots != null) {
        // Return the list of slots
      } else {
        print("No slots found.");
        return null; // No slots found
      }
    } else {
      print("Document does not exist.");
      return null; // Document does not exist
    }
  } catch (error) {
    // Handle any errors that occur
    print("Error retrieving slots: $error");
    return null; // Return null on error
  }
                                print(IndProvider.ind);
                                print(index);
                                      print('yay3');
                          parentProvider.toggleAlotDate("");
                                IndProvider.toggleInd(index);
                          
                                opened=true;
                                Future.delayed(Duration(milliseconds: 300),(){
                                parentProvider.toggeCalendarShow(index);  
                                });
                                }//open and turn on calendar
                                
                            },
                            icon: parentProvider.calendar_show==index?Icon(Icons.arrow_upward_sharp,color: Colors.white,size: 8,): Icon(Icons.arrow_drop_down,color: Colors.white,size: 8,) // Down arrow icon
                            ,label: Text('Select Slots',style: TextStyle(fontSize: 30, fontFamily: 'Font',color: Colors.white)), // Text label
                          ),
                        )
                        :TextButton(
                                
                                child: Text(doctor['Ban']==0? 'Ban': 'Unban',style: TextStyle(fontFamily: 'Font',color: Colors.white),),
                                onPressed: ()
                                async{
                                  if (doctor['Ban']==0)
                                  {

                                  await FirebaseFirestore.instance
        .collection('Doctors') // Replace with your collection name
        .doc(doctor['Email'])
        .update({'Ban': 1});
        if (search_list.length>0)
        {
        IndProvider.toggleBanAllDoctors(search_list[index],1);

        }
        else{
        IndProvider.toggleBanAllDoctors(index,1);
                             }                     }
                                  else{
                                    await FirebaseFirestore.instance
        .collection('Doctors') // Replace with your collection name
        .doc(doctor['Email'])
        .update({'Ban': 0});

        if (search_list.length>0)
        {
        IndProvider.toggleBanAllDoctors(search_list[index],0);

        }
        else{
        IndProvider.toggleBanAllDoctors(index,0);
                             } 

                                  }
                                 
                                },
                                ),),
                   
                    if (parentProvider.show==true && IndProvider.ind ==index)
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),
            
                      height: height*0.1,
                      width:  width*0.5,
            
                      margin: EdgeInsets.fromLTRB(enlarged_width*0.03,enlarged_height* 0.26, 0,0),
                      child: Text('Customer Reviews',style: TextStyle(fontFamily: 'Font',fontSize: 20,color: Colors.white,),)
            
                    ),
                    if (parentProvider.show==true && IndProvider.ind ==index)
                    AnimatedContainer(
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),
                      color: Colors.black,
                      height: height*0.001,
                      width:  width*0.75,
                      
                      margin: EdgeInsets.fromLTRB(enlarged_width*0.03,enlarged_height* 0.35, 0,0),
                      child: Text('',style: TextStyle(fontFamily: 'Font',fontSize: 20,color: Colors.white,),)
            
                    ),

                     if (parentProvider.show==true && IndProvider.ind ==index)

                    Container(
                      margin: EdgeInsets.fromLTRB(0,enlarged_height* 0.38, 0,0),
            
                      child: ListView.builder(
                    itemCount: doctor['Reviews'].length,
                    itemBuilder: (context, index) {
                      print(doctor['Reviews'].length);
                      var Review =  doctor['Reviews'].length > 0 ?doctor['Reviews'][index]:null;
                      return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.teal.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Review == null?'No Reviews yet':Review['Name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                           Review == null?'':Review['Description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                  ),
                ),
                      );
                    },
                  ),
                    ),
                                  
                    if(IndProvider.ind ==index && parentProvider.calendar_show==index)
                    AnimatedContainer(
                      height: height*0.4,
                      
                      margin: EdgeInsets.fromLTRB(width*0.05,height*0.09,0,0),
                      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,),
                      
            
                      //margin: EdgeInsets.fromLTRB(enlarged_width*0.03,enlarged_height* 0.26, 0,0),
                      child: SizedBox(
                        width: width*0.75,
                        child: TableCalendar(
                          calendarBuilders: CalendarBuilders(
    defaultBuilder: (context, day, focusedDay) {
      String formattedDay = DateFormat('EEEE, MMMM d, y').format(day);

          // Check if the calendar day matches any of the slot dates
          bool isSlotDay = slots.any((slot) => slot['Date'] == formattedDay);

          // If the day matches a slot's date, apply a custom style or decoration
          if (isSlotDay) {
        return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.green, // Color for dates with available slots
            shape: BoxShape.circle
          ),
          child: InkWell(
            radius: 50,
            onTap:(){ 
              String selectedDate = DateFormat('EEEE, MMMM d, y').format(day);
              var matchingSlots = slots.where((slot) => slot['Date'] == formattedDay).toList();
              setState(() {
                Slots = matchingSlots.map((slot) => slot['Time'] as String).toList();
              }); 
              parentProvider.toggleAlotDate(selectedDate); _showCustomDialog(context);},
              
            child:Text('${day.day}',
            style: TextStyle(color: Colors.white),
          )),
        );}}),
                          availableCalendarFormats: const {CalendarFormat.month:'Month'},
                          calendarStyle: CalendarStyle(),
                          shouldFillViewport: true,
                          daysOfWeekHeight: height*0.03,
                          rowHeight: height*0.03,
                                          firstDay: DateTime.now(),
                                          lastDay: DateTime.utc(2030,3, 14),
                                          focusedDay: _focusedDay,
                                          selectedDayPredicate: (day) 
                         {
                                            // highlight selected day
                                            return isSameDay(_selectedDay, day);
                                          },
                                          onDaySelected: (selectedDay, focusedDay) {
                                            // if (!_availableSlots.contains(selectedDay)) {
                                            //   // Prevent selection of unavailable slots
                                            //   return; 
                                            // }
                                            }),
                      )),
                        
                      ])));
                                            
                                            
                    
                                        
                        
                  
                                   
                  
                  
            
                
                
                  
                
  
  }
}
