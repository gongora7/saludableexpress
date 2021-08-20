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
          'assets/images/intro-img1.png',
        ),
        title: "Encuentra tus productos",
        body: "Una gran variedad de productos saludables para tí",
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
        image: Image.asset('assets/images/intro-img2.png'),
        title: "Pagos Seguros",
        body: "Pagar con cualquier tarjeta, o en transferencia",
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
          'assets/images/intro-img3.png',
        ),
        title: "Recibe tu pedido",
        body: "Disfruta de comprar en línea y mantente saludable",
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
