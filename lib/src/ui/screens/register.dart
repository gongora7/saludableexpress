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
        title: Text("Regístrate"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              new Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                            "https://store.saludableexpress.com/images/media/2021/06/thumbnail1622601274NjCig02302.png",
                          )))),
              SizedBox(height: 16.0),
              /*Text(
                "Crea tu cuenta",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
              ),*/
              SizedBox(
                height: 16.0,
              ),
              MyCustomForm(),
            ],
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
  bool isChecked = false;
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
        padding: EdgeInsets.all(60.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(20, 137, 54, 0.5).withOpacity(0.5),
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
                ])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.person),
                ),
                hintText: 'Nombre',
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
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.people),
                ),
                hintText: 'Apellido',
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.phone_iphone),
                ),
                hintText: 'Teléfono',
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
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.mail),
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
                  borderSide: new BorderSide(
                    color: Colors.black45,
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
            (
                /* Inicia Checkbox */
                Container(
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                        title: Text(
                            'Acepto que Saludable Express guarde mis datos para compras en la app'),
                        value: this.isChecked,
                        onChanged: (bool isChecked) {
                          print(this.isChecked);
                          setState(() {
                            this.isChecked = true;
                            print('La variable cambió');
                            print(this.isChecked);
                          });
                        }),
                  ),
                ],
              ),
            )),

/* Finaliza Checkbox */

            Container(
              width: double.maxFinite,
              height: 40.0,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                  color: Colors.white60,
                  onPressed: () {
                    if (_formKey.currentState.validate() &&
                        this.isChecked == true) {
                      loginBloc.add(ProcessRegistration(
                          _firstNameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _passwordController.text,
                          "92",
                          _phoneNumberController.text));
                      Navigator.pop(context);
                    } else {
                      print('No se puede acceder');
                    }
                  },
                  child: Text(
                    "Regístrate",
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ya tienes una cuenta?"),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Inicia Sesión",
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
