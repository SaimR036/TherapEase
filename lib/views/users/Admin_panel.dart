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
      
      appBar: index==1? AppBar(
        
        backgroundColor: Color(0xFF05696A),
        title: Center(child: Text('Admin Panel', style: TextStyle(fontFamily: 'Font', fontSize: 30, color: Colors.white))),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text('Manage Dr.s',style: TextStyle(fontFamily: 'Font',fontSize: 20),)),
            Tab(child: Text('Add Dr.',style: TextStyle(fontFamily: 'Font',fontSize: 20),)),
          ],
        ),
      ):null,
      body:TabBarView(
        controller: _tabController,
        children: [
          Stack(children: [
          ParentInfo(isUser: false,),
           Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              width: width,
              height: height*0.03,
              color: Colors.white,
              ),
            ),
            Align(
              
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xFF05696A),),
              height: provider.enlarged_adder==true? height*0.3: height*0.01,
              width: provider.enlarged_adder==true? width*0.7: width*0.05,

              margin: provider.enlarged_adder==true? EdgeInsets.fromLTRB(0,0,0,height*0.2): EdgeInsets.fromLTRB(0,0,0,height*0.05),
              child: 
              provider.show_adder==true?
              Stack(children: [ 
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                    child:Text('Add a Dr.',style: TextStyle(fontFamily: 'Font',fontSize: 25,color:Colors.white),)),
                ),

                Container(
                  width: _enlarged_width_1*0.27,
                  height: height*0.3*0.27,
                  margin: EdgeInsets.fromLTRB(_enlarged_width_1*0.03, _enlarged_height_1*0.15,0,0),
                  child:CircleAvatar(backgroundImage: _image==null? null:FileImage(_image!))),
            Container(
                  width: width*0.5*0.8,
                  height: height*0.3*0.1,
                  margin: EdgeInsets.fromLTRB(_enlarged_width_1*0.42, _enlarged_height_1*0.18,0,0),
                  child:TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: 'Enter Full Name'),)),
            Container(
                  width: width*0.5*0.8,
                  height: height*0.3*0.1,
                  margin: EdgeInsets.fromLTRB(_enlarged_width_1*0.42, _enlarged_height_1*0.33,0,0),
                  child:TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: 'Enter Email'),)),
            Container(
                  width: width*0.5*0.8,
                  height: height*0.3*0.1,
                  margin: EdgeInsets.fromLTRB(_enlarged_width_1*0.42, _enlarged_height_1*0.48,0,0),
                  child:TextField(
                    controller: cnic,
                    decoration: InputDecoration(hintText: 'Enter CNIC'),)),
            Container(
                  width: width*0.5*0.8,
                  height: height*0.3*0.1,
                  margin: EdgeInsets.fromLTRB(_enlarged_width_1*0.42, _enlarged_height_1*0.63,0,0),
                  child:TextField(
                    controller: phone,
                    decoration: InputDecoration(hintText: 'Enter Phone'),)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                    
                    margin: EdgeInsets.fromLTRB(0,0,0,_enlarged_height_1*0.1),
                    child:TextButton(child: Text('Save',style: TextStyle(fontFamily: 'Font'),),
                    onPressed: () async{
                      try{
await FirebaseFirestore.instance.collection('Doctors').doc(email.text).set({
            'Name': name.text,
            'Email':email.text,
            'Cnic': cnic.text,
            'Phone':phone.text

          });
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
    content: Text('Dr. added successfully',style: TextStyle(fontFamily: 'Font'),),
    backgroundColor: Color(0xFF05696A), // Dark green color
    behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
    shape: RoundedRectangleBorder(       // Add rounded corners
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),          );
  name.text='';
  email.text='';
  cnic.text='';
  phone.text='';
                      }
                      catch(e)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
    content: Text(e.toString(),style: TextStyle(fontFamily: 'Font'),),
    backgroundColor: Color(0xFF05696A), // Dark green color
    behavior: SnackBarBehavior.floating, // Make it floating for rounded corners
    shape: RoundedRectangleBorder(       // Add rounded corners
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),          );
                    }
                    },
                    )),
            ),
            
            
            Container(
              width: width*0.5*0.1,
              height: height*0.3*0.1,
              margin: EdgeInsets.fromLTRB(width*0.5*0.22, height*0.3*0.32,0,0),
              child: IconButton(
                onPressed: _pickImage,
                icon: Icon(Icons.add_a_photo_outlined),
              ),
            ),



              ],): Text('fdsfsdfs'), )
            ),

            Align(
              
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color(0xFF05696A),),
                
              margin: EdgeInsets.fromLTRB(0,0,0,height*0.01),
              child: IconButton(
                
                icon: provider.enlarged_adder==true? Icon(Icons.minimize): Icon(Icons.add), onPressed: (){
              if(provider.enlarged_adder==true)
              {
                setState(() {
                  provider.enlarged_adder=false;
                });
                Future.delayed(Duration(milliseconds: 100),(){
setState(() {
  provider.show_adder=false;
});

                });
              }
              else if(provider.enlarged_adder==false)
              {
              setState(() {
                provider.enlarged_adder=true;
               });
              Future.delayed(Duration(milliseconds: 250),(){
setState(() {
  provider.show_adder=true;
});

                });
               
  }}, iconSize: 50,),
            ))
              ])

      ,
          Text('')
          // Stack(
          //     children: [
          //     Container(
          //   decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //   begin: Alignment.topCenter, // Gradient starting point
          //   end: Alignment.bottomCenter, // Gradient ending point
          //   colors: [
          //   Color(0xFF05696A), // First hex color (Blue)
          //   Color(0xFF29BDBD), // Second hex color (Red)
          //   ],
          //   ),
          //   ),
          //   ),

          //     ],

          // ),
        ],
      )
      //_buildStackContent()
    );
    
  }
  
}
