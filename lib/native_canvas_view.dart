import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:jojojjo_generator/image_resources_loader.dart';
import 'package:jojojjo_generator/platform_view.dart';

/// HTMLによるCanvas描画を行うView
class NativeCanvasView extends StatefulWidget {
  const NativeCanvasView({
    Key? key,
    required this.text,
    required this.resources,
  }) : super(key: key);

  /// 喋らせたいテキスト
  final String text;

  /// 画像リソース
  final ImageResources resources;

  @override
  State<NativeCanvasView> createState() => NativeCanvasViewState();
}

/// NativeCanvasViewのState
class NativeCanvasViewState extends State<NativeCanvasView> {
  static const _width = 3000;
  static const _height = 1500;

  static const _viewType = 'NATIVE_CANVAS_VIEW';

  //  CanvasElement保持用のMap
  //  (HtmlElementView読み込み後に取り出す。)
  static final _elementMap = HashMap<int, CanvasElement>();

  CanvasElement? _canvasElement = null;

  @override
  void initState() {
    super.initState();

    registerViewFactory(_viewType, (viewId) {
      final canvas = CanvasElement(width: _width, height: _height)
        ..style.width = '100%'
        ..style.height = '100%';
      _elementMap[viewId] = canvas;

      return canvas;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateCanvas();

    return AspectRatio(
      aspectRatio: _width / _height,
      child: SizedBox(
        width: _width.toDouble(),
        height: _height.toDouble(),
        child: HtmlElementView(
          viewType: _viewType,
          onPlatformViewCreated: _onCanvasCreated,
        ),
      ),
    );
  }

  /// Canvasの描画内容をデータURLに変換する。
  String toDataUrl() => _canvasElement!.toDataUrl();

  void _onCanvasCreated(int viewId) {
    _canvasElement = _elementMap.remove(viewId);
    _updateCanvas();
  }

  void _updateCanvas() {
    final context = _canvasElement?.context2D;
    if (context == null) return;

    context.clearRect(0, 0, _width, _height);

    //  ふきだしと魔理沙の画像を描画する。
    context.drawImage(widget.resources.balloonImage, 0, 0);
    context.drawImage(widget.resources.marisaImage, _width / 2, 0);

    //  テキストを描画する。
    context.fillStyle = '#000000';
    context.font = '80px sans-serif';

    const x = 100.0;
    const y = 250.0;
    const lineHeight = 96;
    final lines = LineSplitter.split(widget.text).toList();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final offsetY = lineHeight * i;

      context.fillText(line, x, y + offsetY);
    }
  }
}
