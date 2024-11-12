import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/Info_container.dart';
import 'package:flutter_application_1/components/parent_info.dart';
import 'package:flutter_application_1/providers/parent_info_container.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:fuzzy/fuzzy.dart';

import 'package:flutter_application_1/providers/enlarger_provider.dart';

class Admin extends StatefulWidget {
final int index; 

  const Admin({super.key, this.index = 1});
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  var  index = 1; 

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController phone = TextEditingController();


var height;
var width;

File? _image;
  Future<void> _pickImage() async {
    //final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    var pickedFile;
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
    var _enlarged_width_1;
  var _enlarged_height_1;
  







 
  @override
  Widget build(BuildContext context) {
    index = widget.index;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
      _enlarged_width_1 = width * 0.5;
      _enlarged_height_1 = height*0.3;
    var provider = Provider.of<ParentInfoContainer>(context);
    return Scaffold(
      
     
      body:
          Stack(children: [
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
             Align(
              alignment: Alignment.topCenter,
              child: Container(
             margin: EdgeInsets.fromLTRB(0,height*0.06,0,0),  
              child: FittedBox(
                child: Text('User Management.',
                style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: 'Font'),
                ),
              ),),
            ),
          Container(
            margin: EdgeInsets.only(top: height*0.05),
            child: ParentInfo(isUser: false,)),
           
        ],
      )
      //_buildStackContent()
    );
    
  }
  
}
