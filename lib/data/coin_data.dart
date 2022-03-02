import 'dart:convert';

import 'package:http/http.dart' as http;

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'EA3A2551-3E79-4248-9514-57B9EC172D81';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future getBITCoinData() async {
    // String requestURL = '$coinAPIURL/BTC/USD?apikey=$apiKey';
    // http.Response response = await http.get (requestURL);
    String requestURL = '$coinAPIURL/BTC/USD?apiKey=$apiKey';
    http.Response response = await http.get(Uri.parse(requestURL));

    if(response.statusCode==200){
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    }
    else{
      print(response.statusCode);
      throw 'Problem with get request';
    }


  }
  Future getETHCoinData(String coinName, String curr) async {
    // String requestURL = '$coinAPIURL/BTC/USD?apikey=$apiKey';
    // http.Response response = await http.get (requestURL);
    String requestURL = '$coinAPIURL/$coinName/$curr?apiKey=$apiKey';
    http.Response response = await http.get(Uri.parse(requestURL));

    if(response.statusCode==200){
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    }
    else{
      print(response.statusCode);
      throw 'Problem with get request';
    }


  }

}
