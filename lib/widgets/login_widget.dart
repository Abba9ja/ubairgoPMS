import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ubairgo/screens/landing.dart';

import '../model/user_model.dart';
import '../screens/splash.dart';
import '../styles/colors.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  bool password_visible = true;

  String id_error_str = '';

  bool show_id_error = false;

  bool show_password_error = false;

  String password_error_str = '';

  String error_str = '';
  bool show_error = false;

  bool is_siging_in = false;
  bool isrequesting = false;
  bool show_fp = false;
  bool reset_succesfully = false;
  Widget emailErrorWidget(double width, double height) {
    return SizedBox(
      width: width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.pink.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.pink.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        id_error_str,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    clearIdError();
                  },
                  icon: Icon(Icons.close, color: Colors.white, size: 15))
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordErrorWidget(double width, double height) {
    return SizedBox(
      width: width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.pink.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.pink.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        password_error_str,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    clearPasswordError();
                  },
                  icon: Icon(Icons.close, color: Colors.white, size: 15))
            ],
          ),
        ),
      ),
    );
  }

  void setEmailError(String s) {
    setState(() {
      is_siging_in = false;
      show_id_error = true;
      id_error_str = s;
    });
  }

  void setPasswordError(String s) {
    setState(() {
      is_siging_in = false;
      show_password_error = true;
      password_error_str = s;
    });
  }

  bool user_exist = false;

  void detailsContinue(String value) async {
    DocumentSnapshot checkUserQuery =
        await FirebaseFirestore.instance.collection('USERS').doc(value).get();
    if (!checkUserQuery.exists) {
      setState(() {
        user_exist = false;
      });
    } else {
      setState(() {
        user_exist = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: !show_fp
          ? Column(
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          cursorColor: sys_green,
                          keyboardType: TextInputType.emailAddress,
                          controller: email_controller,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Address required';
                            }
                            if (value != null &&
                                value.isNotEmpty &&
                                !value.toString().contains(
                                      RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                                    )) {
                              return 'Invalid Email Address';
                            }
                            if (!user_exist) {
                              return 'Email address does\'nt exist';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            detailsContinue(value);
                          },
                          onSaved: (value) {
                            detailsContinue(value!);
                          },
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          decoration: InputDecoration(
                            focusColor: sys_green,
                            prefixIconColor: sys_green,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: sys_green,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'Email Address',
                            hintText: '',
                          ),
                        ),
                      ),
                      show_id_error
                          ? emailErrorWidget(width, height)
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: password_controller,
                          maxLines: 1,
                          obscureText: password_visible,
                          decoration: InputDecoration(
                            focusColor: sys_green,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: sys_green,
                            ),
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (password_visible) {
                                      password_visible = false;
                                    } else {
                                      password_visible = true;
                                    }
                                  });
                                },
                                icon: (password_visible == false)
                                    ? Icon(
                                        Icons.visibility,
                                        size: 15,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        size: 15,
                                      )),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: '********',
                          ),
                        ),
                      ),
                      show_password_error
                          ? passwordErrorWidget(width, height)
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  show_fp = true;
                                });
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(fontSize: 13),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      show_error
                          ? Column(
                              children: [
                                errorWidget(width, height),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : SizedBox(),
                      !is_siging_in
                          ? Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: sys_green,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                      blurRadius: 0),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    checkAndSignIn();
                                  }
                                },
                                child: Center(
                                    child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                )),
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: sys_green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(
                                  color: white,
                                ),
                              )),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'By signing in, I agree to the Ubairgo\'s Privacy Statement and Terms of Service.',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      color: Colors.grey.shade50,
                      child: TextButton(
                          onPressed: () {},
                          child: Text('Skip',
                              style: TextStyle(
                                fontSize: 13,
                              ))),
                    )
                  ],
                )
              ],
            )
          : Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: sys_green,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            show_fp = false;
                          });
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Reset password',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 25,
                ),
                !reset_succesfully
                    ? Form(
                        key: _formKey2,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Don\'t worry. Resetting your password is easy, just tell us the email address you registered with Ubairgo.',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextFormField(
                                cursorColor: sys_green,
                                keyboardType: TextInputType.emailAddress,
                                controller: email_controller,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email Address required';
                                  }
                                  if (
                                      value.isNotEmpty &&
                                      !value.toString().contains(
                                            RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                                          )) {
                                    return 'Invalid Email Address';
                                  }
                                  if (!user_exist) {
                                    return 'Email address does\'nt exist';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  detailsContinue(value);
                                },
                                onSaved: (value) {
                                  detailsContinue(value!);
                                },
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  focusColor: sys_green,
                                  prefixIconColor: sys_green,
                                  prefixIcon: Icon(
                                    Icons.house_outlined,
                                    color: sys_green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: 'Email Address',
                                  hintText: '',
                                ),
                              ),
                            ),
                            show_id_error
                                ? emailErrorWidget(width, height)
                                : SizedBox(),
                            SizedBox(
                              height: 25,
                            ),
                            !isrequesting
                                ? Container(
                                    width: width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: sys_green,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 0),
                                            blurRadius: 0),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey2.currentState!
                                            .validate()) {
                                          resetPassword();
                                        }
                                      },
                                      child: Center(
                                          child: Text(
                                        'Send',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: white),
                                      )),
                                    ),
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: sys_green,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                        color: white,
                                      ),
                                    )),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Column(
                            children: [
                              Text(
                                'We sent a reset password email to muhammad.shehu.bello1@gmail.com. Please click the reset password link to set your new password.\n\nHaven\'t you receive the email yet?.',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Please check your spam folder, or',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  reset_succesfully = false;
                                });
                              },
                              child: Text('Try again')),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: sys_green,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 0),
                                    blurRadius: 0),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  show_fp = false;
                                });
                              },
                              child: Center(
                                  child: Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
    );
  }

  void clearIdError() {
    setState(() {
      show_id_error = false;
      id_error_str = '';
    });
  }

  void clearPasswordError() {
    setState(() {
      show_password_error = false;
      password_error_str = '';
    });
  }

  void checkAndSignIn() async {
    setState(() {
      is_siging_in = true;
    });
    DocumentSnapshot checkUserQuery = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(email_controller.text.toString())
        .get();
    if (checkUserQuery.exists) {
      UserF user = UserF.fromDocument(checkUserQuery);

      if (user.user_status == 'suspended') {
        setError('Account suspended, Contact support ⬆️');
      } else {
        if (user.user_status == 'in_active') {
          signUp(user);
        } else {
          signIn(user);
        }
      }
    } else {
      setState(() {
        is_siging_in = false;
      });
    }
  }

  void signUp(UserF user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email_controller.text, password: password_controller.text);
      if (userCredential.user != null) {
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(email_controller.text)
            .update({
          'id': userCredential.user!.uid,
          'user_status': 'active',
          'date_signin': DateTime.now()
        }).then((value) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SplashScreen(),
              ));
        });
        FirebaseFirestore.instance
            .collection('USERS')
            .doc(currentUser!.email_address)
            .collection('ONLINE STATUS')
            .doc('status')
            .set({
          'online_status': true,
          'online_time': DateTime.now(),
        });
      } else {
        setError('Something went wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setPasswordError('The password provided is too weak');
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setPasswordError('The account already exists for that email.');
        //print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void signIn(UserF user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email_controller.text, password: password_controller.text);
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SplashScreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setEmailError('Email address does\'nt exist');
      } else if (e.code == 'wrong-password') {
        setPasswordError("Wrong password");
      }
    }
  }

  void setError(String s) {
    setState(() {
      is_siging_in = false;
      show_error = true;
      error_str = s;
    });
  }

  void hideError() {
    setState(() {
      show_error = false;
      error_str = '';
    });
  }

  Widget errorWidget(double width, double height) {
    return SizedBox(
      width: width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.pink.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.pink.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        password_error_str,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  hideError();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    setState(() {
      isrequesting = true;
    });
    DocumentSnapshot checkUserQuery = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(email_controller.text)
        .get();
    if (checkUserQuery.exists) {
      UserF user = UserF.fromDocument(checkUserQuery);
      if (user.status == 'suspended') {
        setEmailError('Account suspended, Contact support ⬆️');
      } else {
        if (user.status == 'active') {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: email_controller.text)
              .then((value) => {
                    setState(() {
                      reset_succesfully = true;
                      isrequesting = false;
                    })
                  });
        } else {
          setEmailError('Hello!, Sign in first ');
          setState(() {
            isrequesting = false;
          });
        }
      }
    } else {
      setEmailError('User account not found ');
      setState(() {
        isrequesting = false;
      });
    }
  }
}
