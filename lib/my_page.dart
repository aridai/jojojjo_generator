import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  ↓ const つけわすれ
    return Scaffold(
      body: Center(
        child: Text('じょじょっじょジェネレータ'),
      ),
    );
  }
}

class  Bad_class {
  void doSomething(int x,
String y){
     return;
  }
}
