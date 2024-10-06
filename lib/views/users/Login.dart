import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/views/users/Language.dart';
import 'package:flutter_application_1/views/users/demographics.dart';
import 'package:flutter_application_1/views/users/home.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart'; 
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final loginProvider = Provider.of<LoginProvider>(context);

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
          Container(
            margin: EdgeInsets.fromLTRB(0.24 * width, 0.14 * height, 0, 0),
            child: Text(
              'TherapEase',
              style: TextStyle(
                color: const Color(0xFF00FDFD),
                fontFamily: 'Font',
                fontSize: 46,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.41 * width, 0.23 * height, 0, 0),
            child:  Text(
              loginProvider.isLoginView?'Login':'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Font',
                fontSize: 28,
              ),
            ),
          ),
          loginProvider.isLoginView?Container():
          Container(
              width: width*0.6,
              height: height*0.06,
              padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                  
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
              ,color: Colors.white),
              margin: EdgeInsets.fromLTRB(0.22 * width, 0.34 * height, 0, 0),
              child:TextField(
                controller: _nameController,
  style: TextStyle(),
  decoration: InputDecoration(
    hintText: 'Name',  // This is your placeholder text
  ),
),),

           Container(
              width: width*0.6,
              height: height*0.06,
              padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                  
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
              ,color: Colors.white),
              margin: EdgeInsets.fromLTRB(0.22 * width, 0.42 * height, 0, 0),
              child:TextField(
                controller: _emailController,
  style: TextStyle(),
  decoration: InputDecoration(
    hintText: 'Email',  // This is your placeholder text
  ),
),),
Container(
              width: width*0.6,
              height: height*0.06,    
              padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                  
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
              ,color: Colors.white),
              margin: EdgeInsets.fromLTRB(0.22 * width, 0.50 * height, 0, 0),
              child:TextField(
  style: TextStyle(),
  controller: _passwordController,
  decoration: InputDecoration(
    hintText: 'Password',  // This is your placeholder text
  ),
),),
  
   Container(
              width: width*0.3,
              height: height*0.05,    
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(0.36 * width, 0.59 * height, 0, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(  // Set shape to RoundedRectangleBorder
                      borderRadius: BorderRadius.all(Radius.circular(10)), // Set borderRadius to zero
                    ),
                  ), 
                  onPressed: () async {
                    if (loginProvider.isLoginView) {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      // 1. Firebase Sign-In Attempt
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // 2. Handle Successful Login
      context.read<LoginProvider>().toggleUid(userCredential.user?.uid);      LoginProvider().toggleUid(userCredential.user?.uid);
      // Optional: Display a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome Back!"), // Use display name if available
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );

      // If using navigation with named routes:
        Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: const Home(),
    ),
      );
    } on FirebaseAuthException catch (e) {
      // 3. Handle Firebase Auth Errors
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage 
 = 'Wrong password provided for that user.';
      } else {
        errorMessage = e.message ?? 'An error occurred during login.'; // Fallback with more details
      }

      // Display error as Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Color(0xFF05696A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
    } catch (e) {
      // 4. Handle Other Errors
      print(e); // Log unexpected errors to the console
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
    }
                    else{
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var name = _nameController.text;
                   try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,

          );

          await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
            'uid': userCredential.user?.uid,
            'name': name,

          });

          print('Sign Up Successful');
          
          // Optional: Display a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
    content: Text('Sign Up Successful',style: TextStyle(fontFamily: 'Font'),),
    backgroundColor: Color(0xFF05696A), // Dark green color
    behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
    shape: RoundedRectangleBorder(       // Add rounded corners
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
          );
        } on FirebaseAuthException catch (e) {
          String errorMessage = e.toString();
if (errorMessage.contains(']')) {
  errorMessage = errorMessage.split(']')[1]; // Get the first part before space
}

         if (e.code == 'email-already-in-use') {
            errorMessage = 'The account already exists for that email.'; 

          }
          else  if (e.code == 'weak-password') {
            errorMessage = 'The password provided is too weak.';
          } 


          ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
    content: Text(errorMessage,style: TextStyle(fontFamily: 'Font'),),
    backgroundColor: Color(0xFF05696A), // Dark green color
    behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
    shape: RoundedRectangleBorder(       // Add rounded corners
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),          );
        } catch (e) {
          print(e); // Log unexpected errors for debugging
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
    content: Text(e.toString(),style: TextStyle(fontFamily: 'Font'),),
    backgroundColor: Color(0xFF05696A), // Dark green color
    behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
    shape: RoundedRectangleBorder(       // Add rounded corners
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
          );
        }
                    }
      },


                  
                  child:  Text(
                    loginProvider.isLoginView?'Log In':'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Font',
                      fontSize: 15,
                    ),
                  ),
                ),
            ),
Container(
                
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(0.49 * width, 0.67 * height, 0, 0),
              child:Text('Or',style: TextStyle(fontSize: 15),)),

        Container(
  width: width * 0.08,
  height: height * 0.06,
  decoration: BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  ),
  margin: EdgeInsets.fromLTRB(0.28 * width, 0.73 * height, 0, 0),
  child: IconButton(
    padding: EdgeInsets.zero,
    iconSize: 20,
    onPressed: () {},
    icon: ClipOval( // Clip the Image to be oval/circular
      child: Image.asset(
        'lib/assets/google_logo.webp',
        fit: BoxFit.cover,
      ),
    ),
  ),
),

            Container(
              width: width*0.08,
              height: height*0.06,    
decoration: BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
  ),              margin: EdgeInsets.fromLTRB(0.46 * width, 0.73 * height, 0, 0),
              child:IconButton(
    padding: EdgeInsets.zero,
    iconSize: 30,
    onPressed: () {},
    icon: ClipOval( // Clip the Image to be oval/circular
      child: Image.asset(
        'lib/assets/apple-logo.png',
        fit: BoxFit.cover,
      ),
    ),
  ),
            ),
            Container(
              width: width*0.08,
              height: height*0.06,    
decoration: BoxDecoration(
    color: Colors.black,
    shape: BoxShape.circle,
  ),              margin: EdgeInsets.fromLTRB(0.64 * width, 0.73 * height, 0, 0),
              child:IconButton(
    padding: EdgeInsets.zero,
    iconSize: 30,
    onPressed: () {},
    icon: ClipOval( // Clip the Image to be oval/circular
      child: Image.asset(
        'lib/assets/facebook_logo.webp',
        fit: BoxFit.cover,
      ),
    ),
  ),
            ),
        Container(   
margin: EdgeInsets.fromLTRB(0.25 * width, 0.84 * height, 0, 0),
              child:Text("Don't have an account?")
            ),  
            Container(   
margin: EdgeInsets.fromLTRB(0.55 * width, 0.832 * height, 0, 0),
              child:TextButton(
                onPressed: (){
                  loginProvider.toggleView();
                },
                child:Text(loginProvider.isLoginView?"Sign Up":"Log In",style: TextStyle(color: Color(0xFF05696A)),)
            )),   
            
        
        ],
      ),
    );
  }
}