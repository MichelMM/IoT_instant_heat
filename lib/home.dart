import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:instant_heat/consumido.dart';
import 'package:instant_heat/mqtt/MQTTManager.dart';
import 'package:instant_heat/mqtt/state/MQTTAppState.dart';
import 'package:provider/provider.dart';

import 'min_temp.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp = "";
  var relay = 0.0;
  Future<void> getValues() async {
    var token = 'BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB';
    var temperatura =
        "https://industrial.api.ubidots.com/api/v1.6/variables/626b6f241d84723e4fb71d5e/?token=" +
            token;
    var relay_str =
        "https://industrial.api.ubidots.com/api/v1.6/variables/626b7381c7b02f000b0f0980/?token=" +
            token;
    var url = Uri.parse(temperatura);
    var res = await http.get(url);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= {res.statusCode}');
    var body = json.decode(res.body);
    url = Uri.parse(relay_str);
    res = await http.get(url);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= {res.statusCode}');
    var body2 = json.decode(res.body);
    setState(() {
      temp = body["last_value"]["value"].toString();
      relay = body2["last_value"]["value"];
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getValues();
    updatePage();
  }

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
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 0, 8),
                child: Text("Status", style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ListTile(
                  title: Text(relay==0?"Apagado":"Calentando"),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                    ),
                    backgroundColor: relay==0?Colors.red:Colors.green,
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
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("$temp°", style: TextStyle(fontSize: 100)),
              ),
              OutlinedButton(
                onPressed: () async {
                  relay==0?await publishMQTTon():await publishMQTToff();
                },
                child: Text(relay==0?"Calentar":"Apagar",
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
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MinTemp()));
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => Consumido()));
                  },
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

updatePage() {
  var duration = const Duration(minutes: 10);
  Timer(duration, () {
    Navigator.of(ContextHolder.currentContext).pop();
    Navigator.of(ContextHolder.currentContext)
        .push(MaterialPageRoute(builder: (_) => const Home()));
  });
}

startDevice() async {
  var token = "?token=BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB";
  var relay =
      "https://industrial.api.ubidots.com/api/v1.6/variables/626b7381c7b02f000b0f0980/values" +
          token;
  var headers = {
    'Content-Type': 'application/json',
  };
  var data = {
    "value": 1,
  };
  var url = Uri.parse(relay);
  var res = await http.post(url, headers: headers, body: jsonEncode(data));
  if (res.statusCode != 200 && res.statusCode != 201)
    throw Exception('http.post error: statusCode= ${res.statusCode}');
  print(res.body);
}

publishMQTTon() async {
  var token = 'BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB';
  var distancia_url =
      "https://industrial.api.ubidots.com/api/v1.6/variables/626b848b1d84726028f78770/?token=" +
          token;
  var url = Uri.parse(distancia_url);
  var res = await http.get(url);
  if (res.statusCode != 200)
    throw Exception('http.post error: statusCode= {res.statusCode}');
  var body = json.decode(res.body);
  var distancia = body["last_value"]["value"];
  if (distancia > 5) {
    ScaffoldMessenger.of(ContextHolder.currentContext).showSnackBar(const SnackBar(
        content: Text(
            "Favor de colocar su taza sobre el calentador antes de iniciar")));
    return;
  }

  await Hive.openBox('device');
  final dev = Hive.box('device');
  var id = dev.get('id');
  MQTTManager device = MQTTManager(
      host: "industrial.api.ubidots.com",
      topic: "/v1.6/devices/$id",
      identifier: "Flutter_Android");
  device.initializeMQTTClient();
  device.connect();
  await Future.delayed(Duration(seconds: 5));
  device.publish('{"relay":"1"}');

  device.disconnect();
  Navigator.of(ContextHolder.currentContext).pop();
    Navigator.of(ContextHolder.currentContext)
        .push(MaterialPageRoute(builder: (_) => const Home()));
}

publishMQTToff() async {
  await Hive.openBox('device');
  final dev = Hive.box('device');
  var id = dev.get('id');
  MQTTManager device = MQTTManager(
      host: "industrial.api.ubidots.com",
      topic: "/v1.6/devices/$id",
      identifier: "Flutter_Android");
  device.initializeMQTTClient();
  device.connect();
  await Future.delayed(Duration(seconds: 5));
  device.publish('{"relay":"0"}');

  device.disconnect();
  Navigator.of(ContextHolder.currentContext).pop();
  Navigator.of(ContextHolder.currentContext)
      .push(MaterialPageRoute(builder: (_) => const Home()));
}
