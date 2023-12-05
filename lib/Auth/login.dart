// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_required_param, use_build_context_synchronously, prefer_final_fields, unnecessary_string_interpolations, avoid_print, unused_local_variable, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Specs/colors.dart';
import '../../Specs/password_field.dart';
import '../../Specs/text_field.dart';
import '../expenses.dart';
import 'register_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showPasswordMismatchSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showStudentIdNotFoundSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wrong Student ID'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showRegistrationSuccessfulSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login Successful'),
        backgroundColor: Colors.green,
      ),
    );
  }

  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 200),
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: BLACK),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: textFormField(
                        hintText: "Student ID",
                        borderWidth: 2,
                        validateMsg: "Field required",
                        borderRadius: 10,
                        controller: _studentIdController,
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                        ),
                        keyboardType: TextInputType.multiline,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ]),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    margin: EdgeInsets.all(10),
                    child: PasswordField(
                      hintText: "Password",
                      borderWidth: 2,
                      borderRadius: 10,
                      removeBorder: true,
                      validateMsg: "Field required",
                      controller: _passwordController,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgotten Password",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email:
                              "${_studentIdController.text.trim()}@atuexpT.com",
                          password: _passwordController.text,
                        );

                        // Login successful
                        _showRegistrationSuccessfulSnackbar();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Expenses()));

                        // Continue with other logic (e.g., storing user details)
                      } catch (e) {
                        // Login failed
                        if (e is FirebaseAuthException) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Wrong Student ID'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (e.code == 'wrong-password') {
                            _showPasswordMismatchSnackbar();
                          }
                        } else {
                          print(e.toString());
                        }
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                        color: DARKBLUE,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            fontSize: 24,
                            color: WHITE,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New to Crime Reporter? ",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          fontSize: 13,
                          color: BLACK,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          child: Text("Register"))
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
