import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gsc2024/services/authFunctions.dart';
import 'package:gsc2024/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// enum userType { user, organization }

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String fullname = '';
  bool login = true;
  // userType? type = userType.user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white,
                Color.fromARGB(255, 151, 196, 184),
                Color.fromARGB(240, 151, 196, 184),
                Color.fromARGB(220, 151, 196, 184),
                // Color.fromARGB(200, 151, 196, 184),
                // Color.fromARGB(160, 151, 196, 184),
              ],
            ),
          ),
          //color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image.asset(
                  //
                  //   'images/birds.png',
                  // ),
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    'images/R.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ======== User Type ========
                          // Row(
                          //   children: [
                          //     login
                          //         ? Container()
                          //         : Row(
                          //             key: ValueKey('user'),
                          //             children: [
                          //               Text('User'),
                          //               Radio<userType>(
                          //                 value: userType.user,
                          //                 groupValue: type,
                          //                 onChanged: (userType? value) {
                          //                   setState(() {
                          //                     type = value;
                          //                   });
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          //     SizedBox(width: 5),
                          //     login
                          //         ? Container()
                          //         : Row(
                          //             key: ValueKey('organization'),
                          //             children: [
                          //               Text('Organization'),
                          //               Radio<userType>(
                          //                 value: userType.organization,
                          //                 groupValue: type,
                          //                 onChanged: (userType? value) {
                          //                   setState(() {
                          //                     type = value;
                          //                   });
                          //                 },
                          //               ),
                          //             ],
                          //           ),
                          // ],
                          // ),
                          // ======== Full Name ========
                          login
                              ? Container()
                              : TextFormField(
                                  key: ValueKey('fullname'),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Full Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Full Name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      fullname = value!;
                                    });
                                  },
                                ),

                          // ======== Email ========
                          TextFormField(
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please Enter valid Email';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                email = value!;
                              });
                            },
                          ),
                          // ======== Password ========
                          TextFormField(
                            key: ValueKey('password'),
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                            ),
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Please Enter Password of min length 6';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                password = value!;
                              });
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            color: Colors.teal,
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Color.fromARGB(255, 198, 218, 198);
                                    } else
                                      return Color.fromARGB(255, 8, 43, 40);
                                  }),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    if (login) {
                                      bool loggedin =
                                          await AuthServices.signinUser(
                                              email, password, context);
                                      if (loggedin)
                                        Navigator.pushNamed(
                                            context, 'homepage');
                                    } else {
                                      // type == userType.user
                                      //     ?
                                      AuthServices.signupUser(
                                          email, password, fullname, context);
                                      // : AuthServices.signupOrganization(
                                      //     email,
                                      //     password,
                                      //     fullname,
                                      //     context);
                                      login = !login;
                                    }
                                  }
                                },
                                child: Text(login ? 'Login' : 'Signup')),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                login = !login;
                              });
                            },
                            // child: Text(login
                            //     ? "Don't have an account? Signup"
                            //     : "Already have an account? Login")
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    login
                                        ? "Don't have an account? "
                                        : "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Inria',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white70,
                                    )),
                                Text(login ? "Signup " : "Login ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Inria',
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blueGrey,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'images/earthf.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
