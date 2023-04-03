import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:promp_flutter_final/model/create.dart';
import 'package:promp_flutter_final/model/edit.dart';
import 'package:promp_flutter_final/model/login.dart';
import 'package:promp_flutter_final/service/auth.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Flutter Project',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  AuthService _service = AuthService();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool click = false;
  @override
  Widget build(BuildContext context) {
    User? currentUser = _service.user;
    String displayEmail = "";
    if (currentUser != null && currentUser.email != null) {
      displayEmail = currentUser.email!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          SizedBox(
              height: 50,
              child: DrawerHeader(
                  child: Text(
                "Hello User $displayEmail",
              ))),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              _service.logout(currentUser);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You've been logged out")));
            },
          )
        ],
      )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(_service.user!.email.toString())
            .snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null)
            return const Text("Your Reminder supposed to be here.");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(dataDocuments[index]["name"].toString()),
                          subtitle:
                              Text(dataDocuments[index]["desc"].toString()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Last modified: " +
                                dataDocuments[index]["dtadd"].toString()),
                            IconButton(
                                onPressed: () => _editNote(
                                    dataDocuments[index].id,
                                    dataDocuments[index]["name"],
                                    dataDocuments[index]["desc"]),
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNote,
        tooltip: 'Create New Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNote() {
    Navigator.push(context as BuildContext,
        MaterialPageRoute(builder: (context) => CreatePage()));
  }

  _editNote(String noteid, String noteName, String noteDesc) {
    Navigator.push(
        context as BuildContext,
        MaterialPageRoute(
            builder: (context) => EditPage(
                  noteid: noteid,
                  noteName: noteName,
                  noteDesc: noteDesc,
                )));
  }
}
