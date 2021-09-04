import 'package:flutter/material.dart';
import 'package:flutter_app1/src/ui/screens/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void _EndIntroScreen(context) {
    Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => Home()));
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Container(
          margin: EdgeInsets.only(top: 250),
          child: Image.asset('assets/images/iconointro1.png', width: 300),
        ),
        title: "Tips para tus viajes",
        body: "Consulta el blog para conocer de tus próximos destinos",
        footer: Text(''),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(229, 227, 227, 1)),
          bodyTextStyle: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(229, 227, 227, 1)),
          pageColor: Color.fromRGBO(255, 88, 56, 1),
          bodyAlignment: Alignment.center,
          imageAlignment: Alignment.center,
        ),
      ),
      PageViewModel(
        image: Container(
            margin: EdgeInsets.only(top: 250),
            child: Image.asset('assets/images/iconointro2.png', width: 300)),
        title: "Dale vida a tus espacios",
        body: "Compra fotografías para decorar tu casa u oficina",
        footer: Text(''),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(229, 227, 227, 1)),
          bodyTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(229, 227, 227, 1)),
          pageColor: Color.fromRGBO(58, 58, 58, 1),
          bodyAlignment: Alignment.center,
          imageAlignment: Alignment.center,
        ),
      ),
      PageViewModel(
        image: Container(
          margin: EdgeInsets.only(top: 250),
          child: Image.asset('assets/images/iconointro3.png', width: 300),
        ),
        title: "Ocasiones Especiales",
        body: "Consigue regalos para familia y amigos en un solo lugar",
        footer: Text(''),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(229, 227, 227, 1)),
          bodyTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(229, 227, 227, 1)),
          pageColor: Color.fromRGBO(80, 135, 199, 1),
          bodyAlignment: Alignment.center,
          imageAlignment: Alignment.center,
        ),
      ),
      PageViewModel(
        image: Container(
          margin: EdgeInsets.only(top: 250.0),
          child: Image.asset(
            'assets/images/iconointro4.png',
            width: 300.0,
          ),
        ),
        title: "Paga con tarjeta o efectivo",
        body: "Diferentes métodos de pago para tu comodidad",
        footer: Text(''),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(229, 227, 227, 1)),
          bodyTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(229, 227, 227, 1)),
          pageColor: Color.fromRGBO(209, 57, 31, 1),
          bodyAlignment: Alignment.center,
          imageAlignment: Alignment.center,
        ),
      ),
      PageViewModel(
        image: Container(
          margin: EdgeInsets.only(top: 250.0),
          child: Image.asset('assets/images/iconointro5.png', width: 300.0),
        ),
        title: "Podcast de Viajes",
        body: "Entrevista con diferentes viajeros sobre sus experiencias",
        footer: Text(''),
        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins-Bold',
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(229, 227, 227, 1)),
          bodyTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(229, 227, 227, 1)),
          pageColor: Color.fromRGBO(40, 35, 34, 1),
          bodyAlignment: Alignment.center,
          imageAlignment: Alignment.center,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        controlsPadding: EdgeInsets.only(top: 15.0, bottom: 10.0),
        dotsDecorator: DotsDecorator(
            activeColor: Color.fromRGBO(241, 90, 36, 1),
            color: Colors.black38,
            size: Size.fromRadius(6.0),
            activeSize: Size.fromRadius(8.0)),
        showNextButton: true,
        showDoneButton: true,
        showSkipButton: true,
        next: Icon(
          Icons.arrow_forward_ios,
          size: 32.0,
          color: Color.fromRGBO(241, 90, 36, 1),
        ),
        skip: Text(
          'Saltar'.toUpperCase(),
          style: TextStyle(
              fontSize: 18.0,
              color: Color.fromRGBO(241, 90, 36, 1),
              fontWeight: FontWeight.bold),
        ),
        done: Icon(
          Icons.arrow_forward_ios,
          size: 30.0,
          color: Color.fromRGBO(241, 90, 36, 1),
        ),
        onDone: () {
          _EndIntroScreen(context);
        },
        onSkip: () {
          _EndIntroScreen(context);
        },
        pages: getPages(),
      ),
    );
  }
}
