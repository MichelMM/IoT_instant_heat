import 'dart:convert';

import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instant_heat/max_temp.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:http/http.dart' as http;

class MinTemp extends StatefulWidget {
  const MinTemp({Key? key}) : super(key: key);
  @override
  State<MinTemp> createState() => _MinTempState();
}

class _MinTempState extends State<MinTemp> {
  double _value = 50.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
              height: 40,
            ),
            SizedBox(
              child: Text(
                "Selecciona la temperatura mínima de tu bebida",
                style: GoogleFonts.lato(
                    fontSize: 32,
                    color: const Color(0xFF47525E),
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              width: 300,
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              "${_value.round()}°C",
              style: GoogleFonts.lato(
                  color: const Color(
                    0xFFFF6A17,
                  ),
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: 300,
              child: SfSlider(
                min: 30.0,
                max: 71.0,
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
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () async{
                var token = "?token=BBFF-MFDeikWJ8zzysRQOhzU5xbnJIpIgdB";
                var startDate = 0;
                var endDate = DateTime.now().millisecondsSinceEpoch;
                var temperature_set_delete = "https://industrial.api.ubidots.com/api/v2.0/variables/626b7810e39bed000ae569cd/_/values/delete/"+token + "&startDate=" + startDate.toString() + "&endDate=" + endDate.toString();
                var url = Uri.parse(temperature_set_delete);
                var res = await http.post(url);
                if (res.statusCode != 200 && res.statusCode != 202) throw Exception('http.post error: statusCode= ${res.statusCode}');
                
                var temperature_set_min = "https://industrial.api.ubidots.com/api/v1.6/variables/626b7810e39bed000ae569cd/values" + token;
                var headers = {
                  'Content-Type': 'application/json',
                };
                var data = {
                  "value":_value.round(),
                  "context":{
                      "type":"min"
                  }
                };
                url = Uri.parse(temperature_set_min);
                res = await http.post(url, headers: headers, body: jsonEncode(data));
                if (res.statusCode != 200 && res.statusCode != 201) throw Exception('http.post error: statusCode= ${res.statusCode}');
                print(res.body);
                
                
                Navigator.of(ContextHolder.currentContext).push(MaterialPageRoute(builder: (_) => MaxTemp(min: _value,)));

              },
              child: Text("Aceptar",
                  style: GoogleFonts.lato(fontSize: 25, color: Colors.white)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFFF6A17)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.fromLTRB(100, 20, 100, 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
