// Firebaseのデータベース（Firestore）機能を使用するためのパッケージをインポート
import 'package:cloud_firestore/cloud_firestore.dart';

// Flutterの基本的なUI部品（ウィジェット）を提供するパッケージをインポート
import 'package:flutter/material.dart';

// 自作したMemoクラス（データモデル）をインポート
import 'package:memoapp/model/memo.dart';

// メモの追加・編集画面ウィジェットをインポート
import 'package:memoapp/pages/add_edit_memo_page.dart';

// メモの詳細表示画面ウィジェットをインポート
import 'package:memoapp/pages/memo_detail_page.dart';

// アプリのトップページ（メイン画面）ウィジェット
// StatefulWidgetは内部状態を持つ（変化する）ウィジェット
// ユーザーの操作によって画面の表示が変わるため、StatefulWidgetを使用
class TopPage extends StatefulWidget {
  // コンストラクタ：keyとtitleを引数として受け取る
  // requiredキーワードは、このパラメータが必須であることを示す
  // super.keyは親クラス（StatefulWidget）のコンストラクタにkeyパラメータを渡す
  const TopPage({super.key, required this.title});

  // ページのタイトルを保持するフィールド
  // finalは、一度値が設定されたら変更できないことを示す（イミュータブル）
  final String title;

  @override
  // このウィジェットの状態を管理するStateクラスを作成
  State<TopPage> createState() => _TopPageState();
}

// TopPageの状態を管理するクラス
// Stateクラスは、ウィジェットの状態（データ）と見た目を管理する
class _TopPageState extends State<TopPage> {
  // Firestoreの「memo」コレクションへの参照を取得
  // finalは、この変数の参照先が変更されないことを示す
  final memoCollection = FirebaseFirestore.instance.collection("memo");

  // 指定されたIDのメモをFirestoreから削除する非同期関数
  // Future<void>は、この関数が非同期処理を行い、完了しても値を返さないことを示す
  Future<void> deleteMemo(String id) async {
    // 削除対象のメモドキュメントへの参照を取得
    // docメソッドで特定のドキュメントIDを指定してアクセス
    final doc = FirebaseFirestore.instance.collection("memo").doc(id);
    // ドキュメントを削除
    // deleteメソッドはドキュメント全体を削除する
    await doc.delete();
  }

  @override
  // ウィジェットの見た目と構造を定義するメソッド
  Widget build(BuildContext context) {
    // Scaffoldは、マテリアルデザインの基本的な画面レイアウト構造を提供するウィジェット
    return Scaffold(
      // 画面上部のアプリバー
      appBar: AppBar(
        // アプリバーの背景色をテーマから取得
        // inversePrimaryはプライマリカラーの補色（対照的な色）
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        // もともとのタイトル設定（コメントアウトされている）
        // title: Text(widget.title),

        // 実際に表示されるアプリバーのタイトル
        // constは、このウィジェットが変更されないことを示す（パフォーマンス最適化のため）
        title: const Text("Flutter × Firebase"),
      ),

      // 画面の主要部分（本文）
      // StreamBuilderは、非同期データのストリーム（連続したデータ）を監視して、
      // データの変更に応じてUIを自動的に再構築するウィジェット
      body: StreamBuilder<QuerySnapshot>(
          // 監視するデータストリームを指定
          // snapshotsメソッドはFirestoreのコレクションをリアルタイムで監視
          // orderByで作成日の降順（新しい順）にソート
          stream: memoCollection
              .orderBy("createdDate", descending: true)
              .snapshots(),

          // ストリームからデータを受け取ったときに呼ばれるビルダー関数
          // contextはウィジェットの位置情報、snapshotは受け取ったデータを含む
          builder: (context, snapshot) {
            // データの読み込み中の場合
            // ConnectionState.waitingは、データの初回読み込みや更新中の状態を表す
            if (snapshot.connectionState == ConnectionState.waiting) {
              // ローディングインジケータ（くるくる回るアイコン）を表示
              return const CircularProgressIndicator();
            }

            // データがない場合（まだメモが1つもない場合）
            if (!snapshot.hasData) {
              // 中央に「データがありません」というメッセージを表示
              return const Center(child: Text("データがありません"));
            }

            // 取得したドキュメント（メモ）のリスト
            // !はnull非許容の演算子で、nullでないことを明示的に示す
            final docs = snapshot.data!.docs;

            // ListView.builderはスクロール可能なリストを効率的に構築するウィジェット
            // 大量のデータがある場合でも、画面に表示される部分だけを描画する
            return ListView.builder(
                // リストの項目数（メモの数）
                itemCount: docs.length,

                // リストの各項目（各メモ）のウィジェットを構築する関数
                // indexは0から始まる項目の位置
                itemBuilder: (context, index) {
                  // ドキュメントのデータをMap形式で取得
                  // asキーワードは型キャストを行う（型の変換）
                  // Map<String, dynamic>は、文字列キーと任意の型の値を持つ辞書型
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;

                  // 取得したデータからMemoオブジェクトを作成
                  final Memo fetchMemo = Memo(
                      // ドキュメントIDをメモIDとして設定
                      id: docs[index].id,
                      // タイトルフィールドを取得
                      title: data["title"],
                      // 詳細フィールドを取得
                      detail: data["detail"],
                      // 作成日フィールドを取得
                      createdDate: data["createdDate"],
                      // 更新日フィールドを取得（null可）
                      updatedDate: data["updatedDate"]);

                  // ListTileはリスト内の1つの項目を表すウィジェット
                  // タイトル、サブタイトル、リーディング（左側）、トレイリング（右側）のアイコンなどを設定できる
                  return ListTile(
                    // メモのタイトルを表示
                    title: Text(fetchMemo.title),

                    // 右側に編集ボタンを配置
                    trailing: IconButton(
                      // ボタンがタップされた時の処理
                      onPressed: () {
                        // 画面下部からモーダルシート（画面の一部を覆うパネル）を表示
                        // showModalBottomSheetはFlutterの組み込み関数で、下から上にスライドするシートを表示
                        showModalBottomSheet(
                            context: context,
                            // モーダルシートの内容を構築する関数
                            builder: (context) {
                              // SafeAreaは、デバイスの物理的な特性（ノッチやホームバーなど）を避けて
                              // コンテンツを配置するウィジェット
                              return SafeArea(
                                // Columnウィジェットで子要素を縦に並べる
                                child: Column(
                                  // mainAxisSizeはColumnの主軸（縦方向）のサイズを指定
                                  // MainAxisSize.minは、子要素の高さの合計に合わせてColumnのサイズを調整
                                  mainAxisSize: MainAxisSize.min,
                                  // Columnの子ウィジェットのリスト
                                  children: [
                                    // 編集オプションを表示するListTile
                                    ListTile(
                                      // タップされた時の処理
                                      onTap: () {
                                        // モーダルシートを閉じる
                                        Navigator.pop(context);
                                        // メモ編集画面に遷移
                                        // MaterialPageRouteはページ遷移のアニメーションを提供
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                // 新しい画面のウィジェットを構築
                                                builder: (context) =>
                                                    // AddEditMemoPageを現在のメモデータで初期化
                                                    AddEditMemoPage(
                                                        currentMemo:
                                                            fetchMemo)));
                                      },
                                      // ListTileの左側に編集アイコンを表示
                                      leading: const Icon(Icons.edit),
                                      // ListTileのタイトルとして「編集」と表示
                                      title: const Text("編集"),
                                    ),
                                    // 削除オプションを表示するListTile
                                    ListTile(
                                      // タップされた時の処理
                                      onTap: () async {
                                        // 選択したメモを削除する関数を呼び出し
                                        await deleteMemo(fetchMemo.id);
                                        // モーダルシートを閉じる
                                        Navigator.pop(context);
                                      },
                                      // ListTileの左側に削除アイコンを表示
                                      leading: const Icon(Icons.delete),
                                      // ListTileのタイトルとして「削除」と表示
                                      title: const Text("削除"),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      // ボタンとして表示するアイコン
                      icon: const Icon(Icons.edit),
                    ),
                    // ListTile全体がタップされた時の処理
                    onTap: () {
                      // コメント：詳細確認画面に遷移する記述
                      // メモ詳細画面に遷移
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // 新しい画面のウィジェットを構築
                              // MemoDetailPageに選択したメモデータを渡す
                              builder: (context) => MemoDetailPage(fetchMemo)));
                    },
                  );
                });
          }),

      // 画面右下にフローティングアクションボタン（FAB）を配置
      // 新規メモ追加のためのボタン
      floatingActionButton: FloatingActionButton(
        // ボタンがタップされた時の処理
        onPressed: () {
          // メモ追加画面に遷移
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEditMemoPage()));
        },
        // ボタンにマウスを重ねた時に表示されるヒントテキスト
        // 本来は「新規追加」など適切な文字列に変更すべき
        tooltip: 'Increment',
        // ボタンの中に表示するアイコン（プラス記号）
        child: const Icon(Icons.add),
      ), // このカンマはコードの自動整形を美しくするためのもの
    );
  }
}
