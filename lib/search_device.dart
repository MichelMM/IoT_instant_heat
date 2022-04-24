import 'dart:async';

import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant_heat/min_temp.dart';

class SearchDevice extends StatefulWidget {
  const SearchDevice({ Key? key }) : super(key: key);

  @override
  State<SearchDevice> createState() => _SearchDeviceState();
}

class _SearchDeviceState extends State<SearchDevice> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Instant Heat",style: GoogleFonts.lato(color: const Color(0xFFFF6A17,), fontSize: 40, fontWeight: FontWeight.bold),),
            const SizedBox(height: 100,),
            Image.asset('images/connection.png',alignment: Alignment.center,width: 200,color: const Color(0xFFFF6A17,),),
            const SizedBox(height: 50,),
            Text("Buscando...",style: GoogleFonts.lato(fontSize: 30),),
            const SizedBox(height: 30,),
            SizedBox(child: Text("Asegúrese de que su taza esté encendida y su dispositivo móvil esté conectado a la red WiFi",style: GoogleFonts.lato(fontSize: 20), textAlign: TextAlign.center), width: 300,)
          ],
          ),
      )
    );
  }
}

startTime() async {
  var duration = const Duration(seconds: 3);
  return Timer(duration,()=>Navigator.of(ContextHolder.currentContext).push(MaterialPageRoute(builder: (_) => const MinTemp())));
}

changeScreen() async{
  
  
}