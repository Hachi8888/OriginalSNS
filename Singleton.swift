//
//  Singleton.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/28.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import Foundation

class LoginStateData {

    /// ログイン状態の保持機能のオンオフを判断するのに使用する。
    /// 偶数: loginState = false(保持しない)
    /// 奇数: loginState = true(保持する)
    var loginState : Bool = false

//    var title: String
//    var contents: String


    init(loginState: Bool) {
        self.loginState = loginState
    }

//    init(title: String, contents: String) {
//        self.title = title
//        self.contents = contents
//    }

}

//
//class Singleton: NSObject {
//
////    var data = Data(loginState: false)
////
////    static let sharedInstance: Singleton = Singleton()
////    private override init() {}
//
////    var data = Data(title: "", contents: "")
////
////    static let sharedInstance: Singleton = Singleton()
////    private override init() {}
//
////    func getLoginState() -> Bool {
////        return data.loginState
////    }
//}




