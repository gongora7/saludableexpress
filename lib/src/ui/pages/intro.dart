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
        image: Image.asset(
          'assets/images/iconointro1.png',
        ),
        title: "Tips para tus viajes",
        body: "Consulta el blog para conocer de tus próximos destinos",
        footer: Text(''),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(229,227,227,1)),
            bodyTextStyle:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            pageColor: Color.fromRGBO(255, 88, 56, 1),
            bodyAlignment: Alignment.center,
            imageAlignment: Alignment.center,
            imagePadding: EdgeInsets.only(top: 50.0, left: 40.0)),
      ),
      PageViewModel(
        image: Image.asset('assets/images/iconointro2.png'),
        title: "Dale vida a tus espacios",
        body: "Compra fotografías para decorar tu casa u oficina",
        footer: Text(''),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(229,227,227,1)),
            bodyTextStyle:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            pageColor: Color.fromRGBO(58, 58, 58, 1),
            bodyAlignment: Alignment.center,
            imageAlignment: Alignment.center,
            imagePadding: EdgeInsets.only(top: 50.0, left: 40.0)),
      ),
      PageViewModel(
        image: Image.asset(
          'assets/images/iconointro3.png',
        ),
        title: "Ocasiones Especiales",
        body: "Consigue regalos para familia y amigos en un solo lugar",
        footer: Text(''),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(241, 90, 36, 1)),
            bodyTextStyle:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            pageColor: Color.fromRGBO(246, 246, 248, 1),
            bodyAlignment: Alignment.center,
            imageAlignment: Alignment.center,
            imagePadding: EdgeInsets.only(top: 50.0, left: 40.0)),
      ),
      PageViewModel(
        image: Image.asset(
          'assets/images/iconointro4.png',
        ),
        title: "Paga con tarjeta o efectivo",
        body: "Diferentes métodos de pago para tu comodidad",
        footer: Text(''),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(241, 90, 36, 1)),
            bodyTextStyle:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            pageColor: Color.fromRGBO(209, 57, 31, 1),
            bodyAlignment: Alignment.center,
            imageAlignment: Alignment.center,
            imagePadding: EdgeInsets.only(top: 50.0, left: 40.0)),
      ),
      PageViewModel(
        image: Image.asset(
          'assets/images/iconointro5.png',
        ),
        title: "Podcast de Viajes",
        body: "Entrevista con diferentes viajeros sobre sus experiencias",
        footer: Text(''),
        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(241, 90, 36, 1)),
            bodyTextStyle:
                TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            pageColor: Color.fromRGBO(40, 35, 34, 1),
            bodyAlignment: Alignment.center,
            imageAlignment: Alignment.center,
            imagePadding: EdgeInsets.only(top: 50.0, left: 40.0)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        dotsDecorator: DotsDecorator(
            activeColor: Color.fromRGBO(241, 90, 36, 1),
            color: Colors.black38,
            size: Size.fromRadius(4.0),
            activeSize: Size.fromRadius(7.0)),
        showNextButton: true,
        showDoneButton: true,
        showSkipButton: true,
        next: Icon(
          Icons.arrow_forward_rounded,
          size: 40.0,
          color: Color.fromRGBO(241, 90, 36, 1),
        ),
        skip: Text(
          'Saltar',
          style: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(241, 90, 36, 1),
              fontWeight: FontWeight.bold),
        ),
        done: Icon(
          Icons.check_circle,
          size: 40.0,
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
