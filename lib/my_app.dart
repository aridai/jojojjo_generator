import 'package:flutter/material.dart';
import 'package:jojojjo_generator/my_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'じょじょっじょジェネレータ',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'KosugiMaru'),
      home: const MyPage(),
    );
  }
}
