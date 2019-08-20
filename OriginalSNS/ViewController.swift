//
//  ViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/19.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // 名詞を表示させるラベル
    @IBOutlet weak var subjectLabel: UILabel!
    // 動詞を表示させるラベル
    @IBOutlet weak var verbLabel: UILabel!

    // 各ラベル、ボタンの表示を切り替えるために使用する変数3つ
    var tapCount: Int = 0
    var subjectCount: Int = 0
    var verbCount: Int = 0

    // 名詞ラベルに表示させる語句一覧(語句追加するので、varで)
    var subjectList: [String] = ["青色のものを", "黄色のものを", "緑色のものを", "赤色のものを", "つやつやしたものを", "ざらざらしたものを", "トゲトゲしたものを", "やわらかいものを", "硬いものを", "長いものを", "辛いものを", "甘いものを", "漢字で書いたときに画数の多いものを"]

    // 動詞ラベルに表示させる語句一覧(語句追加するので、varで)
    var verbList: [String] = ["食べる", "触る", "買う", "さりげなく人と話す", "写真に取る", "街で見つける", "辞書で意味を調べる", "綺麗な字で書く"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // 各ラベルのデフォルトの表示を設定
        subjectLabel.text = "WHAT"
        verbLabel.text = "TO DO?"

        }


    // START,STOPボタン
    /// デフォルト値は START で、押すたびに STOP と START の表示が入れ替わる
     // FIXME: 動詞、名詞ごとにボタンをつくること、関数にまとめること

    @IBAction func tappedButton(_ sender: UIButton) {

       // ボタンを押したときのカウントを進める
       tapCount += 1
       print(tapCount)

       // 対象に表示させるものを配列からランダムで選択する
       subjectCount = Int.random(in: 0..<subjectList.count)
       sender.setTitle("STOP", for: .normal)

        switch tapCount {
        case 1:
            // 名詞を決定
            // FIXME: 関数にまとめられる?
            // FIXME: ?? は gifで表現できると楽しいかも
            subjectLabel.text = "??"
            verbLabel.text = "??"

        case 2:
            subjectLabel.text = subjectList[subjectCount]
            sender.setTitle("START", for: .normal)

            verbCount = Int.random(in: 0..<verbList.count)

            // FIXME: 休憩をはさんだほうが良い?

        case 3:
            verbLabel.text = verbList[verbCount]
            sender.setTitle("STOP", for: .normal)

            // FIXME: 動詞ラベルにgifを追加してね

        case 4:
            // FIXME: 1週間ボタンを押せないようにする、画面に決定したお題を表示する、画面をだしてくる?

            tapCount = 0

        default:
            return
        }
    }


}




