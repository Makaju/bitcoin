import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/constants.dart';
import '../data/list_of_items.dart';

class CalculateValue extends StatefulWidget {
  const CalculateValue({Key? key}) : super(key: key);

  @override
  _CalculateValueState createState() => _CalculateValueState();
}

class _CalculateValueState extends State<CalculateValue> {
  late String coinValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Calculate Your coins value'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Here will be the different crypyos"),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: new InputDecoration(labelText: "Enter your number"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  coinValue = value;
                },
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
                height: 150,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: androidDropdown()),
          ],
        ),
      ),
    ));
  }
}
