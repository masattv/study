// Flutterの基本的なUI部品（ウィジェット）を提供するパッケージをインポート
import 'package:flutter/material.dart';

// 自作したMemoクラス（データモデル）をインポート
// このモデルはメモのデータ構造（id, title, detail, createdDate, updatedDate）を定義している
import 'package:memoapp/model/memo.dart';

// メモの詳細情報を表示するための画面ウィジェット
// StatelessWidgetは内部状態を持たない（変化しない）ウィジェット
// 表示するだけで、ユーザーの操作によって見た目が変わらない画面に適している
class MemoDetailPage extends StatelessWidget {
  // 表示するメモの情報を保持するフィールド
  // このウィジェット生成時に外部から受け取るデータ
  final Memo memo;

  // コンストラクタ：最初の引数としてmemoを受け取り、オプションでkeyも受け取る
  // メモオブジェクトは位置引数（名前なし引数）として渡される
  // 表示するメモの情報を指定するために必須のパラメータ
  // Key? keyはオプショナルな引数で、このウィジェットを一意に識別するために使用される
  // super(key: key)は親クラス（StatelessWidget）のコンストラクタにkeyを渡している
  const MemoDetailPage(this.memo, {Key? key}) : super(key: key);

  @override
  // ウィジェットの見た目と構造を定義するメソッド
  // BuildContextはウィジェットツリー内での位置情報を含む
  Widget build(BuildContext context) {
    // Scaffoldは、マテリアルデザインの基本的な画面レイアウト構造を提供するウィジェット
    // アプリバー、ボディ、フローティングアクションボタン、ドロワーなどを配置できる
    return Scaffold(
        // 画面上部のアプリバー
        appBar: AppBar(
          // アプリバーのタイトルにメモのタイトルを表示
          // 動的にメモのタイトルが表示される
          title: Text(memo.title),
        ),
        // 画面の主要部分（本文）
        body: Center(
          // 複数の子ウィジェットを縦方向に配置するレイアウトウィジェット
          child: Column(
            // 主軸（縦方向）の子ウィジェットの配置方法
            // MainAxisAlignment.centerは子ウィジェットを中央に配置する
            mainAxisAlignment: MainAxisAlignment.center,
            // このColumnの子ウィジェットのリスト
            children: [
              // 「メモ詳細」という見出しテキスト
              // constは、このウィジェットが変更されないことを示す（パフォーマンス最適化のため）
              // TextStyleでフォントサイズを20に、太字（bold）に設定
              const Text("メモ詳細",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              // メモの詳細内容を表示するテキスト
              // フォントサイズを16に設定
              // memo.detailで実際のメモ内容を表示（Memoオブジェクトのdetailプロパティ）
              Text(memo.detail, style: TextStyle(fontSize: 16)),
            ],
          ),
        ));
  }
}
