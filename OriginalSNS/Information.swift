//
//  Information.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/29.
//  Copyright © 2019 N-project. All rights reserved.
//

import Foundation


class Information {

    var whatList: [String]
    var toDoList: [String]
    var howList: [String]

    init(whatList: [String], toDoList: [String], howList: [String]) {
        self.whatList = whatList
        self.toDoList = toDoList
        self.howList = howList
    }
}

class Singleton: NSObject {
    var data = Information(whatList: ["青色のものを", "黄色のものを", "緑色のものを", "赤色のものを", "つやつやしたものを", "ざらざらしたものを", "トゲトゲしたものを", "丸いものを", "やわらかいものを", "硬いものを", "長いものを", "辛いものを", "甘いものを", "漢字で書いたときに画数の多いものを", "細いものを", "高さがあるものを"], toDoList: ["食べる", "触る", "買う", "人に語る", "写真に取る", "街で見つける", "辞書で意味を調べる", "綺麗な字で書く", "全身で表現する", "題材に一句詠む", "主人公とした物語を調べる", "題材としたエピソードを人に尋ねる"],  howList: ["すばやく", "ゆっくりと", "満面の笑みで", "元気よく", "さりげなく", "心をこめて", "無表情で", "おもむろに", "どざくさにまぎれて", "目をつむって", "おおげさに", "息を止めながら", "瞬きもせずに", "目をパチパチさせながら", "リズムに乗りながら", "大きく振りかぶって", "ただひたすらに", "目に余る勢いで"])

    static let sharedInstance: Singleton = Singleton()
    private override init() {}


    func saveWhatList(whatList: [String]) {
        data.whatList = whatList
    }

    func saveHowList(howList: [String]) {
        data.howList = howList
    }

    func saveToDoList(toDoList: [String]) {
        data.toDoList = toDoList
    }

    func getWhatList() -> [String] {
        return data.whatList

    }

    func getHowList() -> [String] {
        return data.howList
    }

    func getToDoList() -> [String] {
        return data.toDoList
    }
}
