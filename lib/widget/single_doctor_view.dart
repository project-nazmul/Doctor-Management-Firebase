import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_management_firebase/widget/delete_doctor.dart';
import 'package:doctor_management_firebase/widget/edit_doctor.dart';
import 'package:flutter/material.dart';

class SingleDoctorView extends StatelessWidget {
  const SingleDoctorView({Key? key,required this.snapshot,required this.nameController,required this.emailController}) : super(key: key);
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final TextEditingController nameController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {

        return Card(
          child: ListTile(
            leading: CircleAvatar(
                child: Text(
                  snapshot.data!.docs[index]['name'][0],
                )),
            title: Text(snapshot.data!.docs[index]['name']),
            subtitle: Text(snapshot.data!.docs[index]['email']),
            trailing: FittedBox(
              child: Row(
                children: [
                  DeleteDoctor(snapshot: snapshot, index: index),
                  EditDoctor(nameController: nameController, emailController: emailController, snapshot: snapshot, index: index),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
