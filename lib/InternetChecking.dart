import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:web_view/outofinternet.dart';
import 'package:web_view/web.dart';
import 'outofinternet.dart';

import 'package:flutter/material.dart';





class internetChecking extends StatefulWidget {
  @override
  _internetCheckingState createState() => _internetCheckingState();
}

class _internetCheckingState extends State<internetChecking> {
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


    switch (_source.keys.toList()[0]) {
  /*    case ConnectivityResult.none:
        string = "Offline";
        debugPrint("offline orginal");
        if (!isOnline) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => outOfInternet()));
        }

        break;
        */

      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        debugPrint(string);
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
        debugPrint(string);
     //Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
        break;

      case ConnectivityResult.none:
        string = "Offline";
        debugPrint(string);
        if (!isOnline) {
          debugPrint(" offline ok "+string);
         // Navigator.push(context, MaterialPageRoute(builder: (context) => outOfInternet()));
        }

        break;
    }


    return Center(

    );


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
      final result = await InternetAddress.lookup('example.com');
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