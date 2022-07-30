import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_management_firebase/widget/insert_doctor_view.dart';
import 'package:doctor_management_firebase/widget/single_doctor_view.dart';
import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Info'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users-form-data").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something is wrong"),
            );
          }
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          return SingleDoctorView(snapshot: snapshot, nameController: nameController, emailController: emailController);
          },
      ),

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return InsertDoctorView(nameController: nameController, emailController: emailController);
              },
            );
          }),
    );
  }
}
