import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return CurvedNavigationBar(
        backgroundColor: Color(0xFF29BDBD),
        height: height*0.07,
        buttonBackgroundColor: Color(0xFF05696A),
        color: Color(0xFF05696A),
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Column(children: [Image.asset('lib/assets/reviews.png', height: 25),Text('Reviews',style: TextStyle(fontSize: 10),),
          ],),
          Column(children: [Image.asset('lib/assets/appointments.png', height: 25),Text('Appointments',style: TextStyle(fontSize: 10)),
          ],),
          Column(children: [Image.asset('lib/assets/home.png', height: 24),Text('Home',style: TextStyle(fontSize: 10)),
          ],),
          Column(children: [Image.asset('lib/assets/slots.png', height: 25),Text('Slots',style: TextStyle(fontSize: 10)),
          ],),
          Column(children: [Image.asset('lib/assets/settings.png', height: 25),Text('Settings',style: TextStyle(fontSize: 10)),
          ],),
         
        ],
        onTap: (index) {
        context.read<BottomNavbarProvider>().toggleIndex(index);      
        // var inde = Provider.of(context)<BottomNavbarProvider>;
        // if context.read<BottomNavbarProvider>()._selectedIndex 

        },

      );
  }
}