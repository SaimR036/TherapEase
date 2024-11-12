import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:flutter_application_1/views/users/Login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentApprovalPage extends StatefulWidget {
  @override
  _PaymentApprovalPageState createState() => _PaymentApprovalPageState();
}

class _PaymentApprovalPageState extends State<PaymentApprovalPage> {
  bool isLoading = false;

  Future<void> updateStatus(var paymentDoc,var id, bool isApproved) async {
    try {
      if(isApproved)
      {
      setState(() {
        isLoading = true;
      });

      DocumentReference doctorRef = FirebaseFirestore.instance.collection('Doctors').doc(paymentDoc['DocId']);
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(paymentDoc['Uid']);
      DocumentSnapshot docSnapshot = await doctorRef.get();

      // Loop through each payment document
      String doctorName = paymentDoc['Doctor'];
      String date = paymentDoc['Date'];
      String time = paymentDoc['Time'];
      String pname = paymentDoc['Pname'];
      String link = paymentDoc['Link'];
      String price = paymentDoc['Price'];
      String profession = paymentDoc['Profession'];
      String imageUrl = paymentDoc['ImageUrl']; // Assuming you have an ImageUrl field
      var slots = docSnapshot['Slots'];
      String Uid = paymentDoc['Uid'];
      String DocId = paymentDoc['DocId'];
      // Appointment maps
      Map<String, String> doctorAppointment = {
        'Pname': pname,
        'Date': date,
        'Time': time,
        'Link': link,
        'Price': price,
        'Uid': Uid
      };

      Map<String, String> userAppointment = {
        'Doctor': doctorName,
        'Date': date,
        'Time': time,
        'Link': link,
        'Price': price,
        'Profession': profession,
        'IsReviewed':'0',
        'DocId':DocId
      };

      // If approved, update doctor's and user's appointments
        await doctorRef.update({
          'Appointments': FieldValue.arrayUnion([doctorAppointment])
        });
        await userRef.update({
          'Appointments': FieldValue.arrayUnion([userAppointment])
        });

        // Find and book the slot
        bool slotFound = false;
        for (var i = 0; i < slots.length; i++) {
          var slot = slots[i];

          // Check if the slot matches the specified date and time
          if (slot['Date'] == date && slot['Time'] == time) {
            // Set booked status to 1
            slot['Booked'] = 1; // Update the slot to booked
            slotFound = true;
            break;
          }
        }

        if (slotFound) {
          // Update the doctor's document with the modified slots array
          await doctorRef.update({
            'Slots': slots, // Save the modified slots array
          });
          print('Slot booked successfully!');
        }
      await FirebaseFirestore.instance
          .collection('Payment_Screenshots')
          .doc(id) // Use the document ID to delete it
          .delete();
        // Show approval message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Payment Approved"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
      } else {
        // If disapproved, delete the record from Payment_Screenshots
        await FirebaseFirestore.instance
          .collection('Payment_Screenshots')
          .doc(id) // Use the document ID to delete it
          .delete();

        // Show disapproval message
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Payment Disapproved"), // Use display name if available
            backgroundColor: Color(0xFF05696A),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        );
      }
    } catch (e) {
      print('Error updating status: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      var provider = Provider.of<LoginProvider>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Gradient starting point
            end: Alignment.bottomCenter, // Gradient ending point
            colors: [
              Color(0xFF05696A), // First hex color (Blue)
              Color(0xFF29BDBD), // Second hex color (Green)
            ],
          ),
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: height*0.1),
            child:Text("Payment Approval",style: TextStyle(fontSize: 40,color: Colors.white),)),
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
                        provider.toggleUid('0');
                         Navigator.pushReplacement( 
                            context,
                            PageTransition(
                          type: PageTransitionType.leftToRight, // Or any other type
                          child: Login(),
                        ));
                    }, child: FittedBox(child: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 20),))),
                  ),
                ),),
          Container(
            width: width*0.9,
            height: height*0.65,
            child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('Payment_Screenshots')
                .get(), // Fetch all payments
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.white,));
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error fetching payment details"));
              }
            
              // Payment data
              final payments = snapshot.data!.docs;
            
              if (payments.isEmpty) {
                return Center(child: Text("No Approvals pending",style: TextStyle(color: Colors.white),));
              }
            
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final data = payments[index].data() as Map<String, dynamic>;
                    final id = payments[index].reference.id;
                    return Card(
                      shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.black, width: 2), // Set border color and width
    borderRadius: BorderRadius.circular(10), // Set border radius for rounded corners
  ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      color: Color(0xFF29BDBD), // Card color
                      child: Padding(
                        
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Doctor: ${data['Doctor']}", style: TextStyle(fontSize: 20,color: Colors.white)),
                            Text("Date: ${data['Date']}", style: TextStyle(fontSize: 20,color: Colors.white)),
                            Text("Time: ${data['Time']}", style: TextStyle(fontSize: 20,color: Colors.white)),
                            Text("Patient Name: ${data['Pname']}", style: TextStyle(fontSize: 20,color: Colors.white)),
                            Text("Price: ${data['Price']}", style: TextStyle(fontSize: 20,color: Colors.white)),
                            SizedBox(height: 20),
            
                            // Display the image
                            if (data.containsKey('ImageUrl')) // Check if ImageUrl exists
                              GestureDetector(
                                onTap: () {
                                  // Open the image in a new screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageViewPage(imageUrl: data['ImageUrl']),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Image.network(
                                    data['ImageUrl'],
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
            
                            SizedBox(height: 20),
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => updateStatus(data,id, true), // Approve
                                        child: Text("Approve",style: TextStyle(color: Colors.white)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.green)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => updateStatus(data,id, false), // Disapprove
                                        child: Text("Disapprove",style: TextStyle(color: Colors.white)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.red)),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
                    ),
          ),
      ]))
    );
  }
}

class ImageViewPage extends StatelessWidget {
  final String imageUrl;

  ImageViewPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image View"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Gradient starting point
            end: Alignment.bottomCenter, // Gradient ending point
            colors: [
              Color(0xFF05696A), // First hex color (Blue)
              Color(0xFF29BDBD), // Second hex color (Green)
            ],
          ),
        ),
        child: Center(
          child: Image.network(imageUrl), // Display the image
        ),
      ),
    );
  }
}
