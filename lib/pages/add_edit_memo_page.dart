// Firebaseのデータベース（Firestore）機能を使用するためのパッケージをインポート
// Timestampなどのデータ型もこのパッケージから提供される
import 'package:cloud_firestore/cloud_firestore.dart';

// Flutterの基本的なUI部品（ウィジェット）を提供するパッケージをインポート
import 'package:flutter/material.dart';

// 自作したMemoクラス（データモデル）をインポート
// このモデルはメモのデータ構造を定義している
import 'package:memoapp/model/memo.dart';

// メモの新規作成と編集を行うための画面ウィジェット
// StatefulWidgetは内部状態を持つ（変化する）ウィジェット
// ユーザー入力によって画面の状態が変わるため、StatefulWidgetを使用
class AddEditMemoPage extends StatefulWidget {
  // 編集対象のメモデータを保持するフィールド
  // nullの場合は新規作成モード、値がある場合は編集モード
  // ?はこの変数がnull許容型（nullable）であることを示す
  final Memo? currentMemo; // 中身が入っていれば編集、入っていなければ追加

  // コンストラクタ：keyとcurrentMemoを引数として受け取る
  // {}で囲まれているのは名前付き引数（オプション引数）
  // Key? keyはこのウィジェットを一意に識別するためのキー（オプション）
  // this.currentMemoは引数の値をクラスのフィールドに代入する短縮記法
  const AddEditMemoPage({Key? key, this.currentMemo}) : super(key: key);

  @override
  // このウィジェットの状態を管理するStateクラスを作成する
  // _AddEditMemoPageStateという名前のStateクラスのインスタンスを返す
  // _で始まるクラス名はDartでは「プライベート」を意味し、このファイル内でのみアクセス可能
  State<AddEditMemoPage> createState() => _AddEditMemoPageState();
}

// AddEditMemoPageの状態を管理するクラス
// Stateクラスは、ウィジェットの状態（データ）と見た目を管理する
class _AddEditMemoPageState extends State<AddEditMemoPage> {
  // タイトル入力用のコントローラー
  // TextEditingControllerはテキストフィールドの入力値を管理するためのクラス
  // テキストの現在の値の取得や、テキストの変更を監視することができる
  TextEditingController titleController = TextEditingController();

  // 詳細内容入力用のコントローラー
  TextEditingController detailController = TextEditingController();

  // 新規メモをFirestoreに作成する非同期関数
  // Future<void>は、この関数が非同期処理を行い、完了しても値を返さないことを示す
  // asyncキーワードは、この関数内でawaitを使用できることを示す
  Future<void> createMemo() async {
    // Firestoreの「memo」コレクションへの参照を取得
    // コレクションは、Firestoreにおけるデータの集合（フォルダのようなもの）
    final memoCollection = FirebaseFirestore.instance.collection("memo");

    // メモのデータを新規ドキュメントとして追加
    // addメソッドは自動的に新しいドキュメントIDを生成し、指定されたデータを保存する
    // awaitは非同期処理が完了するまで次の処理を待つ
    await memoCollection.add({
      // テキストフィールドから取得したタイトルをFirestoreに保存
      "title": titleController.text,
      // テキストフィールドから取得した詳細内容をFirestoreに保存
      "detail": detailController.text,
      // 現在の日時をタイムスタンプとして作成日に保存
      // Timestamp.now()はFirebaseの日時型で、現在の日時を取得する
      "createdDate": Timestamp.now(),
    });
  }

  // 既存のメモをFirestoreで更新する非同期関数
  Future<void> updateMemo() async {
    // 更新対象のメモドキュメントへの参照を取得
    // docメソッドで特定のドキュメントIDを指定してアクセス
    // widget.currentMemo!.idのように!を使うと、nullでないことを明示的に示す（null許容型をnon-null型にキャスト）
    final doc = FirebaseFirestore.instance
        .collection("memo")
        .doc(widget.currentMemo!.id);

    // ドキュメントのフィールドを更新
    // updateメソッドは、指定されたフィールドのみを更新する
    await doc.update({
      // テキストフィールドから取得した新しいタイトルで更新
      "title": titleController.text,
      // テキストフィールドから取得した新しい詳細内容で更新
      "detail": detailController.text,
      // 現在の日時をタイムスタンプとして更新日に保存
      "updatedDate": Timestamp.now(),
    });
  }

  @override
  // ウィジェットが初期化される時に一度だけ呼ばれるメソッド
  // 初期状態の設定や初期化処理を行うのに適している
  void initState() {
    // 親クラス（State）のinitStateメソッドを呼び出す
    // 必ず最初に呼び出す必要がある
    super.initState();

    // 編集モードの場合（currentMemoがnullでない場合）
    if (widget.currentMemo != null) {
      // テキストフィールドに既存のタイトルを設定
      // これにより、編集画面を開いた時に現在のタイトルが表示される
      titleController.text = widget.currentMemo!.title;
      // テキストフィールドに既存の詳細内容を設定
      detailController.text = widget.currentMemo!.detail;
    }
  }

  @override
  // ウィジェットの見た目と構造を定義するメソッド
  Widget build(BuildContext context) {
    // Scaffoldは、マテリアルデザインの基本的な画面レイアウト構造を提供するウィジェット
    return Scaffold(
      // 画面上部のアプリバー
      appBar: AppBar(
        // アプリバーのタイトル：新規作成モードか編集モードかで表示を切り替え
        // 三項演算子 condition ? trueの場合 : falseの場合
        title: Text(widget.currentMemo == null ? "メモ追加" : "メモ編集"),
      ),
      // 画面の主要部分（本文）
      body: Center(
        // 複数の子ウィジェットを縦方向に配置するレイアウトウィジェット
        child: Column(
          // 子ウィジェットの横方向の配置を設定
          // CrossAxisAlignment.startは子ウィジェットを左端に配置
          crossAxisAlignment: CrossAxisAlignment.start,
          // このColumnの子ウィジェットのリスト
          children: [
            // 上部に余白を追加（高さ40ピクセル）
            // SizedBoxは指定されたサイズの空のスペースを作るウィジェット
            const SizedBox(height: 40),

            // 「タイトル」というラベルテキスト
            Text("タイトル"),

            // ラベルとテキストフィールドの間に余白を追加（高さ10ピクセル）
            const SizedBox(height: 10),

            // テキストフィールドを囲むコンテナ
            // Containerは、子ウィジェットにパディング、マージン、境界線などの装飾を追加できるウィジェット
            Container(
              // グレーの枠線で装飾
              // BoxDecorationは、コンテナの背景色、枠線、角丸などの見た目を定義
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),

              // 画面幅の80%の幅を設定
              // MediaQueryは現在のデバイスの画面サイズなど情報を取得するためのクラス
              width: MediaQuery.of(context).size.width * 0.8,

              // タイトル入力用のテキストフィールド
              child: TextField(
                // テキストコントローラーを接続
                // これにより、入力されたテキストを取得したり、初期値を設定したりできる
                controller: titleController,

                // テキストフィールドの見た目を設定
                decoration: const InputDecoration(
                  // テキストフィールドの外枠のスタイル
                  // OutlineInputBorderは角丸の枠線を表示
                  border: OutlineInputBorder(),

                  // テキスト入力領域の内側の余白
                  // 左側に10ピクセルの余白を追加
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
            ),

            // タイトルと詳細の間に余白を追加（高さ40ピクセル）
            const SizedBox(height: 40),

            // 「詳細」というラベルテキスト
            Text("詳細"),

            // ラベルとテキストフィールドの間に余白を追加（高さ10ピクセル）
            const SizedBox(height: 10),

            // 詳細入力用のテキストフィールドを囲むコンテナ
            Container(
              // グレーの枠線で装飾
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),

              // 画面幅の80%の幅を設定
              width: MediaQuery.of(context).size.width * 0.8,

              // 詳細入力用のテキストフィールド
              child: TextField(
                // テキストコントローラーを接続
                controller: detailController,

                // テキストフィールドの見た目を設定
                decoration: const InputDecoration(
                  // テキストフィールドの外枠のスタイル
                  border: OutlineInputBorder(),

                  // テキスト入力領域の内側の余白
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
            ),

            // テキストフィールドとボタンの間に余白を追加（高さ40ピクセル）
            const SizedBox(height: 40),

            // ボタンを配置するコンテナ
            Container(
              // 画面幅の80%の幅を設定
              width: MediaQuery.of(context).size.width * 0.8,

              // コンテナ内の子ウィジェットを中央揃えに配置
              alignment: Alignment.center,

              // 追加/更新ボタン
              // ElevatedButtonは浮き上がったように見えるマテリアルデザインのボタン
              child: ElevatedButton(
                // ボタンがタップされた時の処理
                // asyncキーワードは、この関数内でawaitを使用できることを示す
                onPressed: () async {
                  // 新規作成モードか編集モードかを判断
                  if (widget.currentMemo == null) {
                    // 新規作成モードの場合、createMemo関数を呼び出し
                    await createMemo();
                  } else {
                    // 編集モードの場合、updateMemo関数を呼び出し
                    await updateMemo();
                  }

                  // 処理完了後、前の画面に戻る
                  // popメソッドは現在の画面を閉じて前の画面に戻る
                  Navigator.pop(context);
                },

                // ボタンのテキスト：新規作成か編集かで表示を切り替え
                child: Text(widget.currentMemo == null ? "追加" : "更新"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
