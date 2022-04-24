import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant_heat/home.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MaxTemp extends StatefulWidget {
  const MaxTemp({Key? key}) : super(key: key);

  @override
  State<MaxTemp> createState() => _MaxTempState();
}

class _MaxTempState extends State<MaxTemp> {

  double _value = 55.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Instant Heat",style: GoogleFonts.lato(color: const Color(0xFFFF6A17,), fontSize: 40, fontWeight: FontWeight.bold),),
              const SizedBox(height: 40,),
              SizedBox(child: Text("Selecciona la temperatura máxima de tu bebida",style: GoogleFonts.lato(fontSize: 32,color: const Color(0xFF47525E),fontWeight: FontWeight.w300),textAlign: TextAlign.center,),width: 300,),
              const SizedBox(height:80,),
              Text("${_value.round()}°C",style: GoogleFonts.lato(color: const Color(0xFFFF6A17,), fontSize: 50, fontWeight: FontWeight.bold),),
              const SizedBox(height:80,),
              SizedBox(
                width: 300,
                child: SfSlider(
              min: 30.0,
              max: 100.0,
              value: _value,
              activeColor: const Color(0xFF8390A4),
              inactiveColor: const Color(0xFFE6E9F2),
              minorTicksPerInterval: 1,
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
              },
            ),
              ),
              const SizedBox(height: 50,),
              OutlinedButton(
            onPressed: (){
              Navigator.of(ContextHolder.currentContext).push(MaterialPageRoute(builder: (_) => const Home()));
            },
            child: Text("Siguiente",style: GoogleFonts.lato(fontSize: 25,color: Colors.white)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFF6A17)),
              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(100, 20, 100, 20)),
            ),
          ),
            ],
          ),
      ),
    );
  }
}
