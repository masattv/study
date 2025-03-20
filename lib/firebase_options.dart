// FlutterFireのCLIツールによって自動生成されたファイル
// このファイルはFirebaseの設定情報を含み、手動で編集することは推奨されていない

// このコメントは型関連の警告を無視する設定
// lintはDartのコード品質チェックツールで、これはその警告を抑制している
// ignore_for_file: type=lint

// Firebaseの初期化に必要なFirebaseOptionsクラスをインポート
// showキーワードは特定のクラスだけをインポートすることを示す
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

// Flutterのプラットフォーム判定機能をインポート
// 実行中のプラットフォーム（Android/iOS/Webなど）を判断するために使用
// showキーワードは特定のクラスや定数だけをインポートすることを示す
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// 各プラットフォーム用のFirebase設定オプション
///
/// 使用例:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
// このクラスは、各プラットフォーム別のFirebase接続情報を提供する
class DefaultFirebaseOptions {
  // 現在実行中のプラットフォームに適したFirebaseOptionsを返すゲッター
  // getキーワードはゲッターメソッドを定義する（プロパティのように使えるメソッド）
  static FirebaseOptions get currentPlatform {
    // WebブラウザでアプリがHostingされている場合
    // kIsWebはFlutterアプリがWebブラウザで実行されているかを示す定数
    if (kIsWeb) {
      // Web用の設定を返す
      return web;
    }

    // 各プラットフォームに応じた設定を返す
    // switchは条件分岐で、defaultTargetPlatformの値によって異なる設定を返す
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Android端末の場合はAndroid用の設定を返す
        return android;
      case TargetPlatform.iOS:
        // iOSデバイスの場合はiOS用の設定を返す
        return ios;
      case TargetPlatform.macOS:
        // Mac OSの場合はmacOS用の設定を返す
        return macos;
      case TargetPlatform.windows:
        // Windowsの場合はWindows用の設定を返す
        return windows;
      case TargetPlatform.linux:
        // Linuxプラットフォームが未設定の場合はエラーを投げる
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        // 上記以外のプラットフォームの場合はエラーを投げる
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Web用のFirebase設定オプション
  // constは定数を示し、コンパイル時に値が確定することを意味する
  static const FirebaseOptions web = FirebaseOptions(
    // Firebaseプロジェクトの認証キー（WebアプリのFirebase認証に使用）
    apiKey: 'AIzaSyBfEwP2rAOrTx7Ea6hquvKZrunW7pD6nZ8',
    // アプリのID（Firebase console で作成したアプリの識別子）
    appId: '1:394964116604:web:bea2af972b079fdb4a15f9',
    // Firebase Cloud Messaging（プッシュ通知）の送信者ID
    messagingSenderId: '394964116604',
    // Firebaseプロジェクトの識別子
    projectId: 'fir-memo-app-a9982',
    // Firebase認証のドメイン（ログイン関連の機能で使用）
    authDomain: 'fir-memo-app-a9982.firebaseapp.com',
    // Firebase Storageのバケット名（ファイル保存機能で使用）
    storageBucket: 'fir-memo-app-a9982.firebasestorage.app',
  );

  // Android用のFirebase設定オプション
  static const FirebaseOptions android = FirebaseOptions(
    // Android用のAPIキー
    apiKey: 'AIzaSyA0G8DXMwUn573ol1SP3i6tdV5ELZ-3BYo',
    // Androidアプリ用のアプリID
    appId: '1:394964116604:android:b0276e9e71cb046e4a15f9',
    // Firebase Cloud Messaging用の送信者ID
    messagingSenderId: '394964116604',
    // プロジェクトID
    projectId: 'fir-memo-app-a9982',
    // Storageバケット名
    storageBucket: 'fir-memo-app-a9982.firebasestorage.app',
  );

  // iOS用のFirebase設定オプション
  static const FirebaseOptions ios = FirebaseOptions(
    // iOS用のAPIキー
    apiKey: 'AIzaSyCtoywOfP0SFcsZ5jJXnwRDbQUSEmGwnuY',
    // iOSアプリ用のアプリID
    appId: '1:394964116604:ios:2c7b7ee456294e194a15f9',
    // Firebase Cloud Messaging用の送信者ID
    messagingSenderId: '394964116604',
    // プロジェクトID
    projectId: 'fir-memo-app-a9982',
    // Storageバケット名
    storageBucket: 'fir-memo-app-a9982.firebasestorage.app',
    // iOSアプリのバンドルID（Xcodeで設定したアプリの識別子）
    iosBundleId: 'com.example.memoapp',
  );

  // macOS用のFirebase設定オプション
  static const FirebaseOptions macos = FirebaseOptions(
    // macOS用のAPIキー
    apiKey: 'AIzaSyCtoywOfP0SFcsZ5jJXnwRDbQUSEmGwnuY',
    // macOSアプリ用のアプリID
    appId: '1:394964116604:ios:2c7b7ee456294e194a15f9',
    // Firebase Cloud Messaging用の送信者ID
    messagingSenderId: '394964116604',
    // プロジェクトID
    projectId: 'fir-memo-app-a9982',
    // Storageバケット名
    storageBucket: 'fir-memo-app-a9982.firebasestorage.app',
    // macOSアプリのバンドルID
    iosBundleId: 'com.example.memoapp',
  );

  // Windows用のFirebase設定オプション
  static const FirebaseOptions windows = FirebaseOptions(
    // Windows用のAPIキー
    apiKey: 'AIzaSyBfEwP2rAOrTx7Ea6hquvKZrunW7pD6nZ8',
    // Windowsアプリ用のアプリID
    appId: '1:394964116604:web:9f961460dcdd8cff4a15f9',
    // Firebase Cloud Messaging用の送信者ID
    messagingSenderId: '394964116604',
    // プロジェクトID
    projectId: 'fir-memo-app-a9982',
    // Firebase認証のドメイン
    authDomain: 'fir-memo-app-a9982.firebaseapp.com',
    // Storageバケット名
    storageBucket: 'fir-memo-app-a9982.firebasestorage.app',
  );
}
