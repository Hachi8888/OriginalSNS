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
    @IBOutlet weak var nounLabel: UILabel!
    // 動詞を表示させるラベル
    @IBOutlet weak var verbLabel: UILabel!

    // ボタンの表示を切り替えるために使用
    var tapCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // 各ラベルのデフォルトの表示を設定
        nounLabel.text = "WHAT"
        verbLabel.text = "TO DO?"

        }


    // START,STOPボタン
    /// デフォルト値は START で、押すたびに STOP と START の表示が入れ替わる
     // FIXME: 動詞、名詞ごとにボタンをつくること、関数にまとめること

    @IBAction func tappedButton(_ sender: UIButton) {


       tapCount += 1
       print(tapCount)

        switch tapCount {
        case 1:
            // FIXME: 関数にまとめたい!!
            // FIXME: ラベルの表示内容は仮です
            nounLabel.text = "1"
            verbLabel.text = ""
            sender.setTitle("STOP", for: .normal)

        case 2:
            nounLabel.text = "2"
            verbLabel.text = ""
            sender.setTitle("START", for: .normal)

        case 3:
            nounLabel.text = "3"
            verbLabel.text = ""
            sender.setTitle("STOP", for: .normal)

        case 4:
            nounLabel.text = "4"
            verbLabel.text = ""
            // FIXME: 1週間ボタンを押せないようにする、画面に決定したお題を表示する
        default:
            return
        }
    }


}




