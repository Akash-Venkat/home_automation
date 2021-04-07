import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:relaypage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class relaypage extends StatefulWidget {
  @override
  _relaypageState createState() => _relaypageState();
}

class _relaypageState extends State<relaypage> {
  final dbref = FirebaseDatabase.instance.reference();

  Color bulb_color = Colors.white;
  Color back_button = Colors.white;

  writedata(String status){
    dbref.update({'STATUS':status});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 50,
          shadowColor: Colors.white,
          brightness: Brightness.dark,
          leading: FlatButton(
            child: Icon(
              Icons.arrow_back_sharp,
              color: back_button,
            ),
            onPressed: (){
              setState(() {
                back_button = Colors.red;
              });
              Future.delayed(Duration(seconds: 1),(){
                exit(0);
              });
            },
            color: Colors.grey,
          ),
          centerTitle: true,
          title: Text(
              'Relay Control',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
          ),
          backgroundColor: Colors.grey,
        ),
        backgroundColor: Colors.black,
        body:Padding(
          padding: const EdgeInsets.only(left: 0,top: 140 ),
          child: Center(
            child: Column(
              children: [
                Icon(
                    Icons.lightbulb,
                    size: 300,
                    color: bulb_color,
                ),
                SizedBox(height: 100,),
                FlatButton(
                  child: Text(
                      'On',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.green,
                  onPressed: (){
                    writedata("ON");
                    setState(() {
                      bulb_color = Colors.yellowAccent;
                    });
                  },
                ),
                FlatButton(
                  child: Text(
                    'Off',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: (){
                    writedata("OFF");
                    setState(() {
                      bulb_color = Colors.white;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}