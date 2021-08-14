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
        image: Image.asset(''),
        title: "Prueba de Intro Page",
        body: "Esta es la prueba del Intro Page",
        footer: Text('Texto del footer'),
        decoration: const PageDecoration(
          pageColor: Colors.orangeAccent,
        ),
      ),
      PageViewModel(
        image: Image.asset(''),
        title: "Prueba de Intro Page",
        body: "Esta es la prueba del Intro Page",
        footer: Text('Texto del footer'),
        decoration: const PageDecoration(pageColor: Colors.blueAccent),
      ),
      PageViewModel(
        image: Image.asset(''),
        title: "Prueba de Intro Page",
        body: "Esta es la prueba del Intro Page",
        footer: Text('Texto del footer'),
        decoration: const PageDecoration(pageColor: Colors.greenAccent),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showNextButton: true,
        showDoneButton: true,
        showSkipButton: true,
        next: Text('Siguiente'),
        skip: Text('Saltar'),
        done: Text('Finalizar'),
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
