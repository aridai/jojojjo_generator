import 'package:flutter/material.dart';

/// 共有ボタン
class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Padding(padding: EdgeInsets.all(4), child: Icon(Icons.share)),
          Padding(padding: EdgeInsets.all(4), child: Text('共有')),
        ],
      ),
    );
  }
}
