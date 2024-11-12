import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/providers/Firebase_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TherapistApplicationsPage extends StatefulWidget {
  @override
  _TherapistApplicationsPageState createState() => _TherapistApplicationsPageState();
}

class _TherapistApplicationsPageState extends State<TherapistApplicationsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var provider;
  Future<List<Map<String, dynamic>>> _fetchApplications(provider) async {
    if (provider.applications.isEmpty)
    {
    List<Map<String, dynamic>> applications = [];

    QuerySnapshot querySnapshot = await _firestore.collection('Therapist_Applications').get();
    for (var doc in querySnapshot.docs) {
      
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id; // Store the document ID with the data

    applications.add(data);
    }
    provider.store_applications(applications);
      return applications;

    }

      return provider.applications;
  }



 

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    provider = Provider.of<CloudData>(context);
    return Scaffold(
    
      body: 
      
      Container(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width*0.75,
                margin: EdgeInsets.only(top: height*0.05,bottom: height*0.03),
                child: FittedBox(child: Text("Therapists' Applications",style: TextStyle(color: Colors.white,fontSize: 40),)),),
            Container(
              width: width*0.95,
              height: height,
              child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchApplications(provider),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.white,));
                }
                      
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                      
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No applications found.'));
                }
                      
                final applications = snapshot.data!.where((app) => app['Status'] != "2" && app['Status']!="0")
        .toList();
      
                      if (applications.isEmpty) {
  return Container(
    alignment: Alignment.topCenter,
    child: Text(
      'No applications',
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}
                return ListView.builder(
                  itemCount: applications.length,
                  itemBuilder: (context, index) {
                    final application = applications[index];
                    return Container(
                      padding: EdgeInsets.all(5),
                     width: width*0.8,
                     //height: height*0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFF29BDBD),
                        borderRadius: BorderRadius.circular(10)
                      ),
                     child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                      Column(children: [
                        if (application['ImageUrl'] != null)
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                  height: 100,
                                  width: 100,
                                  child: Image.network(application['ImageUrl'].toString(), fit: BoxFit.cover)),
                              // Display the resume link as a button
                      Text(application['Name'] ?? 'No Name',style: TextStyle(color: Colors.white),),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text('Email: ${application['Email'] ?? 'No Email'}',style: TextStyle(color: Colors.white))),

                      ],),
                      SizedBox(width: width*0.1,),
                      Column(children: [

                          Container(
                            width: width*0.3,
                            child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF05696A), // Set button color
                                                    ),
                                  onPressed: () async{
                                    await _firestore.collection('Therapist_Applications').doc(application['id']).update({
                                  'Status': "0", // Set status to 2 (approved)
                                });
                                provider.setStatus(index,"0");
                                                 ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Disapproved"), // Use display name if available
                                    backgroundColor: Colors.blueGrey,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                );
                                applications.removeWhere((app) => app['id'] == application['id']);
                                  },
                                  
                                  child: FittedBox(child: Text('Disapprove',style: TextStyle(color: Colors.white),)),
                                ),
                          ),
                      SizedBox(height: height*0.01,),
                         Container(
                           width: width*0.3,

                           child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(0xFF05696A), // Set button color
                                                ),
                               onPressed: () async{
                                
                                                 await _firestore.collection('Therapist_Applications').doc(application['id']).update({
                              'Status': "2", // Set status to 2 (approved)
                            });

                            provider.setStatus(index,"2");
                            ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Approved"), // Use display name if available
                                        backgroundColor: Color(0xFF05696A),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                      ),
                                    );

                                applications.removeWhere((app) => app['id'] == application['id']);

                               },
                               child: FittedBox(child: Text('Approve',style: TextStyle(color: Colors.white),)),
                             ),
                         ),
                        SizedBox(height: height*0.01,),

                       if (application['ResumeUrl'] != null)
                                Container(
                                  width: width*0.3,

                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                                            backgroundColor: Color(0xFF05696A), // Set button color
                                                          ),
                                    onPressed: () {
                                      // Open the resume PDF in a webview or similar
                                      _openResume(application['ResumeUrl']);
                                    },
                                    child: FittedBox(child: Text('View Resume',style: TextStyle(color: Colors.white),)),
                                  ),
                                ),

                     
                   
 ],),
                     ],),
                   
                        
                      
                    );
                  },
                );
              },
                      ),
            ),
                ]),
        )),
    );
  }

  void _openResume(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open resume URL.')));
    }
  }
}
