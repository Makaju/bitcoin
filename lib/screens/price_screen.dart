import 'package:bitcoin/screens/calculate_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:http/http.dart' as http;
import '../data/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  late double coinValue = 1.0;
  late double finalCOinValue=1.0;
  late double coinValueDEC = 0.0;
  String coinBTC = '?';
  String coinETH = '?';
  String coinLTC = '?';
  double btcValue = 0.0;
  double ethValue = 0.0;
  double ltcValue = 0.0;
  double btcValueDEC = 1.0;
  double ethValueDEC = 1.0;
  double ltcValueDEC = 1.0;

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
        setState(() {
          selectedCurrency = value!;
          print(value);
          //2: Call getData() when the picker/dropdown changes.
          getData();
        });
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
        setState(() {
          //1: Save the selected currency to the property selectedCurrency
          selectedCurrency = currenciesList[selectedIndex];
          //2: Call getData() when the picker/dropdown changes.
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Future<void> getData() async {
    try {
      double dataBTC = await CoinData().getETHCoinData('BTC', selectedCurrency);
      double dataETH = await CoinData().getETHCoinData('ETH', selectedCurrency);
      double dataLTC = await CoinData().getETHCoinData('LTC', selectedCurrency);
      setState(() {
        coinBTC = dataBTC.toStringAsFixed(2);
        coinETH = dataETH.toStringAsFixed(2);
        coinLTC = dataLTC.toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
    }
  }
final _textController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text='';
    getData();
  }
@override
  void dispose() {
    // TODO: implement dispose
  _textController.dispose();
  super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Paisa he paisa hoga'),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalculateValue(),
                ),
              );
            },
            child: Text(
              'Calculate',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '$finalCOinValue BTC =  $btcValue $selectedCurrency ',
                          //todo yesma url plus coin name and currency name pass garnu parcha
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '$finalCOinValue ETH = ${ethValue} $selectedCurrency',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '$finalCOinValue LTC = $ltcValue $selectedCurrency',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                         // controller: _textController,
                          decoration: new InputDecoration(
                              labelText: "Coin Value before decimal"),
                          keyboardType: TextInputType.number,
                          // inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.digitsOnly,
                          //   FilteringTextInputFormatter(".",allow: true)
                          // ],
                          onChanged: (value) {

                              // _textController.text=value;
                              // print(_textController.text);

                              //
                              var fieldValue = '$value';
                              finalCOinValue = coinValue + coinValueDEC;

                              if(finalCOinValue<=0){
                                setState(() {
                                  finalCOinValue=1.0;
                                  ethValue=double.parse(coinETH);
                                  btcValue=double.parse(coinBTC);
                                  ltcValue=double.parse(coinLTC);
                                });


                              }
                              else if(finalCOinValue>0){

                              setState(() {
                                coinValue = double.parse(fieldValue);
                                ethValueDEC = double.parse(coinETH) * coinValueDEC;
                                btcValueDEC = double.parse(coinBTC) * coinValueDEC;
                                ltcValueDEC = double.parse(coinLTC) * coinValueDEC;
                                ethValue = double.parse(coinETH) * coinValue + ethValueDEC;
                                btcValue = double.parse(coinBTC) * coinValue + btcValueDEC;
                                ltcValue = double.parse(coinLTC) * coinValue + ltcValueDEC;
                                print(ltcValue);
                                print(finalCOinValue);
                              });
                              }

                          },
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          decoration: new InputDecoration(
                              labelText: "Coin value after decimal"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (valuedec) {

                              var fieldValue = '$valuedec.0';
                              if(finalCOinValue<=0.0){
                                setState(() {
                                  finalCOinValue=1.0;
                                  ethValue=double.parse(coinETH);
                                  btcValue=double.parse(coinBTC);
                                  ltcValue=double.parse(coinLTC);
                                });
                              }
                              else if(finalCOinValue>0){
                                setState(() {

                                  coinValue = double.parse(fieldValue);
                                  finalCOinValue = coinValue + coinValueDEC;
                                  ethValueDEC = double.parse(coinETH) * coinValueDEC;
                                  btcValueDEC = double.parse(coinBTC) * coinValueDEC;
                                  ltcValueDEC = double.parse(coinLTC) * coinValueDEC;
                                  ethValue = double.parse(coinETH) * coinValue + ethValueDEC;
                                  btcValue = double.parse(coinBTC) * coinValue + btcValueDEC;
                                  ltcValue = double.parse(coinLTC) * coinValue + ltcValueDEC;

                                  print(ltcValue);
                                  print(finalCOinValue);
                                });

                              }

                          },
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: androidDropdown(),
                ),
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: AppBar(title: Text("bottom app bar"),),
    ));
  }
}

// CupertinoPicker(
// itemExtent: 32.0,
// onSelectedItemChanged: (selectedIndex) {
// print(selectedIndex);
// },
// backgroundColor: Colors.amber,
// children: getDropDownItem(),
// // GetPickerItems(),
// ),
