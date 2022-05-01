import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'min_temp.dart';

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6A17),
        title: const Text("Instant Heat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(24,0,0,8),
                child: Text("Status", style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,0,8,0),
                child: ListTile(
                  title: Text("Calentando"),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                    ),
                    backgroundColor: Color.fromARGB(255, 255, 154, 99),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text("La temperatura de tu bebida es",
                    style: TextStyle(color: Color.fromARGB(255, 255, 154, 99))),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text("39°", style: TextStyle(fontSize: 100)),
              ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  enabled: true,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MinTemp()));
                  },
                  title: Text("Cambiar temperatura"),
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.thermostat_outlined,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  enabled: true,
                  onTap: () {},
                  title: Text("Tazas consumidas"),
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.free_breakfast_outlined,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

authToken() async {
  var token = 'BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB';
  var distancia =
      "https://industrial.api.ubidots.com/api/v1.6/variables/626b848b1d84726028f78770/values?token=" +
          token;
  var temperature_set =
      "https://industrial.api.ubidots.com/api/v1.6/variables/626b7810e39bed000ae569cd/values?token=" +
          token;
  var relay =
      "https://industrial.api.ubidots.com/api/v1.6/variables/626b7381c7b02f000b0f0980/values?token=" +
          token;
  var temperatura =
      "https://industrial.api.ubidots.com/api/v1.6/variables/626b6f241d84723e4fb71d5e/values?token=" +
          token;
  var lista = [];
  lista.add(distancia);
  lista.add(temperature_set);
  lista.add(relay);
  lista.add(temperatura);
  var oldDate = new DateTime.fromMicrosecondsSinceEpoch(0);
  var nowDate = new DateTime.now().millisecondsSinceEpoch;

  lista.forEach((element) async {
    var url = Uri.parse(element);
    var res = await http.get(url);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= {res.statusCode}');
    var body = json.decode(res.body);
    print(body);
  });
}
