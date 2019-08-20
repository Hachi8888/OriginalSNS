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
    var whatList: [String] = ["青色のものを", "黄色のものを", "緑色のものを", "赤色のものを", "つやつやしたものを", "ざらざらしたものを", "トゲトゲしたものを", "丸いものを", "やわらかいものを", "硬いものを", "長いものを", "辛いものを", "甘いものを", "漢字で書いたときに画数の多いものを", "細いものを", "高さがあるものを"]

    // 動詞リスト
    var toDoList: [String] = ["食べる", "触る", "買う", "人に語る", "写真に取る", "街で見つける", "辞書で意味を調べる", "綺麗な字で書く", "全身で表現する"]

    // 【ハードモード】副詞リスト
    var howList: [String] = ["すばやく", "ゆっくりと", "満面の笑みで", "元気よく", "さりげなく", "心をこめて", "無表情で", "おもむろに", "どざくさにまぎれて", "目をつむって", "おおげさに", "息を止めて", "瞬きをせずに", "目をパチパチさせながら", "リズムに乗りながら"]

    override func viewDidLoad() {
        super.viewDidLoad()

        }

    // 【メイン機能】ボタンを押して、WHAT TODO? HOW の3要素を決定
    // FIXME: 関数にまとめる箇所がないかチェック!
    @IBAction func tappedButton(_ sender: UIButton) {

       // ボタンを押したときのカウントを進める
       tapCount += 1
       print(tapCount)

       // WHAT に表示させるものを対象の配列から決定するための乱数を生成
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
            // TO DO? に表示させるものを対象の配列から決定するための乱数を生成
            toDoCount = Int.random(in: 0..<toDoList.count)

            // FIXME: 休憩をはさんだほうが良い?

        case 3:
            // TO DO? を表示する
            toDoLabel.text = toDoList[toDoCount]
            // ボタンの表示を START → STOP へ変更
            sender.setTitle("STOP", for: .normal)
            // HOW に表示させるものを対象の配列から決定するための乱数を生成
            howCount = Int.random(in: 0..<howList.count)

        case 4:
            // HOW を表示
            howLabel.text = howList[howCount]

            // FIXME: ThemeVCへ画面遷移する
            performSegue(withIdentifier: "showTheme", sender: nil)

            // FIXME: 一定期間(例:24時間)はお題を出せないようにする?

        default:
            return
        }
    }

    // segue遷移前準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showTheme" , let vc = segue.destination as? ThemeViewController else {
            print("ThemeVCへの遷移失敗")
            return
        }
        vc.receiveWhat = whatList[whatCount]
        vc.receiveTodo = toDoList[toDoCount]
        vc.receiveHow = howList[howCount]
    }


}




