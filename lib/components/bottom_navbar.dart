import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/views/doctors/Appointments.dart';
import 'package:flutter_application_1/views/doctors/Reviews.dart';
import 'package:flutter_application_1/views/doctors/Slots.dart';
import 'package:flutter_application_1/views/doctors/Therapists_Home.dart';
import 'package:flutter_application_1/views/users/Therapists.dart';
import 'package:flutter_application_1/views/users/home.dart';
import 'package:provider/provider.dart';
class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var _selectedIndex = 2;  // Default to 'Home' page

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<Widget> _pages = [];
    var provider = Provider.of<LoginProvider>(context);
    if (provider.user == 0) {
      _pages = [
        Dr_Appointments(),        // Index 0
        Therapists(),              // Index 1
        Home(),                    // Index 2
        DrSlots(),                 // Index 3
        DrSlots()                  // Add another page for Settings if required
      ];
    } else if (provider.user == 1) {
      _pages = [
        Reviews(),                 // Index 0
        Dr_Appointments(),         // Index 1
        Therapists_Home(),   // Index 2
        DrSlots(),                 // Index 3
        DrSlots()                  // Add another page for Settings if required
      ];
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Builder(    // Use Builder to get a context that has access to Scaffold
        builder: (BuildContext context)
        { 
          return  Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF05696A),  // First color (Blue)
                Color(0xFF29BDBD),  // Second color (Red)
              ],
            ),
          ),
          child: IndexedStack(
            children: _pages,
            index: _selectedIndex,
          ),
        );
        }
      ),  // Display the selected page
  
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: height * 0.07,
        buttonBackgroundColor: const Color(0xFF05696A),
        color: const Color(0xFF05696A),
        animationDuration: const Duration(milliseconds: 300),
        items: provider.user==0? <Widget>[
          if(provider.user == 0)
              Column(
                  children: [
                    Image.asset('lib/assets/appointments.png', height: 25),
                    const Text('Appointments', style: TextStyle(fontSize: 10)),
                  ],
                ),
              
          if(provider.user ==0)
              Column(
                  children: [
                    Image.asset('lib/assets/book.png', height: 25),
                    const Text('Therapists', style: TextStyle(fontSize: 10)),
                  ],
                ),
              
          Column(
            children: [
              Image.asset('lib/assets/home.png', height: 24),
              const Text('Home', style: TextStyle(fontSize: 10)),
            ],
          ),
              Column(
                  children: [
                    Image.asset('lib/assets/exercises.png', height: 25),
                    const Text('Exercises', style: TextStyle(fontSize: 10)),
                  ],
                ),
              
            
          Column(
            children: [
              Image.asset('lib/assets/settings.png', height: 25),
              const Text('Settings', style: TextStyle(fontSize: 10)),
            ],
          ),
        ]:
        <Widget>[
          Column(
                  children: [
                    Image.asset('lib/assets/reviews.png', height: 25),
                    const Text('Reviews', style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('lib/assets/appointments.png', height: 25),
                    const Text('Appointments', style: TextStyle(fontSize: 10)),
                  ],
                ),
                  Column(
            children: [
              Image.asset('lib/assets/home.png', height: 24),
              const Text('Home', style: TextStyle(fontSize: 10)),
            ],
          ),
          Column(
                  children: [
                    Image.asset('lib/assets/slots.png', height: 25),
                    const Text('Slots', style: TextStyle(fontSize: 10)),
                  ],
                ),
                  Column(
                  children: [
                    Image.asset('lib/assets/slots.png', height: 25),
                    const Text('Slots', style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
            children: [
              Image.asset('lib/assets/settings.png', height: 25),
              const Text('Settings', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;  // Update selected page
          });
        },
      ),
    );
  }
}
