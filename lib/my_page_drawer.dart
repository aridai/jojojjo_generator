import 'dart:js' as js;

import 'package:flutter/material.dart';

/// MyPageのDrawer部分
class MyPageDrawer extends StatelessWidget {
  const MyPageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //  魔理沙アイコン
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Image.asset('assets/marisa.png', width: 200, height: 200),
          ),

          //  アプリ名
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            alignment: Alignment.center,
            child: const Text(
              'じょじょっじょジェネレータ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          //  リポジトリ
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('GitHubリポジトリ'),
            onTap: () =>
                _openUrl('https://github.com/aridai/jojojjo_generator'),
          ),

          //  ライブラリページ
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('使用ライブラリ一覧'),
            onTap: () => _openUrl(
              'https://github.com/aridai/jojojjo_generator/'
              'blob/master/LIBRARIES.md',
            ),
          ),

          //  ミミッミジェネレータ
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('ミミッミジェネレータ'),
            onTap: () => _openUrl('https://aridai.github.io/MimimmiGenerator/'),
          ),
        ],
      ),
    );
  }

  //  URLを開く。
  void _openUrl(String url) {
    js.context.callMethod('open', <String>[url]);
  }
}
