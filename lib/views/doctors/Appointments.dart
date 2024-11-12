import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Dr_Appointments extends StatefulWidget {
  const Dr_Appointments({super.key});

  @override
  State<Dr_Appointments> createState() => _Dr_AppointmentsState();
}

class _Dr_AppointmentsState extends State<Dr_Appointments> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var uid = Provider.of<LoginProvider>(context).uid;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF05696A),
              Color(0xFF29BDBD),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: width * 0.5,
                margin: EdgeInsets.only(top: height*0.07),
                child: FittedBox(
                  child: Text(
                    'Sessions',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                width: width * 0.9,
                height: height * 0.7,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: provider.user == 0
                      ? FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('Doctors')
                          .doc(uid)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator(color: Colors.white));
                    }

                    var details = snapshot.data!.data() as Map<String, dynamic>?;
                    if (details == null || !details.containsKey('Appointments')) {
                      return Center(child: Text('No appointments Yet.', style: TextStyle(color: Colors.white, fontSize: 20)));
                    }

                    List<dynamic> appointments = details['Appointments'] ?? [];
                      if (appointments.isEmpty) {
                      return const Center(
                        child: Text('No Appointments Yet', style: TextStyle(color: Colors.white, fontSize: 20)),
                      );
                    }

              
                    return ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        var appointment = appointments[index];

                        // Ensure appointment is not null and contains expected keys
                        String doctorName = details['Doctor'] ?? 'Unknown';
                        String date = appointment['Date'] ?? 'No Date';
                        String time = appointment['Time'] ?? 'No Time';
                        String price = appointment['Price'] ?? '0';
                        String link = appointment['Link'] ?? 'No Link';
                        String profession = appointment['Profession'] ?? 'No Profession';
                        String patientName = appointment['Pname'] ?? 'No Name';
                        return Container(
                          margin: EdgeInsets.only(bottom: height*0.03),
                          decoration: BoxDecoration(
                            color: Color(0xFF05696A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: width * 0.9,
                          height: height * 0.15,
                          child: provider.user == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: width * 0.02),
                                          width: width * 0.35,
                                          height: height * 0.05,
                                          child: FittedBox(
                                            child: Text('Dr. $doctorName', style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.1),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          width: width * 0.4,
                                          child: FittedBox(
                                            child: Text(date, style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
                                          width: width * 0.35,
                                          child: Text(profession, style: TextStyle(color: Colors.white, fontSize: 15)),
                                        ),
                                        SizedBox(width: width * 0.30),
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          width: width * 0.2,
                                          child: FittedBox(
                                            child: Text(time, style: TextStyle(color: Colors.white, fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
                                          width: width * 0.65,
                                          height: height * 0.05,
                                          child: FittedBox(
                                            child: Text(link, style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.03),
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
                                          width: width * 0.15,
                                          height: height * 0.05,
                                          child: FittedBox(
                                            child: Text('Rs. $price', style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(left: width * 0.02),
                                          width: width * 0.3,
                                          height: height * 0.05,
                                          child: FittedBox(
                                            child: Text(patientName, style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.15),
                                        Container(
                                          height: height * 0.05,
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                          width: width * 0.4,
                                          child: FittedBox(
                                            child: Text(date, style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: height * 0.05,
                                          margin: EdgeInsets.fromLTRB(width * 0.02, 0, 0, 0),
                                          width: width * 0.3,
                                          child: FittedBox(
                                            child: Text('Rs. $price', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.25),
                                        Container(
                                          height: height * 0.05,
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          width: width * 0.3,
                                          child: Text(time, style: TextStyle(color: Colors.white, fontSize: 20)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.005, width: width * 0.0),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: width * 0.02),
                                          alignment: Alignment.topLeft,
                                          height: height * 0.05,
                                          width: width * 0.86,
                                          child: FittedBox(
                                            child: Text('Link: $link', style: TextStyle(color: Colors.white, fontSize: 20)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
