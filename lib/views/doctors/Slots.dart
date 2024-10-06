import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:table_calendar/table_calendar.dart';

class DrSlots extends StatefulWidget {
  const DrSlots({super.key});

  @override
  State<DrSlots> createState() => _DrSlotsState();
}

class _DrSlotsState extends State<DrSlots> {
  var display = false;
  var display_str = '';
  DateTime _focusedDay = DateTime.now(); // Currently focused day
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;

  // Helper function to display the date and time
  String formatSelectedDateTime() {
    if (_selectedDay != null && _selectedTime != null) {
      return "${_selectedDay!.toLocal()}".split(' ')[0] + // Date part
             " " +
             _selectedTime!.format(context); // Time part
    }
    return ''; // Return empty string if not selected
  }
 Future<void> addSlotToFirebase() async {
    if (_selectedDay != null && _selectedTime != null) {
      // Combine selected date and time into a slot string or object
      String date = "${_selectedDay!.toLocal()}".split(' ')[0];
      String time = _selectedTime!.format(context);

      // Define the slot to add
      Map<String, String> slot = {
        'Date': date,
        'Time': time,
      };

      // Reference to the Firebase document (you can adjust the path to match your structure)
      var doctorId = '0udrDWeB2NTRglYz1E4htrucTkk2'; // Replace with dynamic ID if needed
      var docRef = FirebaseFirestore.instance.collection('Doctors').doc(doctorId);

      // Add the slot to the 'Slots' array in Firebase
      await docRef.update({
        'Slots': FieldValue.arrayUnion([slot]) // Add slot to the Slots array
      }).then((_) {
        print('Slot added successfully: $slot');
      }).catchError((error) {
        print('Failed to add slot: $error');
      });
    }
  }
  // Function to show time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        // Update the display string with both date and time
        display_str = formatSelectedDateTime();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
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
            children: [
              SizedBox(
                width: width * 0.75,
                height: height*0.4,
                child: Container(
                  height: height*0.5,
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
                            color: Colors.green, // Color for dates with available slots
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            radius: 50,
                            onTap: () {
                              setState(() {
                                _selectedDay = day;
                                display = true;
                                display_str = formatSelectedDateTime(); // Update date in string
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
              ),
              if (display == true)
                Container(
                  height: height * 0.2,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF05696A)
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          _selectTime(context); // Show time picker on button press
                        },
                        child: Text('Select Time',style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                      SizedBox(height: 10),
                      Text(display_str,style: TextStyle(color: Colors.white, fontSize: 20),), // Display selected date + time
                      TextButton(
                        onPressed: () {
                          // Add logic to save or use the selected slot
                          if (_selectedDay != null && _selectedTime != null) {
                            print("Slot: $display_str");
                            print("Day: $_selectedDay");
                            print("DatTime: $_selectedTime");
                            addSlotToFirebase();
                          }
                        },
                        child: Text('Add slot!',style: TextStyle(color: Colors.white,fontSize: 20)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
