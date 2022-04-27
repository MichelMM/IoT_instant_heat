import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_info_plus/network_info_plus.dart';

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
              initialLoad();
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

void initialLoad() async {
  final info = NetworkInfo();
  var wifiName = await info.getWifiName();
  var wifiBSSID = await info.getWifiBSSID();
  var wifiIP = await info.getWifiIP();
  var wifiIPv6 = await info.getWifiIPv6();
  var wifiSubmask = await info.getWifiSubmask();
  var wifiBroadcast = await info.getWifiBroadcast();
  var wifiGateway = await info.getWifiGatewayIP();
  print("name: $wifiName");
  print("BSSID: $wifiBSSID");
  print("ip: $wifiIP");
  print("IPv6: $wifiIPv6");
  print("Submask: $wifiSubmask");
  print("Broadcast: $wifiBroadcast");
  print("Gateway: $wifiGateway");
}
