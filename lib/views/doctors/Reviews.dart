import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.only(top: height * 0.05),
                child: FittedBox(
                  child: Text(
                    'Reviews',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                width: width * 0.9,
                height: height * 0.7,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Doctors').doc(uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    }

                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.data() == null) {
                      return const Center(child: Text('No Reviews Yet', style: TextStyle(color: Colors.white, fontSize: 20)));
                    }

                    var details = snapshot.data!.data() as Map<String, dynamic>;
                    List<dynamic> reviews = details['Reviews'] ?? [];

                    if (reviews.isEmpty) {
                      return const Center(
                        child: Text('No Reviews Yet', style: TextStyle(color: Colors.white, fontSize: 20)),
                      );
                    }

                    return ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        var review = reviews[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: height * 0.02),
                          decoration: BoxDecoration(
                            color: Color(0xFF05696A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: width * 0.4,
                                    margin: EdgeInsets.only(left: width * 0.02),
                                    child: FittedBox(
                                      child: Text(
                                        review['Pname'],
                                        style: TextStyle(fontSize: 15, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.09, height: height * 0.03),
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: width * 0.3,
                                    margin: EdgeInsets.only(top: 2),
                                    child: FittedBox(
                                      child: Text(
                                        review['Rating'].toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: width * 0.05,
                                    child: Icon(Icons.star, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.003),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.fromLTRB(width * 0.02, 0, height * 0.02, width * 0.02),
                                child: Text(
                                  review['Review'],
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
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
