////
////  Singleton.swift
////  OriginalSNS
////
////  Created by VERTEX22 on 2019/08/28.
////  Copyright © 2019 N-project. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//// 各画面共通で使いたいデータ(①ログイン情報保持の選択結果、②)をsingletonで管理する
//
//class CommonData {
//
//    /// ログイン状態の保持機能のオンオフを判断するのに使用する。
//    /// 偶数: loginState = false(保持しない)
//    /// 奇数: loginState = true(保持する)
//    var loginState : Bool = false
//
//
//
//    init(loginState: Bool) {
//        self.loginState = loginState
//    }
//
//
//
//}
//
//import Foundation
//
//
//class Data {
//
//
//    // テキストフィールドに入力した数字を入れる
//    var textFieldNum: Int
//
//    // 現在のポイント
//    var nowPoint: Int
//
//    init(nowPoint: Int, textFieldNum: Int) {
//        self.nowPoint = nowPoint
//        self.textFieldNum = textFieldNum
//    }
//}
//// singleton
//class Singleton: NSObject {
//    var data = Data(nowPoint: 0, textFieldNum: 0)
//    static let shered: Singleton = Singleton()
//    override init() {
//    }
//
//    func saveNowPoint(nowPoint: Int) {
//        data.nowPoint = nowPoint
//    }
//    func saveTextFieldNum(textFieldNum: Int) {
//        data.textFieldNum = textFieldNum
//    }
//
//    func getNowPoint() -> Int {
//        return data.nowPoint
//    }
//    func getTextFieldNum() -> Int {
//        return data.textFieldNum
//    }
//
//}
//
//
//
