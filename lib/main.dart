import 'package:flutter/material.dart';
import 'package:instant_heat/splash2.dart';
import 'package:dots_indicator/dots_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instant Heat',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: (context, state) {
        return const MyHomePage(title: 'Hola',);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentPosition = 0.0;
  final _totalDots = 3;


  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          children: const <Widget>[
            Walkthrougth(textContent: "Walkthrough one"),
            Walkthrougth(textContent: "Walkthrough two"),
            Walkthrougth(textContent: "Walkthrough tree"),
          ],
          onPageChanged: (double position) {setState(() => _currentPosition = _validPosition(position));} ,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.7,
          // left: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.38),
            child: Align(
                alignment: Alignment.centerRight,
                child: DotsIndicator(
                  dotsCount: _totalDots,
                  position: _currentPosition,
                  decorator: const DotsDecorator(
                      color: Colors.grey,
                      activeColor: Color.fromARGB(255, 80, 80, 80)),
                )),
          ),
        )
      ],
    ));
  }
}

class Walkthrougth extends StatelessWidget {
  final String textContent;
  const Walkthrougth({Key? key, required this.textContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.redAccent),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(child: Text(textContent)),
    );
  }
}
