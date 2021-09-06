// for adding new data to the data base and keeping the track of that added data.
// this is from the floating button(add).

import 'package:crud_flutter/screens/services/database.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  AddData({this.db});
  final Database? db;

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      appBar: AppBar(
        title: Text("Add"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 21),
                controller: nameController,
                decoration: viewDataInputDecoration("Enter your Name"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 21),
                controller: codeController,
                decoration: viewDataInputDecoration("Enter your Id"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        height: 55,
        // color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.lightBlue,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue, // background
              onPrimary: Colors.lightBlue.shade900, // foreground
            ),
            onPressed: () {
              widget.db!.add(nameController.text, codeController.text);
              Navigator.pop(context, true);
            },
            child: Text(
              "save",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration viewDataInputDecoration(String labelText) {
    return InputDecoration(
        focusColor: Colors.white,
        labelStyle: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        labelText: labelText,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.black, width: 2.0)));
  }
}
// TODO: 27