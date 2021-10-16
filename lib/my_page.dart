import 'package:flutter/material.dart';
import 'package:jojojjo_generator/image_resources_loader.dart';
import 'package:jojojjo_generator/my_page_bloc.dart';
import 'package:jojojjo_generator/my_page_drawer.dart';
import 'package:jojojjo_generator/native_canvas_view.dart';
import 'package:jojojjo_generator/output_dialog.dart';
import 'package:jojojjo_generator/share_button.dart';
import 'package:rxdart/rxdart.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  //  読み込み中のインジケータ
  static const indicator = Center(child: CircularProgressIndicator());

  //  ガイドメッセージ
  static const guideMessage = Padding(
    padding: EdgeInsets.all(16),
    child: Text('じょじょっじょが何か言うてるにぇ。', style: TextStyle(fontSize: 16)),
  );

  //  ボディ部の制約
  static const bodyConstraints = BoxConstraints(maxWidth: 640);

  final subscriptions = CompositeSubscription();
  late final MyPageBloc bloc;

  final canvasKey = GlobalKey<NativeCanvasViewState>();
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc = MyPageBloc(ImageResourcesLoader());
    bloc.text.listen(onTextUpdated).addTo(subscriptions);
    bloc.outputRequested.listen(onOutputRequested).addTo(subscriptions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('じょじょっじょジェネレータ')),
      body: StreamBuilder<ImageResources?>(
        stream: bloc.resources,
        builder: (context, snapshot) {
          final resources = snapshot.data;

          return resources != null ? buildBody(resources) : indicator;
        },
      ),
      endDrawer: const MyPageDrawer(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    subscriptions.dispose();
    bloc.dispose();
    super.dispose();
  }

  //  ボディ部を生成する。
  Widget buildBody(ImageResources resources) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: bodyConstraints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  キャンバス部分
              buildCanvas(resources),

              //  ガイドメッセージ
              guideMessage,

              //  テキスト入力
              buildTextField(),

              //  共有ボタン
              buildShareButton(),
            ],
          ),
        ),
      ),
    );
  }

  //  Canvas描画部分を生成する。
  Widget buildCanvas(ImageResources resources) {
    return StreamBuilder<String>(
      initialData: MyPageBloc.initialText,
      stream: bloc.text,
      builder: (context, snapshot) {
        final text = snapshot.requireData;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
          child: NativeCanvasView(
            key: canvasKey,
            text: text,
            resources: resources,
          ),
        );
      },
    );
  }

  //  テキスト入力部分を生成する。
  Widget buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: bloc.onTextUpdated,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(hintText: 'じょじょっじょはなんて言うてる?'),
      ),
    );
  }

  //  共有ボタン部分を生成する。
  Widget buildShareButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder<bool>(
        initialData: MyPageBloc.isShareButtonEnabledInitially,
        stream: bloc.isShareButtonEnabled,
        builder: (context, snapshot) {
          final isEnabled = snapshot.requireData;
          final callback = isEnabled ? onShareButtonPressed : null;

          return ShareButton(onPressed: callback);
        },
      ),
    );
  }

  //  共有ボタンが押されたとき
  void onShareButtonPressed() {
    final imageSrc = canvasKey.currentState!.toDataUrl();
    bloc.onShareButtonPressed(imageSrc);
  }

  //  テキストが更新されたとき
  void onTextUpdated(String newText) {
    controller.value = controller.value.copyWith(text: newText);
  }

  //  出力要求が投げられたとき
  void onOutputRequested(String src) {
    showDialog<void>(
      context: context,
      builder: (context) => OutputDialog(imageSrc: src),
    );
  }
}
