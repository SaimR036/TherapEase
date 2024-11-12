import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BankDetails extends StatefulWidget {
  var details;
  BankDetails({required this.details});
//BankDetails({super.key});
  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  var details;
  final _accountNo = TextEditingController();
  var button_idx=0;
  final _accountTitle = TextEditingController();
  final _bankName = TextEditingController();
  final _password = TextEditingController();
  final _profession = TextEditingController();

  final _confirmpassword = TextEditingController();
bool isPasswordStrong(String password) {
  // Example: Check for minimum length and the presence of uppercase, lowercase, and digits
  final RegExp passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  );
  return passwordRegExp.hasMatch(password);
}
  @override
  void initState() {
    // TODO: implement initState
    details = widget.details;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(body:  Container(
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
            
            child:SingleChildScrollView(
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
Container(
  margin: EdgeInsets.only(top: height*0.07,bottom: height*0.06),
  child: Text('Account Sign Up',style: TextStyle(color: Colors.white,fontSize: 40),),),

               Container(
              alignment: Alignment.topCenter,
                width: width*0.6,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _accountTitle,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: 'Account Title',  // This is your placeholder text
      fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),)
    ),
  ),),
  SizedBox(height: height*0.02,),
  Container(
              alignment: Alignment.topCenter,
                width: width*0.6,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _accountNo,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: 'Account No.',  // This is your placeholder text
      fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),)
    ),
  ),),
    SizedBox(height: height*0.02,),

  Container(
              alignment: Alignment.topCenter,
                width: width*0.6,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _bankName,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: 'Bank Name',  // This is your placeholder text
      fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),)
    ),
  ),),
    SizedBox(height: height*0.02,),

  Container(
              alignment: Alignment.topCenter,
                width: width*0.6,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _profession,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: 'Profession (Gynecologist etc.)',  // This is your placeholder text
      fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),)
    ),
  ),),
    SizedBox(height: height*0.02,),

  Container(
              alignment: Alignment.topCenter,
                width: width*0.6,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _password,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: 'Password',  // This is your placeholder text
      fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),)
    ),
  ),),
    SizedBox(height: height*0.02,),
Container(
              alignment: Alignment.topCenter,
                width: width*0.6,
                height: height*0.06,
                padding: EdgeInsets.fromLTRB(0.01 * width, 0.01 * height,0.01 * width,1),
                    
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.white),
                //margin: EdgeInsets.fromLTRB(0, 0, 0, height*0.03),
                child:TextField(
                  controller: _confirmpassword,
    style: TextStyle(),
    decoration: InputDecoration(
      hintText: 'Confirm Password',  // This is your placeholder text
      fillColor: Colors.black,focusColor: Colors.black,hoverColor: Colors.black,focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    // Customize the enabled border (when the TextField is not focused)
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),)
    ),
  ),),
      SizedBox(height: height*0.02,),

Container(
  width: width*0.2,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10)
  ),
  child: TextButton(
  onPressed: () async{
      // Ensure all required fields are filled
      if (_accountTitle.text.isEmpty || _accountNo.text.isEmpty || 
          _bankName.text.isEmpty || _profession.text.isEmpty || 
          _password.text.isEmpty || _confirmpassword.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
        return;
      }
      

      // Check if passwords match
      if (_password.text != _confirmpassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match')));
        return;
      }
      if (!isPasswordStrong(_password.text)) {
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
        // Create user with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: details['Email'], // Use account number as email here, but change as needed
          password: _password.text,
        );

        // Get the newly created user ID (UID)
        String uid = userCredential.user!.uid;

        // Save user details to Firestore under a new document with their UID
        await FirebaseFirestore.instance.collection('Doctors').doc(uid).set({
          'AccountTitle': _accountTitle.text,
          'AccountNo': _accountNo.text,
          'BankName': _bankName.text,
          'Profession': _profession.text,
          'Rating': '4', // Default rating
          'Ban': '0', // Default ban status
          'Reviews': [], // Initialize empty array
          'Appointments': [], // Initialize empty array
          'Slots': [], // Initialize empty array
          'Email': details['Email'],
          'ImageUrl':details['ImageUrl'],
          'Name': details['Name']
        });
        await FirebaseFirestore.instance
            .collection('Therapist_Applications')
            .doc(details['id']) // Make sure to provide the correct document ID
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful!')));

        // Optionally navigate to a new page or clear fields
        // Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage()));

      } catch (e) {
        // Handle any errors that occur during sign up
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }




  },
  child: FittedBox(child: Text('Sign Up',style: TextStyle( color:Colors.black,fontSize: 20))),),)
              ],)
              
              )));
  }
}