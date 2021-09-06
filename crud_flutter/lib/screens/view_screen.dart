import 'package:crud_flutter/database.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  ViewData({this.name, this.db});
  Map? name;
  Database? db;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  void initState() {
    super.initState();
    print(widget.name);
    nameController.text = widget.name?['name'];
    codeController.text = widget.name?['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      appBar: AppBar(
        title: Text("Update"),
        actions: [
          IconButton(
            onPressed: () {
              widget.db!.delet(widget.name!['id']);
              Navigator.pop(context, true);
            },
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
              widget.db!.update(
                  widget.name!['id'], nameController.text, codeController.text);
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