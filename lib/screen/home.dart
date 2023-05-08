import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notexpert_mongo/screen/note_editor.dart';
import 'package:notexpert_mongo/screen/note_reader.dart';
import 'package:notexpert_mongo/style/app_style.dart';
import 'package:notexpert_mongo/widgets/note_card.dart';
import 'package:notexpert_mongo/auth/sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  User? user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whitePink,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("noteXpert"),
        centerTitle: true,
        backgroundColor: AppStyle.pink,
      ),
      drawer: Drawer(
        backgroundColor: AppStyle.pink,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
              children: [
                Text(user!.email.toString()),
                ElevatedButton(
                    onPressed: () {
                      try {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignIn()));
                      } catch (e) {}
                    },
                    child: Text("Sign Out"))
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteReaderScreen(note),
                                    ));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "There's no notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        label: Text("Addnote"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
