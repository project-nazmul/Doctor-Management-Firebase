import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteDoctor extends StatelessWidget {
  const DeleteDoctor({Key? key,required this.snapshot,required this.index}) : super(key: key);
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;
  deleteData(String i){

    FirebaseFirestore.instance.collection("users-form-data").doc(i).delete().then((value) => Fluttertoast.showToast(msg: '"Deleted Successfully"')).catchError((error)=>Fluttertoast.showToast(msg: "something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          //deleting student info
          deleteData(snapshot.data!.docs[index].id);

        },
        icon: const Icon(Icons.delete)
    );
  }
}
