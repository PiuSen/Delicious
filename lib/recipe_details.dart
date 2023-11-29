

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class  Details extends StatefulWidget {
  String url;
  Details(this.url);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late String finalUrl;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  void initState() {
    if(widget.url.toString().contains("http://")){
      finalUrl=widget.url.toString().replaceAll("http://", "https://");

    }
    else{
      finalUrl=widget.url;
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
      ),
      body: Column(
        children: [
          Expanded(
            child:WebView(
                zoomEnabled:true,
              initialUrl:finalUrl,
             javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated:(WebViewController webViewController){
                setState(() {
                  _controller.complete(webViewController);
                });
              }

          ),

          )
        ],




        ) ,
    );



  }
}



