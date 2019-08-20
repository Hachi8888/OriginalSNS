//
//  ViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/19.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    // WHAT: 対象を表示させるラベル
    @IBOutlet weak var whatLabel: UILabel!
    // TO DO?: 動詞を表示させるラベル
    @IBOutlet weak var toDoLabel: UILabel!
    // HOW: 形容詞を表示させるラベル
    @IBOutlet weak var howLabel: UILabel!

    // ボタン、各ラベルの表示を切り替えるために使用する変数4つ
    var tapCount: Int = 0
    var whatCount: Int = 0
    var toDoCount: Int = 0
    var howCount: Int = 0

    // 各ラベルに表示させる語句の配列一覧(語句追加するのでvarで宣言)
    // 対象リスト
    var whatList: [String] = ["青色のものを", "黄色のものを", "緑色のものを", "赤色のものを", "つやつやしたものを", "ざらざらしたものを", "トゲトゲしたものを", "やわらかいものを", "硬いものを", "長いものを", "辛いものを", "甘いものを", "漢字で書いたときに画数の多いものを", "細いものを", "高さがあるものを"]

    // 動詞リスト
    var toDoList: [String] = ["食べる", "触る", "買う", "人と話す", "写真に取る", "街で見つける", "辞書で意味を調べる", "綺麗な字で書く"]

    // 【追加機能】副詞リスト
    var howList: [String] = ["すばやく", "ゆっくりと", "笑顔で", "元気よく", "さりげなく", "心をこめて", "無表情で", "おもむろに", "どざくさにまぎれて", "目をつむって", "おおげさに"]

    override func viewDidLoad() {
        super.viewDidLoad()

        }

    // 【メイン機能】ボタンを押して、WHAT TODO? HOW の3要素を決定
    // FIXME: 関数にまとめる箇所がないかチェック!
    @IBAction func tappedButton(_ sender: UIButton) {

       // ボタンを押したときのカウントを進める
       tapCount += 1
       print(tapCount)

       // WHAT に表示させるものを対象の配列からランダムで決定
       whatCount = Int.random(in: 0..<whatList.count)

       // ボタンの表示を START → STOP へ変更
       sender.setTitle("STOP", for: .normal)

        switch tapCount {
        case 1:
            // 3つのラベルを??に変更
            // FIXME: ?? は gifで表現できると楽しいかも
            whatLabel.text = "??"
            toDoLabel.text = "??"
            howLabel.text = "??"

        case 2:
            // WHAT を表示
            whatLabel.text = whatList[whatCount]
            // ボタンの表示を STOP → START へ変更
            sender.setTitle("START", for: .normal)
            // TO DO? に表示させるものを対象の配列からランダムで決定
            toDoCount = Int.random(in: 0..<toDoList.count)

            // FIXME: 休憩をはさんだほうが良い?

        case 3:
            // TO DO? を表示する
            toDoLabel.text = toDoList[toDoCount]
            // ボタンの表示を START → STOP へ変更
            sender.setTitle("STOP", for: .normal)
            // HOW に表示させるものを対象の配列からランダムで決定
            howCount = Int.random(in: 0..<howList.count)

        case 4:
            // HOW を表示
            howLabel.text = howList[howCount]

            // FIXME: 画面に決定したお題を表示する、画面をだしてくる?

            // FIXME: 一定期間(例:24時間)はお題を出せないようにする?
            // 表示をもとに戻す
            tapCount = 0

        default:
            return
        }
    }


}




