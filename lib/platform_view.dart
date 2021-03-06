import 'dart:html';
import 'dart:ui' as ui;

/// PlatformView (HtmlElementView) を登録する。
void registerViewFactory(String viewType, HtmlElement factory(int viewId)) {
  //// ignore: undefined_prefixed_name, avoid_dynamic_calls
  ui.platformViewRegistry.registerViewFactory(
    viewType,
    (int viewId) => factory(viewId),
  );
}
