import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class TherapistApplicationsPage extends StatefulWidget {
  @override
  _TherapistApplicationsPageState createState() => _TherapistApplicationsPageState();
}

class _TherapistApplicationsPageState extends State<TherapistApplicationsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> _fetchApplications() async {
    List<Map<String, dynamic>> applications = [];

    QuerySnapshot querySnapshot = await _firestore.collection('Therapist_Applications').get();
    for (var doc in querySnapshot.docs) {
      applications.add(doc.data() as Map<String, dynamic>);
    }
    return applications;
  }

  Future<void> _approveApplication(String email, String password, Map<String, dynamic> applicationData) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      // Store therapist details in Firestore under the 'therapists' collection
      await _firestore.collection('therapists').doc(uid).set({
        'uid': uid,
        'name': applicationData['Name'],
        'email': email,
        'profileUrl': applicationData['ProfileUrl'],
        'resumeUrl': applicationData['ResumeUrl'],
      });

      await _firestore.collection('Therapist_Applications').doc(applicationData['id']).delete();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Application approved successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error approving application: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Applications'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchApplications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No applications found.'));
          }

          final applications = snapshot.data!;

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(application['Name'] ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${application['Email'] ?? 'No Email'}'),
                      // Display the profile image
                      if (application['ProfileUrl'] != null)
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(application['ProfileUrl'], height: 100, fit: BoxFit.cover)),
                      // Display the resume link as a button
                      if (application['ResumeUrl'] != null)
                        ElevatedButton(
                          onPressed: () {
                            // Open the resume PDF in a webview or similar
                            // This can be implemented based on your requirements
                            _openResume(application['ResumeUrl']);
                          },
                          child: Text('View Resume'),
                        ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Call approve application with the email and password
                      _approveApplication(application['Email'], application['Password'], application);
                    },
                    child: Text('Approve'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openResume(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open resume URL.')));
    }
  }
}
