import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/views/admin/Admin_Payments.dart';
import 'package:flutter_application_1/views/admin/Admin_panel.dart';
import 'package:flutter_application_1/views/admin/Applications.dart';
import 'package:flutter_application_1/views/doctors/Appointments.dart';
import 'package:flutter_application_1/views/doctors/Reviews.dart';
import 'package:flutter_application_1/views/doctors/Slots.dart';
import 'package:flutter_application_1/views/doctors/Therapists_Home.dart';
import 'package:flutter_application_1/views/users/Therapists.dart';
import 'package:flutter_application_1/views/users/home.dart';
import 'package:flutter_application_1/views/users/profile.dart';
import 'package:flutter_application_1/views/users/questionnaire.dart';
import 'package:provider/provider.dart';


class BottomNavbar extends StatefulWidget {
   BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var provider = Provider.of<LoginProvider>(context);
    var navbar_provider = Provider.of<BottomNavbarProvider>(context);

    List<Widget> _pages = [];

    // Define the pages based on user type
    if (provider.user == 0) { // patient
      _pages = [
        Dr_Appointments(), // Index 0
        Therapists(), // Index 1
        Home(), // Index 2
        Questionnaire(), // Index 3
        Profile() // Add another page for Settings if required
      ];
    } else if (provider.user == 1) { // doctor
      _pages = [
        Reviews(), // Index 0
        Dr_Appointments(), // Index 1
        Therapists_Home(), // Index 2
        DrSlots(), // Index 3
        Profile() // Add another page for Settings if required
      ];
    } else if (provider.user == 2) { // admin
      _pages = [
        TherapistApplicationsPage(),
        PaymentApprovalPage(),
        Admin()
      ];
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF05696A), // First color (Blue)
                  Color(0xFF29BDBD), // Second color (Red)
                ],
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[navbar_provider.getIndex()], // Use the index from the provider
            ),
          );
        }
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: navbar_provider.getIndex(),
        backgroundColor: Colors.transparent,
        height: height * 0.07,
        buttonBackgroundColor: const Color(0xFF05696A),
        color: const Color(0xFF05696A),
        animationDuration: const Duration(milliseconds: 300),
        items: provider.user == 0
            ? <Widget>[
                Column(
                  children: [
                    Image.asset('lib/assets/appointments.png', height: 25),
                    const Text('Sessions', style: TextStyle(fontSize: 10)),
                  ],
                ),
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
                    const Text('Take Test', style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
                  children: [
                    Image.asset('lib/assets/profile_logo.png', height: 25),
                    const Text('Profile', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ]
            : provider.user == 1
                ? <Widget>[
                    Column(
                      children: [
                        Image.asset('lib/assets/reviews.png', height: 25),
                        const Text('Reviews', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('lib/assets/appointments.png', height: 25),
                        const Text('Sessions', style: TextStyle(fontSize: 10)),
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
                        Image.asset('lib/assets/profile_logo.png', height: 25),
                        const Text('Profile', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ]
                : <Widget>[
                    Column(
                      children: [
                        Image.asset('lib/assets/pending-orders.png', height: 25),
                        const Text('Applications', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('lib/assets/payments.png', height: 25),
                        const Text('Payments', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('lib/assets/management.png', height: 24),
                        const Text('Management', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
        onTap: (index) {
          navbar_provider.toggleIndex(index);  // Update the index in the provider
        },
      ),
    );
  }
}
