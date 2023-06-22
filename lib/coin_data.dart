import 'package:http/http.dart' as http;
import 'dart:convert';

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
  late String coinName;
  late String currencyName;

  CoinData({required this.coinName,required this.currencyName});

  Future<String> getPrice() async{
    String url = 'https://rest.coinapi'
        '.io/v1/exchangerate/$coinName/$currencyName?apikey=FE77DBD1-58AF-431C-85BF'
        '-09922DB053B9';
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      double price = jsonDecode(data)['rate'];
      return price.toStringAsFixed(2);
  }
}