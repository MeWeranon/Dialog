import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/auth_page.dart';
import 'package:onboarding_screen/component/my_button.dart';
import 'package:onboarding_screen/component/my_textbutton.dart';
import 'package:onboarding_screen/component/my_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signInUser() async {
    if (emailController.text != "" && passwordController.text != "") {
      print("It's ok");
      showAlertDialog(context,title:"0", content: "It's ok");
    } else {
      print('Please input your email and password.');
      showAlertDialog(context,title:"0", content: 'Please input your email and password.');
    }
  }

  signInWithEmailAndPassword() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    showAlertDialog(context,title:"", content: 'Login sucessfully');
  } on FirebaseAuthException catch (e) {
    print('Wrong password provided for that user.');
    print(e.message);
    showAlertDialog(context,title:"0", content: 'Wrong password provided for that user.');
    if (e.code == 'invalid-email') {
      print('No user found for that email.');
      showAlertDialog(context,title:"", content: 'No user found for that email.');
    } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      print('Wrong password provided for that user.');
      showAlertDialog(context,title:"0", content: 'Wrong password provided for that user.');
    }
  }
  }

  void showAlertDialog(BuildContext context, {required String title, required String content}) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        // Navigator.of(context).pop();
        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AuthPage()),
                ); // Close the dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Hello, ready to get started?",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please sign in with your email and password",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email',
                labelText: 'Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              const MyTextButton(
                labelText: 'Forgot password?',
                pageRoute: 'forgot',
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(onTap: signInWithEmailAndPassword, hintText: 'Sign in'),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Colors.red),
                    ),
                    const MyTextButton(
                      labelText: 'Register now',
                      pageRoute: 'register',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Icon (using SVG)
                  GestureDetector(
                    onTap: () {
                      // Handle Google Sign In
                      print('Google Sign In');
                    },
                    child: SvgPicture.asset(
                      'assets/google_icon.svg', // Replace with your Google icon asset
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // Facebook Icon (using SVG)
                  GestureDetector(
                    onTap: () {
                      // Handle Facebook Sign In
                      print('Facebook Sign In');
                    },
                    child: SvgPicture.asset(
                      'assets/facebook_icon.svg', // Replace with your Facebook icon asset
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}