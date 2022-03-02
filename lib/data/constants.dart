import 'package:flutter/material.dart';

String selectedCurrency = 'USD';
String coinBTC = '?';
String coinETH = '?';
String coinLTC = '?';


const kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter City',
  hintStyle: TextStyle(color: Colors.grey),
  icon: Icon(
    Icons.location_city_sharp,
    color: Colors.white,
  ),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide.none,
  ),
)
;