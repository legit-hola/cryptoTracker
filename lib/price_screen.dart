import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency='AUD';
  String selectedCoin='BTC';
  String price0 = '?';
  String price1 = '?';
  String price2 = '?';
  DropdownButton<String> getAndroid(){
    return DropdownButton(
      style: TextStyle(color: Colors.white),
      focusColor: Colors.black,
        value: selectedCurrency,
        elevation: 5,
        items: [
          for(String items in currenciesList)
            DropdownMenuItem(child: Text(items), value: items,),
        ],
        onChanged: (value) async{
        CoinData coinData0 = CoinData(coinName: cryptoList[0], currencyName: value!);
        CoinData coinData1 = CoinData(coinName: cryptoList[1], currencyName: value!);
        CoinData coinData2 = CoinData(coinName: cryptoList[2], currencyName: value!);
        var newPrice0 = await coinData0.getPrice();
        var newPrice1 = await coinData1.getPrice();
        var newPrice2 = await coinData2.getPrice();
          setState(() {
            selectedCurrency=value!;
            price0 = newPrice0;
            price1 = newPrice1;
            price2 = newPrice2;
          });
        },);
  }

  CupertinoPicker getIOS(){
    List<Widget> data=[];
    for(String items in currenciesList)
      data.add(Text(items));
    return CupertinoPicker(
      itemExtent: 40.0,
      onSelectedItemChanged: (selectedIndex) async{
        CoinData coinData0 = CoinData(coinName: cryptoList[0], currencyName: data[selectedIndex].toString());
        CoinData coinData1 = CoinData(coinName: cryptoList[1], currencyName: data[selectedIndex].toString());
        CoinData coinData2 = CoinData(coinName: cryptoList[2], currencyName: data[selectedIndex].toString());
        var newPrice0 = await coinData0.getPrice();
        var newPrice1 = await coinData1.getPrice();
        var newPrice2 = await coinData2.getPrice();
        setState(() {
          price0 = newPrice0;
          price1 = newPrice1;
          price2 = newPrice2;
          selectedCurrency=data[selectedIndex].toString();
        });

      },
      children: data,
    );
  }

  Widget getOS(){
    if(Platform.isAndroid){
      return getAndroid();
    }
    else {
      return getIOS();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         CoinName(selectedCoin: cryptoList[0], price: price0,selectedCurrency: selectedCurrency),
         CoinName(selectedCoin: cryptoList[1], price: price1, selectedCurrency: selectedCurrency),
         CoinName(selectedCoin: cryptoList[2], price: price2, selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getOS(),
            ),

        ],
      ),
    );
  }
}

class CoinName extends StatelessWidget {
  const CoinName({
    super.key,
    required this.selectedCoin,
    required this.price,
    required this.selectedCurrency,
  });

  final String selectedCoin;
  final String price;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCoin = $price $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
// DropdownButton<String>(
// value: selectedCurrency,
// items: [
// for(String items in currenciesList)
// DropdownMenuItem(
// child: Text(items),
// value: items,
// )],
// onChanged: (value) {
// // print(value);
// setState(() {
// selectedCurrency=value!;
// });}