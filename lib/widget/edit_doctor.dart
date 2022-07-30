import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditDoctor extends StatelessWidget {
  const EditDoctor({Key? key,required this.nameController,required this.emailController,required this.snapshot,required this.index}) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController emailController;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  updateData(String i,String n,String e){
    FirebaseFirestore.instance.collection("users-form-data").doc(i).update(
        {
          "name":n,
          "email":e,
        }
    ).then((value) => Fluttertoast.showToast(msg: '"Updated Successfully"')).catchError((error)=>Fluttertoast.showToast(msg: "something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          nameController.text = snapshot.data!.docs[index]['name'];
          emailController.text = snapshot.data!.docs[index]['email'];
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('EDIT Doctor INFO'),
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

                        //Replacing with edited data
                        updateData(snapshot.data!.docs[index].id, nameController.text, emailController.text);

                        nameController.clear();
                        emailController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Submit'))
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.edit));
  }
}
