import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:web_view/web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class out_of_internet extends StatefulWidget {
  @override
  _out_of_internetState createState() => _out_of_internetState();
}

class _out_of_internetState extends State<out_of_internet> {

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }



  @override
  Widget build(BuildContext context) {

    String string;

    switch (_source.keys.toList()[0])
    {

      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        debugPrint(string);
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));

        Back();
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        debugPrint(string);
        Back();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
        break;

    }


    return  MaterialApp(
      home: Scaffold(
        body: Container(
          child: Text("We have no internet"),
        ),

      ),

    );
  }


  void Back(){
  //  Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => out_of_internet()));

  }
}


class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();

}




bool isOnline = false;