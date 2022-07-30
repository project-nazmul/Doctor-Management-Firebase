import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InsertDoctorView extends StatelessWidget {
  const InsertDoctorView({Key? key,required this.nameController,required this.emailController}) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController emailController;

  sendUserDataToDB(String n,String e)async{

    FirebaseFirestore.instance.collection("users-form-data").doc().set({
      "name":n,
      "email":e,
    }).then((value) => Fluttertoast.showToast(msg: '"Inserted Successfully"')).catchError((error)=>Fluttertoast.showToast(msg: "something is wrong. $error"));
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ADD NEW Doctor'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_box),
                        label: Text('Name'),
                      ),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        label: Text('Email'),
                      ),
                      controller: emailController,
                    ),
                  ],
                ),
              )),

        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {

              //adding new student
              sendUserDataToDB(nameController.text, emailController.text);

              nameController.clear();
              emailController.clear();
              Navigator.pop(context);
            },
            child: const Text('Submit'))
      ],

    );
  }
}
