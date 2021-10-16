import 'package:flutter/material.dart';
import 'package:jojojjo_generator/native_image_view.dart';

/// 出力ダイアログ
class OutputDialog extends StatelessWidget {
  const OutputDialog({
    Key? key,
    required this.imageSrc,
  }) : super(key: key);

  /// 画像ソース
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: NativeImageView(src: imageSrc),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
      contentPadding: const EdgeInsets.all(4),
      insetPadding: const EdgeInsets.all(4),
    );
  }
}
