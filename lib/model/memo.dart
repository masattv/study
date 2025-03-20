// Firebaseのデータベース（Firestore）から取得したデータを扱うためのパッケージをインポート
// このパッケージには、FirestoreのTimestamp型などが含まれている
import 'package:cloud_firestore/cloud_firestore.dart';

// メモのデータを表現するためのモデルクラス
// モデルクラスとは、アプリケーションで扱うデータの構造と形式を定義するクラス
// このクラスによって、Firestoreから取得したデータをDartオブジェクトとして扱える
class Memo {
  // メモの一意な識別子（FirestoreのドキュメントID）
  // このIDによって、特定のメモをデータベースから検索・更新・削除できる
  String id;

  // メモのタイトル（見出し）
  String title;

  // メモの詳細な内容（本文）
  String detail;

  // メモの作成日時（Firestoreのタイムスタンプ型）
  // Timestampは、日時を秒とナノ秒で表現するFirebase特有の型
  Timestamp createdDate;

  // メモの更新日時（存在しない場合はnull）
  // ?はこのフィールドがnullable（値がない状態を許容する）であることを示す
  // 新規作成時は更新日時がないため、nullableな型として定義
  Timestamp? updatedDate;

  // Memoクラスのコンストラクタ（新しいMemoオブジェクトを生成するための関数）
  // {}で囲まれた部分は名前付き引数で、呼び出し時に引数の順序を気にせず指定できる
  Memo(
      // requiredキーワードは、このパラメータが必須であることを示す
      // この場合、id、title、detail、createdDateは必ず指定する必要がある
      {required this.id,
      required this.title,
      required this.detail,
      required this.createdDate,
      // updatedDateは必須でないため、requiredキーワードがない
      // 指定されなければnullになる
      this.updatedDate});
}
