import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String?selectedClass;
  String? selectedSection;
  final List<String> studentClass = [
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten'
  ];
  final List<String> studentSection = [
    'A',
    'B',
    'C',
    'D',
    'E'
  ];
  File? _image;
  final picker =ImagePicker();
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentFatherNameController = TextEditingController();
  final TextEditingController _studentMotherNameController = TextEditingController();
  final TextEditingController _studentDateofBirthController = TextEditingController();
  final TextEditingController _studentRollNoController = TextEditingController();
  final _formkey =GlobalKey<FormState>();
  final _formkey1 =GlobalKey<FormState>();
  String studentName ='';
  String studentFatherName ='';
  String studentMotherName ='';
  String studentDateofBirth ='';
  String studentRoll ='';

  Future getGallaryImage() async {
    //after getting image ,image will store in pickedFile otherwise it will wait
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No images");
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No images");
      }
    });
  }
  void dialog(context){
    showDialog(context: context,
        builder:(BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        content:Container(
          height: 120,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getCameraImage();
                  Navigator.pop(context);
                },
                child: const ListTile(
                    leading: Icon(Icons.camera), title: Text("Camera")),
              ),
              InkWell(
                onTap: () {
                  getGallaryImage();
                  Navigator.pop(context);
                },
                child: const ListTile(
                    leading: Icon(Icons.photo_library_outlined),
                    title: Text("Gallery")),
              )
            ],

          ),
        ) ,

      );
        }, );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  dialog(context);//to show dialog
                },
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width,
                    child: _image != null?ClipRRect(
                      child: Image.file(_image!.absolute,
                      height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                        :Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        ),
                      ),

                    ),

                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Form(
                key: _formkey,
                  child: Column(
                children: [
                  TextFormField(
                    controller: _studentNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Student Full Name',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                      labelStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                    ),
                    onChanged: (String value){
                      studentName=value;
                    },
                    validator: (value){
                      return value!.isEmpty?'Enter Your Name':null;
                    },
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: _studentFatherNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Father Name',
                      hintText: 'Father Full Name',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                      labelStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                    ),
                    onChanged:(String value){
                      studentFatherName=value;
                    } ,
                    validator: (value){
                      return value!.isEmpty ? "Enter Your Father Name":null;
                    },
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: _studentMotherNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Mother Name',
                      hintText: 'Mother Full Name',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                      labelStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                    ),
                    onChanged: (String value){
                      studentMotherName = value;
                    },
                    validator: (value){
                      return value!.isEmpty ? "Enter Your Mother Name":null;
                    },
                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: _studentDateofBirthController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'dd-mm-yyyy',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                      labelStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                    ),
                    onChanged: (String value){
                      studentDateofBirth =value;
                    },
                    validator: (value){
                      return value!.isEmpty ? "Enter Your Date of Birth":null;
                    },
                  ),
                  const SizedBox(height: 5,),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                    isExpanded: true,
                    hint: const Text("Select Your Class",
                      style: TextStyle(fontSize: 16,
                          color: Colors.grey),),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 00,right: 10),
                    dropdownDecoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items:studentClass.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ))).toList(),
                    onChanged: (value){},
                    validator: (value){
                      if (value == null){
                        return 'Please Select Class';
                      }
                    },
                    onSaved: (value){
                      selectedClass =value.toString();
                    },
                  ),
                  const SizedBox(height: 5,),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                    isExpanded: true,
                    hint: const Text("Select Your Section",
                      style: TextStyle(fontSize: 16,
                          color: Colors.grey

                      ),),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 00,right: 10),
                    dropdownDecoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items:studentSection.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ))).toList(),
                    onChanged: (value){
                      selectedSection = value;
                    },
                    validator: (value){
                      if (value == null){
                        return 'Please Select Section';
                      }
                    },
                    onSaved: (value){
                      selectedSection  =value.toString();
                    },

                  ),
                  const SizedBox(height: 5,),
                  TextFormField(
                    controller: _studentRollNoController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Roll No',
                      hintText: 'Enter Your Roll No',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                      labelStyle: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.normal),
                    ),
                    onChanged: (String value){
                      studentRoll = value;
                    },
                    validator: (value){
                      return value!.isEmpty ? 'Enter Your Roll No':null;
                    },
                  ),
                ],
              )),
              GestureDetector(
                onTap: () async{
                  if(_formkey.currentState!.validate()){

                  };
                },
                child: Container(height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade400
                ),
                child: Center(
                  child: Text("Upload",style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
