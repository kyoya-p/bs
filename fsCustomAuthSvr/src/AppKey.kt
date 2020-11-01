package fsCustomAuthSvr

import AesEncriptor.decript

// これは Firestore Settings > サービスアカウント > 新しい秘密鍵を生成 　で取得したjsonを暗号化したもの
val myFirebaseAppKey="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"


fun main(args:Array<String>) {
    println(myFirebaseAppKey.decript(args[0]))
}