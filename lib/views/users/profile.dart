import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/views/users/Login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> _fetchProfileData(String uid) async {
    DocumentSnapshot doctorDoc = await _firestore.collection('Doctors').doc(uid).get();
    if (doctorDoc.exists) {
      return {'type': 'doctor', ...doctorDoc.data() as Map<String, dynamic>};
    }
    // Check in users collection first
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return {'type': 'user', ...userDoc.data() as Map<String, dynamic>};
    }

    // If not found, check in doctors collection
    

    // Return null if not found in either collection
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      
      body: 
    Container(
      alignment: Alignment.center,
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
            
            child:Column(
              children: [
                SizedBox(height: height*0.05,),
                 Container(
                  alignment: Alignment.topCenter,
                  width: width*0.5,
                  child: FittedBox(child: Text('Profile',style: TextStyle(color: Colors.white,fontSize: 50),)))
                ,SizedBox(height: height*0.1,),
                FutureBuilder<Map<String, dynamic>?>(
        future: _fetchProfileData(provider.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Profile not found.'));
          }

          final profileData = snapshot.data!;
          final isUser = profileData['type'] == 'user';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: profileData['ImageUrl'] != null
                      ? NetworkImage(profileData['ImageUrl'])
                      : null,
                  child: profileData['ImageUrl'] == null
                      ? const Icon(Icons.person, size: 80)
                      : null,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                     isUser? profileData['name'] :profileData['Name'] ?? 'No Name',
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ),
                if (!isUser)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      profileData['Profession'] ?? 'No Profession',
                      style: const TextStyle(fontSize: 30, fontStyle: FontStyle.italic,color: Colors.white),
                    ),
                  ),
                Center(child: Container(
                  width: width*0.4,
                  decoration: BoxDecoration(
                      color: Color(0xFF05696A),
                      borderRadius: BorderRadius.circular(10),

                  ),
                  child: Center(
                    child: TextButton(onPressed: ()
                    async{
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('isLoggedIn', -1);
   provider.isTherapist = false;
                        provider.toggleUid('0');
                         Navigator.pushReplacement( 
                            context,
                            PageTransition(
                          type: PageTransitionType.leftToRight, // Or any other type
                          child: Login(),
                        ));
                    }, child: FittedBox(child: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 20),))),
                  ),
                ),)
              ],
            ),
          );
        },
      ),
    ])));
  }
}
