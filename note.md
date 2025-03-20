ソースコードを分割したときには対応するincludeが入っているか確認する。

class名を右クリック→シンボルの名前変更で定義部分と参照部分すべて名前変更できる。

buildメソッドの中が表示されているところ
scaffoldで、デザインする領域を作ってくれる。
この中で、Appbarとか、Body、FloatingAction Buttonとかを設定できる。


Memo({})の中
required：必須

型名のあとに?をつける：nullもしくは、その型の値が入っていればOK

Flutterfireの初期設定
https://firebase.flutter.dev/docs/overview


もし、Androidでテストする際にkotlinのエラーが出たら：
android/app/build.gradleファイルに以下の設定を追加してください：
// ... existing code ...
android {
    // ... existing code ...
    
    configurations {
        all*.exclude group: 'org.jetbrains.kotlin', module: 'kotlin-stdlib-jdk7'
        all*.exclude group: 'org.jetbrains.kotlin', module: 'kotlin-stdlib-jdk8'
    }
}
// ... existing code ...
↑この変更で、重複するKotlinライブラリを除外し、プロジェクト全体で使用するKotlinバージョンを統一できる。
上記変更後、以下を実行：
flutter clean
flutter pub get
flutter run

画面遷移するには、Navigator Pushを使う。
第二引数に遷移先を指定してあげる。

wrap is columnをしてあげるとcolumm内に入れてあげることが出来る。
　Column:縦にテキストを並べてあげたい。

Navigator.pop(context); ：　一個↑に乗っかっているページを取り除く

createMemo(); Future型
Navigator.pop(context);
→　Future型の処理が終わる前にpopをしてしまい、画面が変わったあとに実行される可能性がある。
→　awaitをつける

QuerySnapshot：変更されたときにstreamが検知してくれる。

final docs = snapshot.data!.docs;の!マーク：nullの場合はありえん

SafeArea：ホームに戻るバーと、メニューが被らないようになる。

聞きたいときのプロンプト：
　各行ごとに何をしているか、どういう仕組でこの処理が成り立っているのかを具体的に説明してください。
