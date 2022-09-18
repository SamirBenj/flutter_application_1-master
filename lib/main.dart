import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  //Initialisation de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List todos = List.empty();
  // String title = "";
  // String description = "";
  @override
  void initState() {
    super.initState();
    // todos = ["hello", "hey There"];
  }

  TextEditingController usernameController = TextEditingController();
  // createToDo() {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("MyTodos").doc(title);

  //   Map<String, String> todoList = {
  //     "todoTitle": title,
  //     "todoDesc": description
  //   };

  //   documentReference
  //       .set(todoList)
  //       .whenComplete(() => print("Data stored sucessfully"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Nom Utilisateurs',
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: usernameController,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("MyCollection")
                    .snapshots(),
                builder: (context, snapshot) => ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(snapshot.data!.docs[index]["Age"]);
                    var age = snapshot.data!.docs[index]["Age"];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Text("Age: " + age),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection("MyCollection").doc().set(
            {
              "Age": "SALUT !!",
            },
          );
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         title: const Text("Add Todo"),
          //         content: Container(
          //           width: 400,
          //           height: 100,
          //           child: Column(
          //             children: [
          //               TextField(
          //                 onChanged: (String value) {
          //                   title = value;
          //                 },
          //               ),
          //               TextField(
          //                 onChanged: (String value) {
          //                   description = value;
          //                 },
          //               )
          //             ],
          //           ),
          //         ),
          //         actions: <Widget>[
          //           TextButton(
          //               onPressed: () {
          //                 setState(() {
          //                   createToDo();
          //                 });
          //                 Navigator.of(context).pop();
          //               },
          //               child: const Text("Add"))
          //         ],
          //       );
          //     });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
