import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/classes/school.dart';
import 'package:webview_flutter/webview_flutter.dart';

// bron: https://www.youtube.com/watch?v=Wo0o0wSkn4k

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.school}) : super(key: key);
  late SchoolObject school;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late final SchoolObject school;
   String url = 'https://www.google.com/search?q=';

  @override
  void initState() {
    school = widget.school;
    getUrl();
    super.initState();



    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();


    WidgetsBinding.instance!.addPostFrameCallback((_) async {

      await getUrl();

    });
  }

  getUrl() {
    setState(() {

      school.naam.split(' ').forEach((element) {
        url += '$element+';
      });

      school.adres.split(',')[0].split(' ').forEach((element) {
        url += '$element+';
      });

      school.adres.split(',')[1].split(' ').forEach((element) {
        url += '$element+';
      });
    });

    print(url);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.indigo.shade800,
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: const Image(
            image: AssetImage('lib/images/81.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.black12),
          backgroundColor: Colors.indigo.shade800,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_rounded),
          ),
          title: Text('Internet Browser', style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white),),
        ),
        body:ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: WebView(
            debuggingEnabled: true,
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
      ),
    );


  }
}
