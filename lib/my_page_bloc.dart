import 'package:jojojjo_generator/image_resources_loader.dart';
import 'package:rxdart/rxdart.dart';

/// MyPageのBLoC
class MyPageBloc {
  MyPageBloc(this._loader) {
    _loader.load().then((res) => _resources.value = res);
  }

  /// 初期テキスト
  static const initialText = '';

  /// 共有ボタンの活性の初期値
  static final isShareButtonEnabledInitially = initialText.isNotEmpty;

  final ImageResourcesLoader _loader;

  final _resources = BehaviorSubject<ImageResources?>.seeded(null);
  final _text = BehaviorSubject<String>.seeded(initialText);
  final _outputRequested = PublishSubject<String>();

  /// 画像リソース
  Stream<ImageResources?> get resources => _resources.stream;

  /// テキスト
  Stream<String> get text => _text.stream;

  /// 共有ボタンが有効かどうか
  Stream<bool> get isShareButtonEnabled => text.map((text) => text.isNotEmpty);

  /// 出力要求
  Stream<String> get outputRequested => _outputRequested.stream;

  /// テキストが更新されたとき
  void onTextUpdated(String newText) {
    _text.value = newText;
  }

  /// 共有ボタンが押されたとき
  void onShareButtonPressed(String imageSrc) {
    _outputRequested.add(imageSrc);
  }

  /// 終了処理を行う。
  void dispose() {
    _resources.close();
    _text.close();
    _outputRequested.close();
  }
}
