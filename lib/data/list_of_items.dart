import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'constants.dart';



Future<void> getData() async {
  try {
    double dataBTC = await CoinData().getETHCoinData('BTC', selectedCurrency);
    double dataETH = await CoinData().getETHCoinData('ETH', selectedCurrency);
    double dataLTC = await CoinData().getETHCoinData('LTC', selectedCurrency);
      coinBTC = dataBTC.toStringAsFixed(2);
      coinETH = dataETH.toStringAsFixed(2);
      coinLTC = dataETH.toStringAsFixed(2);
  } catch (e) {
    print(e);
  }
}



DropdownButton<String> androidDropdown() {
  List<DropdownMenuItem<String>> dropdownItems = [];
  for (String currency in currenciesList) {
    var newItem = DropdownMenuItem(
      child: Text(currency),
      value: currency,
    );
    dropdownItems.add(newItem);
  }

  return DropdownButton<String>(
    value: selectedCurrency,
    items: dropdownItems,
    onChanged: (value) {
        selectedCurrency = value!;
        print(value);
        //2: Call getData() when the picker/dropdown changes.
        getData();
    },
  );
}

CupertinoPicker iOSPicker() {
  List<Text> pickerItems = [];
  for (String currency in currenciesList) {
    pickerItems.add(Text(currency));
  }

  return CupertinoPicker(
    backgroundColor: Colors.lightBlue,
    itemExtent: 32.0,
    onSelectedItemChanged: (selectedIndex) {
      print(selectedIndex);
        //1: Save the selected currency to the property selectedCurrency
        selectedCurrency = currenciesList[selectedIndex];
        //2: Call getData() when the picker/dropdown changes.
        getData();
    },
    children: pickerItems,
  );
}