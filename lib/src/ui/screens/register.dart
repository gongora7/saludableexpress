import 'package:flutter/material.dart';
import 'package:flutter_app1/src/blocs/user/login_bloc.dart';
import 'package:flutter_app1/src/blocs/user/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 88, 56, 1),
          title: Text("Regístrate"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              colors: [
                Color.fromRGBO(255, 88, 56, 1),
                Color.fromRGBO(255, 88, 56, 1),
                Color.fromRGBO(31, 34, 40, 1),
              ],
            ),
            /* image: DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage("assets/images/bglogin.png"))*/
          ),
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
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            )
                          ],
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/logoeev.png")
                              /* image: new NetworkImage(
                              "https://store.saludableexpress.com/images/media/2021/06/thumbnail1622601274NjCig02302.png",
                            )*/
                              ))),
                  SizedBox(height: 16.0),
                  /*Text(
                "Crea tu cuenta",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
              ),*/
                  SizedBox(
                    height: 20.0,
                  ),
                  MyCustomForm(),
                ],
              ),
            ),
          ),
        ));
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

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isDialogShowing = false;

  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();

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
        /* padding: EdgeInsets.all(60.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.lightGreen.withOpacity(0.5),
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
                ])),*/
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(224, 49, 51, 1))),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                hintText: 'Nombre',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide: new BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter valid Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(224, 49, 51, 1))),
                prefixIcon: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                  child: Icon(Icons.people, color: Colors.white),
                ),
                hintText: 'Apellido',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide: new BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter valid Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(224, 49, 51, 1))),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.phone_iphone, color: Colors.white),
                ),
                hintText: 'Teléfono',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide: new BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter valid phone';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(224, 49, 51, 1))),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.mail, color: Colors.white),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide: new BorderSide(
                    color: Colors.white,
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
              style: TextStyle(color: Colors.white),
              autocorrect: false,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(224, 49, 51, 1))),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.security, color: Colors.white),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide: new BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              width: double.maxFinite,
              height: 60.0,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white60,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      loginBloc.add(ProcessRegistration(
                          _firstNameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _passwordController.text,
                          "92",
                          _phoneNumberController.text));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Regístrate",
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  )),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ya tienes una cuenta?",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Inicia Sesión",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
