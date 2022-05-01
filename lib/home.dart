import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      backgroundColor: Colors.white54,
      body: Center(
        child: Column(children: [
          OutlinedButton(
            onPressed: () {
              authToken();
            },
            child: Text("Siguiente",
                style: GoogleFonts.lato(fontSize: 25, color: Colors.white)),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFFF6A17)),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.fromLTRB(100, 20, 100, 20)),
            ),
          ),
        ]),
      ),
    );
  }
}

authToken() async {
  var token = 'BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB';  
  var distancia ="https://industrial.api.ubidots.com/api/v1.6/variables/626b848b1d84726028f78770/values?token=" +token;
  var temperature_set ="https://industrial.api.ubidots.com/api/v1.6/variables/626b7810e39bed000ae569cd/values?token="+token;
  var relay = "https://industrial.api.ubidots.com/api/v1.6/variables/626b7381c7b02f000b0f0980/values?token="+token;
  var temperatura ="https://industrial.api.ubidots.com/api/v1.6/variables/626b6f241d84723e4fb71d5e/values?token="+token;
  var lista = [];
  lista.add(distancia);
  lista.add(temperature_set);
  lista.add(relay);
  lista.add(temperatura);
  var oldDate = new DateTime.fromMicrosecondsSinceEpoch(0);
  var nowDate = new DateTime.now().millisecondsSinceEpoch;

  lista.forEach((element) async{
    var url = Uri.parse(element);
    var res = await http.get(url);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= {res.statusCode}');
    var body= json.decode(res.body);
    print(body);
  });


}
