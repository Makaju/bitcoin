import 'dart:convert';

import 'package:http/http.dart'as http;

class NetworkHelper{
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    try{
      http.Response response =await http.get(Uri.parse(url));
      print(response);
      if(response.statusCode==200){
        var data = response.body;
        return jsonDecode(data);
      }
      else{
        throw(response.statusCode);
      }

    }
    catch(e){print(e);
    }


  }

}