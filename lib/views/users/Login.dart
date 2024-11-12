import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bottom_navbar.dart';
import 'package:flutter_application_1/providers/bottom_navbar_provider.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/views/doctors/App_Status.dart';
import 'package:flutter_application_1/views/users/demographics.dart';
import 'package:flutter_application_1/views/users/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:page_transition/page_transition.dart'; 
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


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


File? _profileImage;
  File? _resumeFile;

  final ImagePicker _picker = ImagePicker();

  // Function to pick profile picture
  Future<void> _pickProfileImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }
  bool _isValidEmail(String email) {
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}

bool isPasswordStrong(String password) {
  // Example: Check for minimum length and the presence of uppercase, lowercase, and digits
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  );
  return passwordRegExp.hasMatch(password);
}
  // Function to pick resume
  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'], // Allowed file types
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _resumeFile = File(result.files.single.path!);
      });
    }
  }
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
late UserCredential user;
Future<bool> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return false; // User canceled the sign-in
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    user = await _auth.signInWithCredential(credential);
    return true;
  } catch (e) {
    print("Error signing in with Google: $e");
    return false;
  }
}
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final _nameController = TextEditingController();
  var button_idx=0;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var bottom_navbar_provider;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final loginProvider = Provider.of<LoginProvider>(context);
    bottom_navbar_provider = Provider.of<BottomNavbarProvider>(context);
    return Scaffold(
      
      body:  Container(
        width: width,
        height: height,
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
child:SingleChildScrollView(
  child: Column(
          children: [
           
  
            // FadeTransition for both Text widgets
            AnimatedContainer(
              duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),
  alignment: Alignment.topCenter,
              margin:  EdgeInsets.fromLTRB(0,0.10 * height, 0, 0),
              child: Text(
                'TherapEase',
                style: TextStyle(
                  color: const Color(0xFF00FDFD),
                  fontFamily: 'Font',
                  fontSize: 46,
                ),
              ),
            ),
            AnimatedContainer(
              alignment: Alignment.topCenter,
              duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 200,microseconds:0),
              margin: EdgeInsets.fromLTRB(0,0, 0, 0),
              child:  Text(
                loginProvider.isLoginView?'Login':'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Font',
                  fontSize: 28,
                ),
              ),
            ),
  SizedBox(height: height*0.025,),
  
  // //if(loginProvider.isLoginView==false && loginProvider.isTherapist==true)
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  
  // AnimatedOpacity(opacity: (loginProvider.isLoginView == false && loginProvider.isTherapist == true) ? 1.0 : 0.0, // Show or hide the container
  //   duration: Duration(milliseconds: 300), // Duration for the smooth transition
  //   curve: Curves.easeInOut,
  //           child:(loginProvider.isLoginView == false && loginProvider.isTherapist == true)?
  //  Container(
  //             alignment: Alignment.topCenter,
  //               width: width*0.42,
  //               height: height*0.06,
  //               padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
  //               ,color: Colors.white),
  //               //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
  //               child:TextField(
  //                 controller: _nameController,
  //   style: TextStyle(),
  //   decoration: InputDecoration(
  //     hintText: 'Account Number',  // This is your placeholder text
  //   ),
  // ),):null),
  // SizedBox(width: width*0.1,),
  // AnimatedOpacity(opacity: (loginProvider.isLoginView == false && loginProvider.isTherapist == true) ? 1.0 : 0.0, // Show or hide the container
  //   duration: Duration(milliseconds: 300), // Duration for the smooth transition
  //   curve: Curves.easeInOut,
  //           child:(loginProvider.isLoginView == false && loginProvider.isTherapist == true)?
  // Container(
  //               width: width*0.42,
  //               height: height*0.06,
  //               padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
  //               ,color: Colors.white),
  //               //margin: EdgeInsets.fromLTRB(0.22 * width, 0.34 * height, 0, 0),
  //               child:TextField(
  //                 controller: _nameController,
  //   style: TextStyle(),
  //   decoration: InputDecoration(
  //     hintText: 'Bank Name',  // This is your placeholder text
  //   ),
  // ),):null),
  
  // ],),
  // if(loginProvider.isLoginView==false && loginProvider.isTherapist==true)
  
  // SizedBox(height: height*0.02,),
  
  // //if(loginProvider.isLoginView==false && loginProvider.isTherapist==true)
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  
  // AnimatedOpacity(opacity: (loginProvider.isLoginView == false && loginProvider.isTherapist == true) ? 1.0 : 0.0, // Show or hide the container
  //   duration: Duration(milliseconds: 300), // Duration for the smooth transition
  //   curve: Curves.easeInOut,
  //           child:(loginProvider.isLoginView == false && loginProvider.isTherapist == true)?
  //  Container(
  //             alignment: Alignment.topCenter,
  //               width: width*0.42,
  //               height: height*0.06,
  //               padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
  //               ,color: Colors.white),
  //               //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
  //               child:TextField(
  //                 controller: _nameController,
  //   style: TextStyle(),
  //   decoration: InputDecoration(
  //     hintText: 'Account Title',  // This is your placeholder text
  //   ),
  // ),):null,),
  // SizedBox(width: width*0.1,),
  // AnimatedOpacity(opacity: (loginProvider.isLoginView == false && loginProvider.isTherapist == true) ? 1.0 : 0.0, // Show or hide the container
  //   duration: Duration(milliseconds: 300), // Duration for the smooth transition
  //   curve: Curves.easeInOut,
  //           child:(loginProvider.isLoginView == false && loginProvider.isTherapist == true)?
  // Container(
  //             alignment: Alignment.topCenter,
  //               width: width*0.42,
  //               height: height*0.06,
  //               padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
  //               ,color: Colors.white),
  //               //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
  //               child:TextField(
  //                 controller: _nameController,
  //   style: TextStyle(),
  //   decoration: InputDecoration(
  //     hintText: 'FullName',  // This is your placeholder text
  //   ),
  // ),):null)
  
  
  // ],),
  // if(loginProvider.isLoginView==false && loginProvider.isTherapist==true)
  
  // SizedBox(height: height*0.02,),
  
            if(loginProvider.isLoginView==false && loginProvider.isTherapist==false)
           Container(
              alignment: Alignment.topCenter,
                width: width*0.7,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _nameController,
    style: TextStyle(),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Name',  // This is your placeholder text
    ),
  ),),
  if(loginProvider.isLoginView==true)
  SizedBox(height:height*0.1),

             Container(
               alignment: Alignment.topCenter,
  
                width: width*0.7,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                margin: EdgeInsets.fromLTRB(0,0, 0, height*0.03),
                child:TextField(
                  controller: _emailController,
    style: TextStyle(),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: loginProvider.isLoginView==false && loginProvider.isTherapist==true?'Full Name':'Email',  // This is your placeholder text
    ),
  ),),
  Container(
                 alignment: Alignment.topCenter,
  
                width: width*0.7,
                height: height*0.06,    
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                margin: EdgeInsets.fromLTRB(0,0, 0, height*0.03),
                child:TextField(
    style: TextStyle(),
    controller: _passwordController,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: loginProvider.isLoginView==false && loginProvider.isTherapist==true? 'Email':'Password',  // This is your placeholder text
    ),
  ),),
  if(loginProvider.isLoginView==false)
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        if(loginProvider.isTherapist==true)
  Container(
    width: width*0.3,
    height: height*0.05,
    decoration: BoxDecoration(color: Color(0xFF05696A),borderRadius: BorderRadius.circular(10)),
    child: TextButton(
                  onPressed: _pickResume,
                  child: FittedBox(child: Text('Upload Resume',style: TextStyle(color: Colors.white),)),
                ),
  ),
              if(loginProvider.isTherapist==true)
              SizedBox(width: width*0.1,),
              Container(
                height: height*0.05,
                width: width*0.3,
                decoration: BoxDecoration(color: Color(0xFF05696A),borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: _pickProfileImage,
                  child: FittedBox(child: Text('Upload Profile Picture',style: TextStyle(color: Colors.white),)),
                ),
              ),
  
    ]),
    if(loginProvider.isLoginView==false)
  SizedBox(height: height*0.02,),
  Container(
    margin: EdgeInsets.only(bottom:height*0.03),
    decoration: BoxDecoration(border: Border.all(width: 2,color: Color(0xFF05696A)),borderRadius: BorderRadius.circular(10)),
    child: Stack(children: [
    
    AnimatedContainer( 
      curve: Curves.easeInOut,
      decoration:  BoxDecoration(color: Color(0xFF05696A),borderRadius: BorderRadius.circular(8)),
      margin: button_idx ==1? EdgeInsets.only(left: width*0.3):EdgeInsets.only(left: width*0.0),
      width: width*0.3,
      height: height*0.05,
      duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 400,microseconds:0),),
    
        AnimatedContainer(
                duration: Duration(days: 0,hours: 0,minutes: 0,seconds: 0,milliseconds: 400,microseconds:0),

          height: height*0.05, width:width*0.3,decoration:  BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(10)), child: TextButton(
          onPressed: (){
            if(loginProvider.isTherapist)
            loginProvider.toggleIsTherapist();
            setState(() {
          button_idx=0;
        }); }, child: FittedBox(child: Text('User',style: TextStyle(color: Colors.white),)))),
        Container(height: height*0.05,width: width*0.3, margin: EdgeInsets.only(left: width*0.3),  decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(10)),child: TextButton(onPressed: (){
          setState(() {
            button_idx=1;
          });
          if(!loginProvider.isTherapist)
          {
            loginProvider.toggleIsTherapist();}
        }, child: FittedBox(child:Text('Therapist',style: TextStyle(color: Colors.white),))))
    ],),
  ),
  
     Container(
      alignment: Alignment.topCenter,
                width: width*0.3,
                height: height*0.05,    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.fromLTRB(0,0,0,  height*0.02),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(  // Set shape to RoundedRectangleBorder
                        borderRadius: BorderRadius.all(Radius.circular(10)), // Set borderRadius to zero
                      ),
                    ), 
                    onPressed: () async {
                      loginProvider.toggleLoginLoader();

                      if (loginProvider.isLoginView) {
      String email = _emailController.text;
      String password = _passwordController.text;
  
      try {
        // 1. Firebase Sign-In Attempt
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(userCredential.user?.uid);
        // 2. Handle Successful Login
       
        CollectionReference admins = FirebaseFirestore.instance.collection('Admin');

  // Query for documents where 'email' field matches the provided email
DocumentSnapshot adminSnapshot = await admins.doc(userCredential.user?.uid).get();
if (adminSnapshot.exists) {
   bottom_navbar_provider.toggleIndex(1);     

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('isLoggedIn', 2);
   loginProvider.toggleUid(userCredential.user?.uid);
        // Optional: Display a success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome Back!"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
   loginProvider.toggleUser(2);
   Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child: BottomNavbar(),
      ),
        );
  }
  else{
        if(!loginProvider.isTherapist)
        {
          CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Query for documents where 'email' field matches the provided email
DocumentSnapshot userSnapshot = await users.doc(userCredential.user?.uid).get();

  if (userSnapshot.exists) {
     loginProvider.toggleUid(userCredential.user?.uid);      
        // Optional: Display a success message or navigate to another screen
     
   loginProvider.toggleUser(0);
   if(userSnapshot['Info']=='0')
    Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child: const Demographics(),
      ),
        );
  else
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('isLoggedIn', 0);
   bottom_navbar_provider.toggleIndex(2);     

   Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child:  BottomNavbar(),
      ),
        );
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome Back!"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
  }
  }
  else{
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid email or password!"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
  }
        }
  else{
     CollectionReference doctors = FirebaseFirestore.instance.collection('Doctors');
DocumentSnapshot docSnapshot = await doctors.doc(userCredential.user?.uid).get();

if (docSnapshot.exists) {

   loginProvider.toggleUid(userCredential.user?.uid);      
   if (docSnapshot['Ban']==1)
   {
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sorry, you have been banned!"), // Use display name if available
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
   }
   else{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('isLoggedIn', 1);
   bottom_navbar_provider.toggleIndex(2);     

        // Optional: Display a success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome Back!"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
  // Query for documents where 'email' field matches the provided email
   loginProvider.toggleUser(1);
Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child:  BottomNavbar(),
      ),
        );
   }
  } 
  else{
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid email or password!"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
  }
  }
  
    
  
  }
        // If using navigation with named routes:
         
      } on FirebaseAuthException catch (e) {
        // 3. Handle Firebase Auth Errors
        String errorMessage;
      print(e.code);
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
          SnackBar(content: Text(e.toString())),
        );
      }
      }
                      else{   //signup
                      if (loginProvider.isTherapist==false)
                      {
                      var email = _emailController.text;
                      var password = _passwordController.text;
                      var name = _nameController.text;
CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Query for documents where 'email' field matches the provided email
  QuerySnapshot querySnapshot = await users.where('Email', isEqualTo: email.toLowerCase()).get();

  if (querySnapshot.docs.isNotEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Email Already Exists',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
  }
  else{

    if (!isPasswordStrong(password)) {
     ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Password must be 8 characters and should have uppercase,lowercase letters and one number',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
    return;
  }
  

                     try {
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
  
            );
     String profilePicName = 'profile_pics/$email.jpg'; // Use UID for the filename
      UploadTask profileUploadTask = storage.ref(profilePicName).putFile(_profileImage!);
      TaskSnapshot profileSnapshot = await profileUploadTask;
      String profileImageUrl = await profileSnapshot.ref.getDownloadURL();

            await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
              'uid': userCredential.user?.uid,
              'name': name,
              'ImageUrl': profileImageUrl,
              'Appointments': [],
              'Info':'0'
            });
            loginProvider.toggleUid(userCredential.user?.uid);      
        // Optional: Display a success message or navigate to another screen
     
   loginProvider.toggleUser(0);
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
             Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: Demographics(),
    ));

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
                       }}
                      
                       else{  //Therapist sign up
var email; var password; var name;

                       
                       if(loginProvider.isLoginView==false && loginProvider.isTherapist==true)
                       {
                          email = _passwordController.text;
                          name = _emailController.text;
                            if(!_isValidEmail(email))
                       {
                          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Email format is not correct',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
return;

                       }
                       }
                       else if(loginProvider.isLoginView==false && loginProvider.isTherapist==false)
                       {
                        email = _emailController.text;
                       password = _passwordController.text;
                       name = _nameController.text;
                       if(!_isValidEmail(email))
                       {
                          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Email format is not correct',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
  return;

                       }
                       }
                     try {
                      if(loginProvider.isTherapist==false)
                      {
if (email.isEmpty || password.isEmpty || name.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Please fill in all fields',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
    
    return;
  }
                      }
                      else{
                        print('AHHHHHHHHHHHHHHHHHHHHHHH');
                        if (email.isEmpty  || name.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Please fill in all fields',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
    
    return;
  }
                      }
  if (_profileImage == null) {
     ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Documents not uploaded',style: TextStyle(fontFamily: 'Font'),),
      backgroundColor: Color(0xFF05696A), // Dark green color
      behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
      shape: RoundedRectangleBorder(       // Add rounded corners
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
            );
   
    return;
  }

  

            String profilePicName = 'profile_pics/$email.jpg'; // Use UID for the filename
      UploadTask profileUploadTask = storage.ref(profilePicName).putFile(_profileImage!);
      TaskSnapshot profileSnapshot = await profileUploadTask;
      String profileImageUrl = await profileSnapshot.ref.getDownloadURL();

      // Upload resume to Firebase Storage
      String resumeName = 'resumes/$email.${_resumeFile!.path.split('.').last}'; // Use UID for the filename
      UploadTask resumeUploadTask = storage.ref(resumeName).putFile(_resumeFile!);
      TaskSnapshot resumeSnapshot = await resumeUploadTask;
      String resumeUrl = await resumeSnapshot.ref.getDownloadURL();
      await firestore.collection('Therapist_Applications').add({
    'Email': email,
    'Name': name,
    'ImageUrl':profileImageUrl,
    'ResumeUrl':resumeUrl,
    'Status':"1",
    'createdAt':FieldValue.serverTimestamp(),
  });
            
            // Optional: Display a success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
      content: Text('Application submitted successfully',style: TextStyle(fontFamily: 'Font'),),
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
                       
                       
                        }//sign up end

                      loginProvider.toggleLoginLoader();

        },
  
  
                    
                    child:  FittedBox(
                      child:loginProvider.loginLoader? Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: Colors.black,),
                      )):
                      Text(
                        loginProvider.isLoginView?'Log In':loginProvider.isTherapist? 'Submit Application':'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Font',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
              ),
  if(!loginProvider.isTherapist)
  Container(
                 alignment: Alignment.topCenter,
  
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.fromLTRB(0,0, 0,  height*0.01),
                child:Text('Or',style: TextStyle(fontSize: 15),)),
   Container(
    margin: EdgeInsets.only(bottom:height*0.01),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      
  
     if(!loginProvider.isTherapist)
                Container(
                  width: width * 0.08,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 30,
                    onPressed: () async{
                  loginProvider.toggleLoginLoader();

                  await _googleSignIn.signOut();
                  if(await signInWithGoogle())
                  {
                    var userRef = FirebaseFirestore.instance.collection('users').doc(user.user?.uid);
                    var docSnapshot = await userRef.get();
                    if (docSnapshot.exists) {
                      loginProvider.toggleUid(user.user?.uid);      
        // Optional: Display a success message or navigate to another screen
     
   loginProvider.toggleUser(0);
   SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('isLoggedIn', 0);
                      if(docSnapshot['Info']=='0')
    Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child: const Demographics(),
      ),
        );
  else
  {
    
   Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child:  BottomNavbar(),
      ),
        );
     ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome Back!"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
  }
                    } else {
await FirebaseFirestore.instance.collection('users').doc(user.user?.uid).set({
              'uid': user.user?.uid,
              'name': user.user?.displayName,
              'ImageUrl': user.user?.photoURL,
              'Appointments': [],
              'Info':'0'
            });
  loginProvider.toggleUid(user.user?.uid);      
        // Optional: Display a success message or navigate to another screen
     
   loginProvider.toggleUser(0);
            Navigator.pushReplacement( 
          context,
          PageTransition(
        type: PageTransitionType.rightToLeft, // Or any other type
        child: const Demographics(),
      ),
        );

                  }
                  }
                                        loginProvider.toggleLoginLoader();

                    },
                    icon: ClipOval(
                      child: Image.asset(
                        'lib/assets/google_logo.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

    //             Container(
    //               width: width*0.08,
    //               height: height*0.06,    
    //  decoration: BoxDecoration(
    //     color: Colors.black,
    //     shape: BoxShape.circle,
    //   ),              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    //               child:IconButton(
    //     padding: EdgeInsets.zero,
    //     iconSize: 30,
    //     onPressed: () {},
    //     icon: ClipOval( // Clip the Image to be oval/circular
    //       child: Image.asset(
    //         'lib/assets/facebook_logo.webp',
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    //             ),
     ]),
   ),
  Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
            Container(   
    margin: EdgeInsets.fromLTRB(0,0, 0, 0),
                  child:Text(loginProvider.isLoginView? "Don't have an account?":"Already have an account?")
                ),  
                Container(   
    margin: EdgeInsets.fromLTRB(0,0, 0, 0),
                  child:TextButton(
                    onPressed: (){
                      loginProvider.toggleView();
                    },
                    child:Text(loginProvider.isLoginView && loginProvider.isTherapist?"Submit Application":loginProvider.isLoginView && loginProvider.isTherapist==false?"Sign Up":"Log In",style: TextStyle(color: Color(0xFF05696A)),)
                )),   
                
    ]),
  ),
  if(loginProvider.isTherapist)
   Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
            Container(   
    margin: EdgeInsets.fromLTRB(0,0, 0, 0),
                  child:Text("Already submitted application?")
                ),  
                Container(   
    margin: EdgeInsets.fromLTRB(0,0, 0, 0),
                  child:TextButton(
                    onPressed: (){
                      Navigator.pushReplacement( 
        context,
        PageTransition(
      type: PageTransitionType.rightToLeft, // Or any other type
      child: App_Status(),
    ));
                    },
                    child:Text("Check status",style: TextStyle(color: Color(0xFF05696A)),)
                )),   
                
    ]),
  )
          ],
        ),
),
    ));
  }
}