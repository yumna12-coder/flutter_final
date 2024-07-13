import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataFromApi extends StatefulWidget {
  const DataFromApi({super.key});

  @override
  State<DataFromApi> createState() => _DataFromApiState();
}

class _DataFromApiState extends State<DataFromApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar:AppBar(title: Text("DataFromApi",) ,),
body: Center(child:

 Text("DatafromApi"),),

    );
  }
}
