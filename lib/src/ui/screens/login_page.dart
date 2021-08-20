import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/blocs/user/login_bloc.dart';
import 'package:flutter_app1/src/blocs/user/login_event.dart';
import 'package:flutter_app1/src/blocs/user/login_state.dart';
import 'package:flutter_app1/src/models/drawer_menu_item.dart';
import 'package:flutter_app1/src/services/apple_signin_service.dart';
import 'package:flutter_app1/src/ui/screens/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: [
                new Container(
                    width: 130.0,
                    height: 130.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                              "https://store.saludableexpress.com/images/media/2021/06/thumbnail1622601274NjCig02302.png",
                            )))),
                SizedBox(height: 16.0),
                /* Text(
                  "Bienvenido a tu vida saludable",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),*/
                SizedBox(
                  height: 16.0,
                ),
                MyCustomForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc loginBloc;
  bool _isDialogShowing = false;

  Box _userBox;

  final fb = FacebookLogin();

  @override
  void initState() {
    super.initState();
    _userBox = Hive.box("my_userBox");

    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(60.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(20, 137, 54, 1).withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, 0),
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromRGBO(102, 174, 39, 0.2),
                const Color.fromRGBO(178, 239, 120, 0.4),
                const Color.fromRGBO(24, 167, 120, 0.7)
              ],
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.email),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black45),
                fillColor: Colors.black87,
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(2.0),
                  borderSide: new BorderSide(
                    color: Colors.black45,
                  ),
                ),
              ),
              validator: (value) {
                if (!isEmail(value)) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.security),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black45),
                fillColor: Colors.black87,
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(2.0),
                  borderSide: new BorderSide(color: Colors.black45),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  buildForgotPasswordDialog(context, loginBloc);
                },
                child: Text(
                  "¿Olvidaste tu Password?",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ),
            BlocConsumer<LoginBloc, LoginState>(
              builder: (context, state) {
                return Container(
                  width: double.maxFinite,
                  height: 40.0,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0)),
                      color: Colors.white60,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          loginBloc.add(ProcessLogin(
                              _emailController.text, _passwordController.text));
                        }
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.w700),
                      )),
                );
              },
              listener: (context, state) {
                if (state is LoginInitial) {
                } else if (state is LoginLoading) {
                  showLoaderDialog(context);
                } else if (state is LoginLoaded) {
                  AppData.user = state.user;
                  AppData.data.removeLast();
                  AppData.data.add(DrawerMenuItem(
                      (AppData.user != null) ? "Logout" : "Login",
                      Icons.login));
                  _userBox.put("current_user", state.user);
                  if (_isDialogShowing) {
                    Navigator.pop(context);
                    _isDialogShowing = false;
                  }
                  Navigator.pop(context);
                } else if (state is LoginError) {
                  if (_isDialogShowing) {
                    Navigator.pop(context);
                    _isDialogShowing = false;
                  }
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                } else if (state is ForgotPasswordLoading) {
                  showLoaderDialog(context);
                } else if (state is ForgotPasswordLoaded) {
                  Navigator.pop(context);
                  _isDialogShowing = false;
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(state.forgotPasswordResponse.message)));
                } else if (state is ForgotPasswordError) {
                  if (_isDialogShowing) {
                    Navigator.pop(context);
                    _isDialogShowing = false;
                  }
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: 1,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          color: Colors.black45,
                        )))),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "o también:",
                      style: TextStyle(color: Colors.black45),
                    )),
                Expanded(
                    child: SizedBox(
                        height: 1,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          color: Colors.black45,
                        )))),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* IconButton(
                  icon: Image.asset(
                    "assets/images/login_with_google.png",
                    fit: BoxFit.fill,
                  ),
                  onPressed: () {
                    doGoogleLogin();
                  },
                ),
                SizedBox(
                  width: 8.0,
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/images/login_with_fb.png",
                    fit: BoxFit.fill,
                  ),
                  onPressed: () {
                    signInFB();
                  },
                ),
                SizedBox(
                  width: 8.0,
                ),*/
                /* IconButton(
                  icon: Image.asset(
                    "assets/images/login_with_phone.png",
                    fit: BoxFit.fill,
                  ),
                  onPressed: () {},
                ), */
              ],
            ),
            /* SignInWithAppleButton(
              text: 'Apple ID',
              onPressed: AppleSignInService.signIn,
              
            ),*/
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No tienes una cuenta?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    "Regístrate",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildForgotPasswordDialog(BuildContext context, LoginBloc loginBloc) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final _emailForgotController = TextEditingController();

          return Dialog(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¿Olvidaste tu Password?",
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 0,
                      ),
                    ),
                    TextFormField(
                      controller: _emailForgotController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        fillColor: Colors.black87,
                        contentPadding: EdgeInsets.all(8.0),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(16.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (!isEmail(value)) {
                          return 'Ingresa un Email Valido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.maxFinite,
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          color: Colors.black87,
                          height: 40.0,
                          onPressed: () {
                            if (_emailForgotController.value
                                .toString()
                                .isNotEmpty) {
                              loginBloc.add(ProcessForgotPassword(
                                  _emailForgotController.text));
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Enviar",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Cargando...")),
        ],
      ),
    );
    _isDialogShowing = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void doGoogleLogin() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    signInWithGoogle(_googleSignIn, _auth);
  }

  Future<User> signInWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth) async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);

    var _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    //model.state =ViewState.Idle;
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");

    loginBloc.add(ProcessLoginWithGmail(
        googleSignInAuthentication.idToken,
        googleSignInAccount.id,
        _user.displayName,
        _user.displayName,
        googleSignInAccount.email,
        googleSignInAccount.photoUrl.toString() != null
            ? googleSignInAccount.photoUrl.toString()
            : ""));
  }

  void signInFB() async {
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');

        loginBloc.add(ProcessLoginWithFacebook(accessToken.token));

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }
}
