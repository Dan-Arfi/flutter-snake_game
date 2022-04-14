import 'package:flutter/material.dart';

import 'home_page.dart';

void main(List<String> args) {
  runApp(myApp());
}


class myApp extends StatelessWidget {
  const myApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}
