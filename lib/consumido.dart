import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Consumido extends StatefulWidget {
  const Consumido({Key? key}) : super(key: key);

  @override
  State<Consumido> createState() => _ConsumidoState();
}

class _ConsumidoState extends State<Consumido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
          Navigator.of(ContextHolder.currentContext).pop();
        }),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          "Instant Heat",
          style: GoogleFonts.lato(
              color: const Color(
                0xFFFF6A17,
              ),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset(
                "images/stats.png",
                height: 80,
              ),
              SizedBox(height: 20,),
              Text("Resumen", style: GoogleFonts.lato(color: Color(0xFFFF6A17,), fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              Text("Esta semana consumiste 8 litros de café", style: GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Consumiste 32 tazas de café 😱", style: GoogleFonts.lato(fontSize: 15),),
              Text("El día que más consumiste café fue el lunes", style: GoogleFonts.lato(fontSize: 15),),
              SizedBox(height: 40,),
              Text("Tardas 1.5 horas en terminarte una taza de café", style: GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              SizedBox(width: 300,child: Text("En promedio te toma 1.5 horas para terminar una taza de café.", style: GoogleFonts.lato(fontSize: 15),),),
              SizedBox(width: 300,child: Text(" El día que bebiste café más rápido fue el lunes con 10 minutos.", style: GoogleFonts.lato(fontSize: 15),),),
              
              

          ],
        ),
      ),
    );
  }
}
