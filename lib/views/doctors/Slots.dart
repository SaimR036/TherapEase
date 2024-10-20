import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:googleapis_auth/auth_io.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
class DrSlots extends StatefulWidget {
  const DrSlots({super.key});

  @override
  State<DrSlots> createState() => _DrSlotsState();
}

class _DrSlotsState extends State<DrSlots> {
 final GoogleSignIn _googleSignIn = GoogleSignIn(
    //clientId: '83438011766-6cimophoh625rhcbiqemfpc17v736ouq.apps.googleusercontent.com',
    scopes: [cal.CalendarApi.calendarEventsScope],
  );
  var calendar;


    List<EventAttendee> attendees = [
      EventAttendee(email: 'saimr036@gmail.com'),
      EventAttendee(email: 'saimur036@gmail.com')
    ];

 Future<String> GetMeetLink()
  async {
                try {
                  await _googleSignIn.signOut();
                  // Start the Google Sign-In process
                  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                  if (googleUser == null) {
                    // The user canceled the sign-in
                    return '';
                  }

                  // Obtain the auth details from the request
                  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                  // Create an authenticated HTTP client
                  final authClient = authenticatedClient(
                    http.Client(),
                    AccessCredentials(
                      AccessToken(
                        'Bearer', // Set the token type to 'Bearer'
                        googleAuth.accessToken!, // Access token
                        DateTime.now().toUtc().add(Duration(hours: 1)), // Set expiration to 1 hour
                      ),
                      googleAuth.idToken, // ID token
                      [cal.CalendarApi.calendarEventsScope], // Scopes
                    ),
                  );

                  // Create the calendar API client
                  calendar = cal.CalendarApi(authClient);

                  // Create a new event
                  Event event = Event();
                  event.description = "Therapy Class";
                  event.location = "Online";
                  event.start = EventDateTime(
                      dateTime: DateTime(2024, 8, 4, 21, 0),
                      timeZone: 'Asia/Karachi');
                  event.end = EventDateTime(
                      dateTime: DateTime(2024, 8, 4, 21, 30),
                      timeZone: 'Asia/Karachi');
                  event.conferenceData = ConferenceData(
                    createRequest: CreateConferenceRequest(
                      requestId: "sample123",
                      conferenceSolutionKey: ConferenceSolutionKey(type: "hangoutsMeet"),
                    ),
                  );
                  event.attendees = attendees;

                  // Insert the event into the calendar
                  final value = await calendar.events.insert(event, "primary", conferenceDataVersion: 1, sendUpdates: "all");
                  print("Event Status: ${value.status}");
                  if (value.status == "confirmed") {
                    var joiningLink = value.conferenceData?.entryPoints?.first.uri;
                    print("Joining Link: $joiningLink");
                    return joiningLink;
                    
                  } else {
                    print("Unable to add event to Google Calendar");
                  }
                } catch (e) {
                  print('Error: $e');
                }
              return '';
}
 



var _priceController = TextEditingController();
  var display = false;
  var display_str = '';
  var display_calendar = false;
  DateTime _focusedDay = DateTime.now(); // Currently focused day
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;
  var finaltime = '';
  // Helper function to display the date and time
  String formatSelectedDateTime(BuildContext context) {
  if (_selectedDay != null && _selectedTime != null) {
    // Format the date part (e.g., Monday, October 9, 2023)
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(_selectedDay!.toLocal());

    // Format the time part using TimeOfDay's format method
    String formattedTime = _selectedTime!.format(context);
    setState(() {
      finaltime = "$formattedDate; $formattedTime";
    });
    // Combine both date and time in a readable format
    return "$formattedDate; $formattedTime";
  }
  return ''; // Return empty string if date or time is not selected
}
 Future<void> addSlotToFirebase(link,price) async {

      // Define the slot to add
      Map<String, String> slot = {
        'Date': finaltime.split(';')[0],
        'Time': finaltime.split(';')[1],
        'Booked':'0',
        'Link':link,
        'Price':price
      };

      // Reference to the Firebase document (you can adjust the path to match your structure)
      var doctorId = '0udrDWeB2NTRglYz1E4htrucTkk2'; // Replace with dynamic ID if needed
      var docRef = FirebaseFirestore.instance.collection('Doctors').doc(doctorId);

      // Add the slot to the 'Slots' array in Firebase
       try {
    // Get the current Slots array
    DocumentSnapshot docSnapshot = await docRef.get();
    List<dynamic>? currentSlots = docSnapshot['Slots'];
    print(currentSlots);
    // Check if the slot already exists
    bool slotExists = false;

    if (currentSlots != null) {
      for (var existingSlot in currentSlots) {
        // Check if the existing slot matches the new slot
        if (existingSlot['Date'] == slot['Date'] && existingSlot['Time'] == slot['Time']) {
          slotExists = true;
          break; // Exit loop if a match is found
        }
      }
    }

    if (slotExists) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Slot already exists!"), // Message for existing slot
          backgroundColor: Colors.blueGrey,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
    } else {
      // Add slot to the Slots array
      await docRef.update({
        'Slots': FieldValue.arrayUnion([slot]) // Add slot to the Slots array
      });

      // Show a Snackbar indicating the slot was added successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Slot Added Successfully!"), // Success message
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
      print('Slot added successfully: $slot');
    }
  } catch (error) {
    // Handle any errors that occur
    print('Failed to add slot: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Failed to add slot: $error"), // Error message
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
  }
  var width;
  var height;

Future<void> _showCustomDialog(BuildContext context,slot) async {
   showGeneralDialog(
  context: context,
  barrierDismissible: false,
  barrierColor: Colors.black54,
  transitionDuration: Duration(milliseconds: 200),
  pageBuilder: (context, animation, secondaryAnimation) {
    return Center(
      child: AlertDialog(  // Static content here
        title: slot!=null?Text('Delete Slot?',style: TextStyle(color: Colors.black),):Text('Slot Confirmation',style: TextStyle(color: Color(0xFF05696A)),),
        content: Container(
          height:  slot!=null? null:height*0.17,
          child: slot!=null?Text(slot['Date']+';'+slot['Time'],style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold)):
          Column(children: [
          Text(finaltime,style: TextStyle(color: Color(0xFF05696A),fontSize: 20,fontWeight: FontWeight.bold)),
          Row(children: [
            Text('Price',style: TextStyle(color: Color(0xFF05696A),fontSize: 20,fontWeight: FontWeight.bold)),
            //TextField here
          SizedBox(width: 16.0),
                            Container(
                              height: height*0.1,
                              width: width*0.5,
                              child: TextField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Enter price',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
          
          ],)
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel',style: TextStyle(color: Color(0xFF05696A)))),
          TextButton(onPressed: ()async{
        if (slot==null)
        {
          String link = await GetMeetLink();
          if(_priceController.text.isEmpty)
          {
               ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a price"), // Success message
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
      return;
          }
          else if (link=='')
          {
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Link Generation Failed, Try again!"), // Success message
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
      return;
          }
          else
          {
        addSlotToFirebase(link,_priceController.text);
          }
          }
        else
        {
             var docRef = FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2');
                                  await docRef.update({
        'Slots': FieldValue.arrayRemove([slot])
      });

      // Show a Snackbar indicating the slot was deleted successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Slot deleted successfully!"), // Success message
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
 
        }
        Navigator.of(context).pop();
          }
          , child: slot!=null? Text('Delete',style: TextStyle(color: Color(0xFF05696A))):Text('Generate Link and add Slot',style: TextStyle(color: Color(0xFF05696A)))),
        ],
      ),
    );
  },
  
  transitionBuilder: (context, animation, secondaryAnimation, child) {
    return ScaleTransition(  // Animation applied to the content
      scale: CurvedAnimation(
        
        parent: animation,
        curve: Curves.easeInOut,
      ),
      child: child,  // "child" is the widget returned by the pageBuilder
    );
  },
);

}



  // Function to show time picker
 Future<void> _selectTime(BuildContext context) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Color(0xFF05696A).withOpacity(0.4), // Semi-transparent background
    transitionDuration: Duration(milliseconds: 300), // Animation duration
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center();  // Required but left empty because transitionBuilder manages the content
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition( // You can change this to SlideTransition, FadeTransition, etc.
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut, // Customize the animation curve
        ),
        child: Container(
          height: height*0.3,
          width: width*0.25,
          child: Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF05696A), // Set the primary color to green
            colorScheme: ColorScheme.light(primary: Color(0xFF05696A)), // Set color scheme
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal), // Make button text primary
          ), child:TimePickerDialog( // Embedding the TimePickerDialog
              initialTime: TimeOfDay.now(),
            )),
        ),
      );
    },
  ).then((pickedTime) {
    if (pickedTime != null && pickedTime is TimeOfDay) {
      setState(() {
        _selectedTime = pickedTime;
        // Update the display string with both date and time
        display_str = formatSelectedDateTime(context);
      });
      _showCustomDialog(context,null);
    }
    
  },
  
  );
}
  var enlarge=false;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      //bottomNavigationBar: BottomNavbar(),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: FittedBox(child: Text('Slots',style: TextStyle(color: Colors.white, fontSize: 40),),)),
               SizedBox(height: height*0.03,),
              AnimatedContainer(
                margin: EdgeInsets.only(left: width*0.075),
                alignment: Alignment.topCenter,
                width: width*0.85,
                height: enlarge==true? height*0.65: height*0.1,
                    duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 500,microseconds:0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                  border: Border.all(  // Use Border.all to create the border
                  color: Colors.white, 
                  width: 2.0,          // Specify the width of the border
                  )),
                child: SingleChildScrollView(
                  child: Column(
                    
                  children: [
                    TextButton(onPressed: (){
                        setState(() {
                          if(enlarge)
                          {
                          setState(() {
                            enlarge=false;
                          });
                  
                          }
                          else if(!enlarge)
                          {
                             setState(() {
                              enlarge=true;
                          });
                          
                          }
                                
                        });
                    }, child: FittedBox(child: Text('Add a Slot',style: TextStyle(color: Colors.white, fontSize: 40)))),
                
                  if(enlarge)
                    Container(
                                  height: height*0.52,
                    width: width*0.8,
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF17A2A3)
                    ),
                    child: TableCalendar(
                      
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
        
                          return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: (isSameDay(focusedDay, day) ? Color(0xFF17A2A3) : Colors.green),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              radius: 50,
                              onTap: () {
                                setState(() {
                                  _selectedDay = day;
                                  //display = true;
                                  display_str = formatSelectedDateTime(context); // Update date in string
                                   _selectTime(context);
                                });
                              },
                              child: Text(
                                '${day.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                      calendarStyle: CalendarStyle(),
                      shouldFillViewport: true,
                      daysOfWeekHeight: height * 0.03,
                      rowHeight: height * 0.03,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                    ),
                                  ),
                  
                                
                  ],
                                ),
                ),),
                SizedBox(height: height*0.05,),
              Container(
              margin: EdgeInsets.only(left: width*0.075),
                alignment: Alignment.topLeft,
                width: width*0.4,
                height: height*0.1, 
                child: FittedBox(child: Text('Slots Details',style: TextStyle(color: Colors.white,fontSize: 30),)),),
               Container(
                  width: width*0.85,
                  height: height*0.5,
                  margin: EdgeInsets.only(left: width*0.075),
                  child: StreamBuilder( //
                      stream: FirebaseFirestore.instance.collection('Doctors').doc('0udrDWeB2NTRglYz1E4htrucTkk2').snapshots(),
                      builder: (context,  snapshot) {
                  
                        if (!snapshot.hasData) {
                          return Container(
                            width: width*0.1,
                            
                            margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                            child: CircularProgressIndicator(color: Colors.white,));
                        }
                        var details = snapshot.data!.data() as Map<String, dynamic>;
                        List<dynamic> Slots = details['Slots'];
                        return Container(
                          
                          child: ListView.builder(
                            itemCount: Slots.length,
                            itemBuilder: (context, index) {
                              var Slot  = Slots[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: height*0.03),
                                decoration: BoxDecoration(
                  
                                  color: Slot['Booked']=='0'?Colors.green: Color(0xFF05696A),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                width: width*0.9,
                                
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                  children: [
                                Container(
                                margin: EdgeInsets.only(left: width*0.02),
                                width: width*0.5,
                                height: height*0.05,
                                child: Text(Slot['Date'],style: TextStyle(color: Colors.white,fontSize: 18),)),
                                SizedBox(width: width*0.07,),
                                Container(
                                  
                                  alignment: Alignment.topRight,
                                margin: EdgeInsets.fromLTRB(0,0,0,0),
                                width: width*0.23,
                                child: Text(Slot['Time'],style: TextStyle(color: Colors.white,fontSize: 18),)),
                                  ]), 
                                  Row(
                                   // mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                if(Slot['Booked']=='0')
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(10)),
                                  child: FittedBox(child: TextButton(onPressed: ()async{
                                 _showCustomDialog(context, Slot);

                                }, child: Text('Delete',style: TextStyle(color: Colors.white),)),),)
                              ,Container(
                                //width: width*0.3,
                                alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(left: width*0.02),
                                  child: FittedBox(child:  Text('Rs. '+Slot['Price'],style: TextStyle(color: Colors.white,fontSize: 16),)),),
                                  ])
                              ],));
                              
                              }),
                        );
                      }),
                )
              
             
            ],
          ),
        ),
      ),
    );
  }
}
