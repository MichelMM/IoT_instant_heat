import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant_heat/selected_device.dart';
import 'package:context_holder/context_holder.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: ContextHolder.key,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  // ignore: use_key_in_widget_constructors
  const DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {


  final _controller = PageController();

  static const _kDuration = Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    // ignore: unnecessary_new
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Column(

        children: [
          Image.asset("images/coffe1.png",height: 420,),
          const SizedBox(height: 20,),
          Text("Sabor",style: GoogleFonts.lato(fontSize: 40,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Text("Elige la temperatura de tu café o té",style: GoogleFonts.lato(fontSize: 22,),),
        ],
      ),
    ),
    ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Column(

        children: [
          Image.asset("images/coffe2.png"),
          const SizedBox(height: 20,),
          Text("Temperatura",style: GoogleFonts.lato(fontSize: 40,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Text("Ajusta la temperatura y descubre cómo algunos grados de diferencia pueden hacer que cambie el sabor",style: GoogleFonts.lato(fontSize: 22,),textAlign: TextAlign.center,),
          ),
        ],
      ),
    ),ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Column(

        children: [
          Image.asset("images/coffe3.png", height: 370),
          const SizedBox(height: 20,),
          Text("Tiempo",style: GoogleFonts.lato(fontSize: 40,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Text("Tómate tu tiempo para disfrutar de una bebida caliente perfecta desde el primer sorbo evitar que te prepares una nueva taza de café",style: GoogleFonts.lato(fontSize: 22,),textAlign: TextAlign.center,),
          ),
          const SizedBox(height: 20,),
          OutlinedButton(
            onPressed: (){
              Navigator.of(ContextHolder.currentContext).push(MaterialPageRoute(builder: (_) => const SelectedDevice()));
            },
            child: const Text("¡Empecemos!",style: TextStyle(color: Colors.white)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFF6A17)),
              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(100, 20, 100, 20)),
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SelectedDevice();
    return Scaffold(
      body: IconTheme(
        data: IconThemeData(color: _kArrowColor),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.grey[800]!.withOpacity(0.1),
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}