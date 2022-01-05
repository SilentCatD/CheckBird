import 'dart:async';
import 'dart:convert';

import 'package:check_bird/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class QuotesAPI extends StatefulWidget {
  static const routeName = '/home-screen';

  const QuotesAPI({Key? key}) : super(key: key);

  @override
  _QuotesAPISate createState() => _QuotesAPISate();
}


class _QuotesAPISate extends State<QuotesAPI> {
  final String _url = "https://api.quotable.io/random";
  late StreamController _streamController;
  late Stream _stream;
  late Response response;


  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getQuotes();
  }

  getQuotes() async {
    response = await get(Uri.parse(_url));
    Map<String, dynamic> quotes = json.decode(response.body);

    while(int.parse(quotes['length'].toString()) > 80){
      response = await get(Uri.parse(_url));
      quotes = json.decode(response.body);
    }
    _streamController.add(quotes);
  }

  @override
  Widget build(BuildContext context) {

    AppThemeKeys? themeKey = AppTheme.of(context).getCurrentThemeKey();

    late Color cText;
    late Color cBox;

    if(themeKey == AppThemeKeys.light) {
        cText = Colors.black;
    }
    else {
        cText = Colors.white;
    }


    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: size.width * 0.9,
      height: size.height*0.2,
      child:  StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if(snapshot.data != null){
              String quote = snapshot.data['content'].toString();
              return Padding(
                padding:  const EdgeInsets.all(4.0),
                child: Center(
                    child: Text(
                        quote,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            letterSpacing: 3,
                            fontSize: 25.0,
                            color: cText,
                            fontFamily: 'DancingScript',
                            fontWeight: FontWeight.bold)
                    )),
              );
            }
            return Center(child: Text(
                "Waiting for love",
                textAlign: TextAlign.center,
                style:  TextStyle(
                    letterSpacing: 3,
                    fontSize: 25.0,
                    color: cText,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold)
            ));
          }),
      );
  }
}
