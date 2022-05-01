import 'dart:async';
import 'dart:convert';

import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:instant_heat/min_temp.dart';
import 'package:http/http.dart' as http;

class SearchDevice extends StatefulWidget {
  const SearchDevice({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<SearchDevice> createState() => _SearchDeviceState();
}

class _SearchDeviceState extends State<SearchDevice> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchDevice(widget.id);
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
              Text(
                "Instant Heat",
                style: GoogleFonts.lato(
                    color: const Color(
                      0xFFFF6A17,
                    ),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'images/connection.png',
                alignment: Alignment.center,
                width: 200,
                color: const Color(
                  0xFFFF6A17,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Buscando...",
                style: GoogleFonts.lato(fontSize: 30),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                child: Text(
                    "Asegúrese de que su taza esté encendida y su dispositivo móvil esté conectado a la red WiFi",
                    style: GoogleFonts.lato(fontSize: 20),
                    textAlign: TextAlign.center),
                width: 300,
              )
            ],
          ),
        ));
  }
}

searchDevice(String id) async {
  var context = ContextHolder.currentContext;
  var token = 'BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB';
  var devices =
      "https://industrial.api.ubidots.com/api/v2.0/devices/?token=" + token;
  var url = Uri.parse(devices);
  var res = await http.get(url);
  if (res.statusCode != 200)
    // ignore: curly_braces_in_flow_control_structures
    throw Exception('http.post error: statusCode= ${res.statusCode}');
  var list = [];

  await Future.delayed(const Duration(seconds: 3));
  var flag = false;
  var body = json.decode(res.body);
  list = body["results"];
  list.forEach((element) => {
        if (element["name"] == id) {flag = true}
      });
  if (flag == true){
    await Hive.openBox('device');
    final device = Hive.box('device');
    await device.put('id', id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MinTemp()));
  }
    
  else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("invalid ID, please try again!")));
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
  }
}
