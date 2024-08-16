import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/Info_container.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:fuzzy/fuzzy.dart';

import '../providers/enlarger_provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
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
  File? _image;
  var show_adder=false;
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
   var curr_height;
  var curr_width;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController phone = TextEditingController();
  var _enlarged_width_1;
  var _enlarged_height_1;
  var IndProvider;
var _enlarged=false;
var search_enlarged=false;
var ind=-1;
var a =0;
var show=false;
var closest;
var enlarged_adder=false;
var _isLoading = false;
void searchName(String name) async {

  var closest;
      final fuse = Fuzzy(allDoctors.map((doc) => doc['Name']).toList());
  final results = fuse.search(name);

    if (results.isNotEmpty) {
    // Take up to 3 results, or all if there are less than 3
    final filteredResults = results.take(3).toList();

    // Map the filtered results back to the original DocumentSnapshot objects
    final closestDoctors = filteredResults.map((result) => allDoctors[result.item.index]).toList();
    IndProvider.toggleClosest(closestDoctors);
  
  }

    
  }
List<DocumentSnapshot> allDoctors = [];
var search_one=false;
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

      _enlarged_width_1 = width * 0.5;
      _enlarged_height_1 = height*0.3;
    var enlarged_height = height * 0.4;
  var normal_height = height * 0.07;
  
  var enlarged_width = width *0.8;
  var normal_width = width * 0.8;
  _enlarged == true? curr_height = enlarged_height: curr_height = normal_height;
  _enlarged == true? curr_width = enlarged_width: curr_width = normal_width;
    IndProvider = Provider.of<EnlargerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Color(0xFF05696A),
        title: Center(child: Text('Admin Panel', style: TextStyle(fontFamily: 'Font', fontSize: 30, color: Colors.white))),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text('Manage Dr.s',style: TextStyle(fontFamily: 'Font',fontSize: 20),)),
            Tab(child: Text('Add Dr.',style: TextStyle(fontFamily: 'Font',fontSize: 20),)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Stack(
              children: [
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
            Container(
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(10)
              ),
              width: width*0.55,
              height: height*0.05,
              margin:EdgeInsets.fromLTRB(width*0.07,height*0.1,0,0),
              padding: EdgeInsets.fromLTRB(width*0.01,0,height*0.005,width*0.01),
              child:TextField(
                
              decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black)
              
              
              ),onSubmitted: (value) {
                setState(() {
                  _isLoading = true;
                });
                searchName(value);
                setState(() {
                 _isLoading = false;

                  search_one = true;
                });
              },)


            ),

            Container(
              decoration: BoxDecoration(color: Color(0xFF29BDBD),
              borderRadius: BorderRadius.circular(10)
              ),
              width: width*0.08,
              height: height*0.05,
              margin:EdgeInsets.fromLTRB(width*0.65,height*0.1,0,0),
              child:IconButton(onPressed:(){
                setState(() {
                  
                search_one = false;                });

              },
              icon: Icon(Icons.refresh_outlined),
              )


            ),
            Container(
              decoration: BoxDecoration(color: Color(0xFF29BDBD),
              borderRadius: BorderRadius.circular(10)
              ),
              width: width*0.15,
              height: height*0.05,
              margin:EdgeInsets.fromLTRB(width*0.75,height*0.1,0,0),
              child:TextButton(onPressed:(){},
              child:Text('Type',style: TextStyle(
                fontSize: 20,
                fontFamily: 'Font',color: Colors.white),)
              )


            ),
            Align(
              alignment: Alignment.topCenter,
              child: _isLoading==true? 
              Container(
                
                margin: EdgeInsets.fromLTRB(0,height*0.4,0,0),
                child:  CircularProgressIndicator()):
              
               Container(
                
                margin: EdgeInsets.fromLTRB(0,height*0.15,0,0),
                child:  allDoctors.length!=0?
                ListView.builder(
                      itemCount: search_one==true? IndProvider.closest.length: allDoctors.length,
                      itemBuilder: (context, index) {
                        var doctor = search_one==true? IndProvider.closest[index] : allDoctors[index];
                        return GestureDetector(
                    onTap: ()
                    {
                      if(IndProvider.ind==index)
                      {
                        setState(() {
                        IndProvider.toggleInd(-1);
                         
                        _enlarged=false;
                      });
                       Future.delayed(Duration(milliseconds: 700),(){
            setState(() {
              show=false;
            });});
                      }
                      else{
                      setState(() {
                        IndProvider.toggleInd(index);
                        _enlarged=true;
                      });
                      print(ind);print(index);
                      Future.delayed(Duration(milliseconds: 200),(){
            setState(() {
              show=true;
            });
            
                      });
                      }
                    },
                    child: TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: IndProvider.ind,index:index, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width)
                    // child: search_one==true? search_enlarged==true? TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: 1,index:1, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width, ):  TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: 0,index:1, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width, ) : TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: ind,index:index, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width, ) 
                     ); },
                    ):
                
                
                
                
                
                
                  StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(0,height*0.1,0,0),
                        child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        allDoctors = snapshot.data!.docs;
                        var doctor = snapshot.data!.docs[index];
                        return GestureDetector(
                    onTap: ()
                    {
                      
                      if(IndProvider.ind==index)
                      {
                        setState(() {
                        IndProvider.toggleInd(-1);
                         
                        _enlarged=false;
                      });
                       Future.delayed(Duration(milliseconds: 700),(){
            setState(() {
              show=false;
            });});
                      }
                      else{
                      setState(() {
                        IndProvider.toggleInd(index);
                        _enlarged=true;
                      });
                      print(ind);print(index);
                      Future.delayed(Duration(milliseconds: 200),(){
            setState(() {
              show=true;
            });
            
                      });
                      }
                    },
                    child: TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: IndProvider.ind,index:index, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width)
                    // child: search_one==true? search_enlarged==true? TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: 1,index:1, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width, ):  TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: 0,index:1, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width, ) : TextContainer(height: height, width: width, normalHeight: normal_height, normalWidth: normal_width,   doctor: doctor,show: show, ind: ind,index:index, enlarged: _enlarged, enlargedHeight: enlarged_height, enlargedWidth: enlarged_width, ) 
                     ); },
                    );
                  },
                )
              ),
            )



,
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
              height: enlarged_adder==true? height*0.3: height*0.01,
              width: enlarged_adder==true? width*0.7: width*0.05,

              margin: enlarged_adder==true? EdgeInsets.fromLTRB(0,0,0,height*0.2): EdgeInsets.fromLTRB(0,0,0,height*0.05),
              child: 
              show_adder==true?
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
                
                icon: enlarged_adder==true? Icon(Icons.minimize): Icon(Icons.add), onPressed: (){
              print(enlarged_adder);
              if(enlarged_adder==true)
              {
                print('Hello');
                setState(() {
                  enlarged_adder=false;
                });
                Future.delayed(Duration(milliseconds: 100),(){
setState(() {
  show_adder=false;
});

                });
              }
              else if(enlarged_adder==false)
              {
              print(enlarged_adder);
              setState(() {
                print('yay');
                enlarged_adder=true;
                print(enlarged_adder);
               });
              Future.delayed(Duration(milliseconds: 250),(){
setState(() {
  show_adder=true;
});

                });
print(enlarged_adder);
               
  }}, iconSize: 50,),
            ))
              ],

          ),
          Stack(
              children: [
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

              ],

          ),
        ],
      ),
    );
  }
}
