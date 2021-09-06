// import 'dart:html';

import 'package:crud_flutter/add_screen.dart';
import 'package:crud_flutter/database.dart';
import 'package:crud_flutter/view_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Center(child: MyHomePage(title: 'Firebase CRUD')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool flagFetched = false;
  List docs = [];
  Database db = Database();

  initialise() async {
    db.initialise();
    db.read().then((value) => setState(() {
          docs = value;
          flagFetched = true;
          print("The docs list are $docs");
        }));
  }

  // TODO: I am 18 25
  @override
  void initState() {
    super.initState();

    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(color: Colors.amber),
        )),
      ),
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewData(
                              name: docs[index],
                              db: db,
                            ))).then((value) => {
                      if (value != null) {initialise()}
                    });
              },
              contentPadding: EdgeInsets.only(right: 70, left: 30),
              title: flagFetched
                  ? Text(docs[index]['name'])
                  : Text(
                      "Loading",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
              trailing: flagFetched
                  ? Text(docs[index]['code'])
                  : Text(
                      "Loading",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[400],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddData(
                        db: db,
                      ))).then((value) {
            if (value != null) {
              setState(() {
                initialise();
              });
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
