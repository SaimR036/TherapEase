import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/providers/Firebase_data.dart';
import 'package:flutter_application_1/providers/Indexes_st.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:flutter_application_1/providers/enlarger_provider.dart';
import 'package:flutter_application_1/providers/parent_info_container.dart';
import 'package:flutter_application_1/views/admin/Admin_Payments.dart';
import 'package:flutter_application_1/views/admin/Applications.dart';
import 'package:flutter_application_1/views/doctors/App_Status.dart';
import 'package:flutter_application_1/views/doctors/Appointments.dart';
import 'package:flutter_application_1/views/doctors/Bank_Details.dart';
import 'package:flutter_application_1/views/doctors/Reviews.dart';
import 'package:flutter_application_1/views/doctors/Slots.dart';
import 'package:flutter_application_1/views/doctors/Therapists_Home.dart';
import 'package:flutter_application_1/views/users/profile.dart';
import 'package:flutter_application_1/views/users/set_meet.dart';
import 'package:flutter_application_1/views/admin/Admin_panel.dart';
import 'package:flutter_application_1/views/users/Instructions.dart';
import 'package:flutter_application_1/views/users/Language.dart';
import 'package:flutter_application_1/views/users/Login.dart';
import 'package:flutter_application_1/views/users/Therapists.dart';
import 'package:flutter_application_1/views/users/home.dart';
import 'package:flutter_application_1/views/users/questionnaire.dart';
import 'package:flutter_application_1/views/users/test1.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'firebase_options.dart';  
import 'package:provider/provider.dart';
import './providers/login_provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );// Initialize Firebase

  runApp(
    MultiProvider( // or Provider if you only have one
      providers: [
        ChangeNotifierProvider(create: (_) => EnlargerProvider(),
        
        ),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => Indexes()),
        ChangeNotifierProvider(create: (_) => ParentInfoContainer()),
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => CloudData()),

       
        
        // ... other providers
      ],
    child:const MaterialApp(
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: MyApp(),
    ),
    ),
    
  ));
}

class MyApp extends StatefulWidget { // Convert to StatefulWidget for animation
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1600), // 3-second animation duration
      vsync: this, // For smooth animations
    );
      _checkLoginStatus();

    
  
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Clean up the animation controller
    super.dispose();
  }
   Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isLoggedIn = prefs.getInt('isLoggedIn');
    if(isLoggedIn==null)
    {
      Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child:Login()
    ),
      );
    });
    }
    else{   
    // Check Firebase authentication as well
    User? user = FirebaseAuth.instance.currentUser;
    final navbarProvider = Provider.of<LoginProvider>(context, listen: false);
    navbarProvider.toggleUid(user?.uid);
    navbarProvider.toggleUser(isLoggedIn); // Set the initial index

    print(user);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child:  BottomNavbar()
    ),
      );
    });
  }
   }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
    
      body: Stack(
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

          // FadeTransition for both Text widgets
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(0, 0.40 * height,0,0),

              child: Text(
                'TherapEase',
                style: TextStyle(
                  color: const Color(0xFF00FDFD),
                  fontFamily: 'Font',
                  fontSize: 40,
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              alignment: Alignment.topCenter,

              margin: EdgeInsets.fromLTRB(0, 0.48 * height,0,0),
              child: const Text(
                'Therapy made easy',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Font',
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

