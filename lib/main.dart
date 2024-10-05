import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/providers/Indexes_st.dart';
import 'package:flutter_application_1/providers/enlarger_provider.dart';
import 'package:flutter_application_1/providers/parent_info_container.dart';
import 'package:flutter_application_1/set_meet.dart';
import 'package:flutter_application_1/views/Admin_panel.dart';
import 'package:flutter_application_1/views/Instructions.dart';
import 'package:flutter_application_1/views/Language.dart';
import 'package:flutter_application_1/views/Login.dart';
import 'package:flutter_application_1/views/Therapists.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/questionnaire.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart'; 
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
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: const MeetLink(),
    ),
      );
    });
  
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Clean up the animation controller
    super.dispose();
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
              margin: EdgeInsets.fromLTRB(0.25 * width, 0.4 * height, 0, 0),
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
              margin: EdgeInsets.fromLTRB(0.36 * width, 0.47 * height, 0, 0),
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

