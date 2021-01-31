import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _cepController = TextEditingController();
  String _result = "Result";

  _recoverCep() async {
    String cep = _cepController.text;
    String url = "https://viacep.com.br/ws/$cep/json/";
    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    String publicPlace = decodedResponse["logradouro"];
    String complement = decodedResponse["complemento"];
    String neighborhood = decodedResponse["bairro"];
    String locality = decodedResponse["localidade"];

    setState(() {
      _result = "$publicPlace, $complement, $neighborhood";
    });

    print(
      "Response public place: $publicPlace complement: $complement neighborhood: $neighborhood"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consuming web services"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Type the cep: ex: 05428200"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _cepController,
            ),
            RaisedButton(
              child: Text("Click here"),
              onPressed: _recoverCep,
            ),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
