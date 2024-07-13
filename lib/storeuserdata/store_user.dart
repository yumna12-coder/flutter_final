import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future addUserDetails(String userName,String email) async {
  await FirebaseFirestore.instance.collection('users').add({

    'user name':userName,
    'email':email,
  });
}
