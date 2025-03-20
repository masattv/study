// Firebase関連の機能を使用するためのパッケージをインポート
// FirebaseCoreは、Firebaseの基本的な初期化と構成管理を担当
import 'package:firebase_core/firebase_core.dart';

// Flutterの基本的なUI部品（ウィジェット）を提供するパッケージをインポート
// MaterialはGoogleのマテリアルデザインに基づいたUIを構築するためのコンポーネント群
import 'package:flutter/material.dart';

// プロジェクト固有のFirebase設定を含むファイルをインポート
// このファイルはFlutterFireのCLIツールで自動生成されたもの
import 'package:memoapp/firebase_options.dart';

// アプリの最初の画面（トップページ）を定義しているファイルをインポート
import 'package:memoapp/pages/top_page.dart';

// アプリケーションのエントリーポイント（起動時に最初に実行される関数）
// asyncキーワードは、この関数内で非同期処理（待機が必要な処理）を行うことを示す
void main() async {
  // Flutter Engineとウィジェットをバインド（接続）する初期化を行う
  // これはFirebaseなどのプラグインを使用する前に必要な初期化処理
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseを初期化する
  // awaitキーワードは非同期処理が完了するまで次の処理を待つことを示す
  // つまり、Firebase初期化が完了するまで、アプリの起動処理が一時停止する
  await Firebase.initializeApp(
    // 現在実行中のプラットフォーム（iOS/Android/Webなど）に合わせた設定を適用
    // これにより、デバイスに応じた適切なFirebase設定が自動的に選択される
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // アプリのルートウィジェット（MyApp）を実行して画面に表示する
  // これによりアプリのUI表示が開始される
  runApp(const MyApp());
}

// アプリ全体の設定と構造を定義するクラス
// StatelessWidgetは内部状態を持たない（変化しない）ウィジェット
// つまり、一度表示されたら、外部からの入力がない限り見た目が変わらない
class MyApp extends StatelessWidget {
  // クラスのコンストラクタ
  // constは、このウィジェットがコンパイル時に評価され、不変であることを示す
  // super.keyは親クラス（StatelessWidget）のコンストラクタにkeyパラメータを渡す
  // keyはウィジェットツリー内でこのウィジェットを一意に識別するために使用される
  const MyApp({super.key});

  // このウィジェットは、アプリのルート（根本）となるウィジェット

  @override
  // buildメソッドは、このウィジェットの見た目と構造を定義する
  // BuildContextは、ウィジェットツリー内でのこのウィジェットの位置情報を含む
  Widget build(BuildContext context) {
    // MaterialAppはマテリアルデザインの基本スタイルとナビゲーションを提供するウィジェット
    // マテリアルデザインとは、Googleが開発したデザインシステムで、視覚的に美しく直感的なUIを提供する
    return MaterialApp(
      // アプリの名前（デバイスのタスクマネージャーなどに表示される）
      title: 'Flutter Demo',

      // アプリ全体のデザインテーマを設定
      theme: ThemeData(
        // ColorSchemeはアプリで使用される色の集合を定義
        // fromSeedはベースカラー（seedColor）から自動的に調和の取れた色のセットを生成
        // この場合、深い紫色（Colors.deepPurple）を基準に各種の色が自動生成される
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // Material Design 3（Googleの最新デザインシステム）を使用するかどうか
        // trueにすると、より現代的で洗練されたUIコンポーネントが使用される
        useMaterial3: true,
      ),

      // アプリ起動時に最初に表示される画面（ホーム画面）を指定
      // TopPageウィジェットをインスタンス化し、タイトルプロパティを設定
      home: const TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}
