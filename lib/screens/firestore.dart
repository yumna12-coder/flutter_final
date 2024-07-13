import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CenterScreen extends StatefulWidget {
  const CenterScreen({super.key});

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar()
,

body:Center(child: Text("Center"),),
    );
  }
}
