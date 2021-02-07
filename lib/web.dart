import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'outofinternet.dart';

bool initializ_offline = true;

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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

          if (!initializ_offline)
        {
        // debugPrint(" offline ok "+string);
        if (ConnectivityResult.mobile != _source.keys.toList()[0] &&
            ConnectivityResult.mobile != _source.keys.toList()[0])
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => out_of_internet()));
            initializ_offline = true;
        }

          initializ_offline = false;

        break;
    }

/*    String string;


    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.wifi:
        string = "Offline";
        debugPrint("offline orginal");
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => outOfInternet()));
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
        break;
      case ConnectivityResult.none:
        string = "WiFi: Online";
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
        break;
    }*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => new WebviewScaffold(
              appBar: AppBar(
                title: Text('ModisteBd'),
              ),
              url: "https://www.modistebd.com",
              withJavascript: true,
              withLocalStorage: true,
              appCacheEnabled: false,
              withZoom: true,
              ignoreSSLErrors: true,
            ),
      },
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
