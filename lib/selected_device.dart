import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant_heat/search_device.dart';
class SelectedDevice extends StatefulWidget {
  const SelectedDevice({ Key? key }) : super(key: key);

  @override
  State<SelectedDevice> createState() => _SelectedDeviceState();
}

class _SelectedDeviceState extends State<SelectedDevice> {
  
  @override
  Widget build(BuildContext context) {
    TextEditingController _tazaId = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              Text("Instant Heat",style: GoogleFonts.lato(color: const Color(0xFFFF6A17,), fontSize: 40, fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              SizedBox(child: Text("Seleccione su Dispositivo", style: GoogleFonts.lato(fontSize: 25),textAlign: TextAlign.center), height: 80, width: 240,),
              Image.asset('images/ideal.png',alignment: Alignment.center,width: 300,),
              SizedBox(child: Text("Taza Instant Heat", style: GoogleFonts.lato(fontSize: 20),textAlign: TextAlign.center), height: 80, width: 240,),
              SizedBox(width: 300,
              child: TextField(
                controller: _tazaId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese ID de su taza',
                ),
              ),),
              const SizedBox(height:40),
              OutlinedButton(
              onPressed: () async{
                print(_tazaId.text);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchDevice(id: _tazaId.text)));
                
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
      )
    );
  }
}