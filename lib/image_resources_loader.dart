import 'dart:async';
import 'dart:html';

/// 画像リソースの読み込み処理
class ImageResourcesLoader {
  /// 画像リソースを読み込む。
  Future<ImageResources> load() async {
    final balloonFuture = _loadImage('assets/assets/balloon.png');
    final marisaFuture = _loadImage('assets/assets/marisa.png');

    final response =
        await Future.wait<ImageElement>([balloonFuture, marisaFuture]);

    return ImageResources(response.first, response.last);
  }

  Future<ImageElement> _loadImage(String path) async {
    final img = ImageElement()..style.display = 'none';
    final completer = Completer<ImageElement>();

    final onLoadSubscription =
        img.onLoad.listen((e) => completer.complete(img));
    final onErrorSubscription =
        img.onError.listen((e) => completer.completeError(e));

    try {
      img.src = path;
      return await completer.future;
    } finally {
      onLoadSubscription.cancel();
      onErrorSubscription.cancel();
    }
  }
}

class ImageResources {
  ImageResources(this.balloonImage, this.marisaImage);

  final ImageElement balloonImage;
  final ImageElement marisaImage;
}
