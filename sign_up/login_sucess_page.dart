import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/component/stream_note.dart';
import 'package:onboarding_screen/main.dart';
import 'package:onboarding_screen/todolist/add_note_screen.dart';
import 'package:onboarding_screen/todolist/todolist.dart';

class LoginSuccessPage extends StatefulWidget {
  LoginSuccessPage({Key? key}) : super(key: key);

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  bool show = true;

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 1, 70, 126),
        centerTitle: true,
        title: Text(
          'Task management',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline6!,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is UserScrollNotification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  show = true;
                });
              } else if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  show = false;
                });
              }
            }
            return true;
          },
          child: Column(
            children: [
              StreamNote(false),
              Text(
                'isDone',
                style: TextStyle(color: Color.fromARGB(255, 63, 3, 117)),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
        },
        backgroundColor: Color.fromARGB(255, 40, 1, 103),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
