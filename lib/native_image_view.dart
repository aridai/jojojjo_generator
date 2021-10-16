import 'dart:collection';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:jojojjo_generator/platform_view.dart';

/// HTMLのimgタグによる画像描画を行うView
class NativeImageView extends StatefulWidget {
  const NativeImageView({
    Key? key,
    required this.src,
  }) : super(key: key);

  /// 画像ソース
  final String src;

  @override
  State<NativeImageView> createState() => _NativeImageViewState();
}

class _NativeImageViewState extends State<NativeImageView> {
  static const _viewType = 'NATIVE_IMAGE_VIEW';

  //  ImageElement保持用のMap
  //  (HtmlElementView読み込み後に取り出す。)
  static final _elementMap = HashMap<int, ImageElement>();

  ImageElement? _imageElement = null;

  @override
  void initState() {
    super.initState();

    registerViewFactory(_viewType, (viewId) {
      final img = ImageElement(width: 3000, height: 1500)
        ..style.width = '100%'
        ..style.height = '100%';
      _elementMap[viewId] = img;

      return img;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateImg();

    return AspectRatio(
      aspectRatio: 3000 / 1500,
      child: HtmlElementView(
        viewType: _viewType,
        onPlatformViewCreated: _onImgCreated,
      ),
    );
  }

  void _onImgCreated(int viewId) {
    _imageElement = _elementMap.remove(viewId);
    _updateImg();
  }

  void _updateImg() {
    _imageElement?.src = widget.src;
  }
}
