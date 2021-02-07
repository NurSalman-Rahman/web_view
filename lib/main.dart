import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:web_view/web.dart';
import 'InternetChecking.dart';
import 'testWidget.dart';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
/*
void main() => runApp(MaterialApp(title: "Wifi Check", home: MyPage()));

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _tryAgain = false;

  @override
  void initState() {
    super.initState();
    _checkWifi();
  }

  _checkWifi() async {
    // the method below returns a Future
    var connectivityResult = await (new Connectivity().checkConnectivity());
    bool connectedToWifi = (connectivityResult == ConnectivityResult.wifi);
    if (!connectedToWifi) {
      _showAlert(context);
    }
    if (_tryAgain != !connectedToWifi) {
      setState(() => _tryAgain = !connectedToWifi);
    }
  }

  @override
  Widget build(BuildContext context) {
    var body = Container(
      alignment: Alignment.center,
      child: _tryAgain
          ? RaisedButton(
          child: Text("Try again"),
          onPressed: () {
            _checkWifi();
          })
          : Text("This device is connected to Wifi"),
    );

    return Scaffold(
        appBar: AppBar(title: Text("Wifi check")),
        body: body
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Wifi"),
          content: Text("Wifi not detected. Please activate it."),
        )
    );
  }
}*/



void main()
{
  runApp(Myapp(



  ));
}
class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.lightGreenAccent,
      ),

      home: MyHomePage(),

      debugShowCheckedModeBanner: false,

    );
  }
}
class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState  createState() => _MyHomePageState();

// TODO: implement createState

}


class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () =>
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>   TestWidget())));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 120.0,width: 50,),
          SpinKitWave	(color: Colors.deepOrange,)

        ],

      ),

    );
  }
}







