//
//  ViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/19.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import IBAnimatable


class MainViewController: UIViewController,UIViewControllerTransitioningDelegate {

    // WHAT: 対象を表示させるラベル
    @IBOutlet weak var whatLabel: AnimatableLabel!

    // TO DO?: 動詞を表示させるラベル
    @IBOutlet weak var toDoLabel: AnimatableLabel!
    // HOW: 形容詞を表示させるラベル
    @IBOutlet weak var howLabel: AnimatableLabel!

    let singleton :Singleton =  Singleton.sharedInstance

    // ボタン、各ラベルの表示を切り替えるために使用する変数4つ
    var tapCount: Int = 0
    var whatCount: Int = 0
    var toDoCount: Int = 0
    var howCount: Int = 0

    /// モード選択を决定する
     ///  false: ノーマルモード,
     ///  true: ハードモード(HOWを追加)
     var selectMode: Bool = false

    // FIXME: データをfirebaseに持たせること
    // 各ラベルに表示させる語句の配列一覧(語句追加するのでvarで宣言)
    // 対象リスト
    var whatList: [String] = []

    // 動詞リスト
    var toDoList: [String] = []

    // 【ハードモード】副詞リスト
    var howList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 最初はノーマルモードなので、HOWの表示画面は隠しておく
        print("ノーマルモードです")
        howLabel.isHidden = true

        whatList = singleton.getWhatList()
        toDoList = singleton.getToDoList()
        howList = singleton.getHowList()

        }

    // MARK: メイン機能:ボタンを押して、WHAT TODO? HOW(ハードモード時のみ) の3要素を決定
    // FIXME: 関数にまとめる箇所がないかチェック!
    @IBAction func tappedButton(_ sender: UIButton) {
       // きボタンをおしたときの共通の処理を各
       // ボタンを押したときのカウントを進める
       tapCount += 1
       print(tapCount)

        switch tapCount {
        case 1: // 1回押したとき
            // 3つのラベルを??に変更
            // FIXME: ?? は gifで表現できると楽しいかも
            whatLabel.text = "??"
            toDoLabel.text = "??"
            howLabel.text = "??"
            // WHAT に表示させるものを対象の配列から決定するための乱数を生成
            whatCount = Int.random(in: 0..<whatList.count)

            // FIXME: 一瞬STOPに変更になったああと、すぐにSTARTに表示をもどしたい
            // ボタンの表示を START → STOP へ変更
            sender.setTitle("STOP", for: .normal)

        case 2: // 2回押したとき
            // WHAT を表示
            whatLabel.text = whatList[whatCount]

            // FIXME: 一瞬STOPに変更になったああと、すぐにSTARTに表示をもどしたい
            // TO DO? に表示させるものを対象の配列から決定するための乱数を生成
            toDoCount = Int.random(in: 0..<toDoList.count)

            // FIXME: 休憩をはさんだほうが良い?

        case 3: // 3回押したとき
            // TO DO? を表示する
            toDoLabel.text = toDoList[toDoCount]

            // ノーマルモードなら、4回押したときにtapCount = 5 にして、お題決定画面へ遷移
            if selectMode == false {
             print("ノーマルモードなのでcase5に飛びます")
             tapCount += 1
             return
            }
            // FIXME: 一瞬STOPに変更になったあと、すぐにSTARTに表示をもどしたい
            // HOW に表示させるものを対象の配列から決定するための乱数を生成
            howCount = Int.random(in: 0..<howList.count)

        case 4: // ハードモードで4回押したとき
            // HOW を表示
            howLabel.text = howList[howCount]

        case 5: // ハードモードで5回押したとき or ノーマルモードで4回押したとき

            // FIXME: ThemeVCへ画面遷移する
            performSegue(withIdentifier: "showTheme", sender: nil)

            // FIXME: 一定期間(例:24時間)はお題を出せないようにする?

        default:
            return
        }
    }

     // segue遷移前準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showTheme" , let vc = segue.destination as? ShowThemeViewController else {
            print("ShowThemeVCへの遷移失敗")
            return
        }
        
        vc.receiveWhat = whatList[whatCount]
        vc.receiveTodo = toDoList[toDoCount]

        if selectMode == false { // ノーマルモード
            print("ノーマルモードなのでHOWの値を空にします")
            vc.receiveHow = ""
        } else {  // ハードモード
        vc.receiveHow = howList[howCount]
        }
    }


    // モード選択用のスイッチ
    @IBAction func selectModeSwitch(_ sender: Any) {

        if selectMode {
            selectMode = false
            showAlert("ノーマルモード")
           // HOWの表示ラベルを隠す
             howLabel.isHidden = true
        } else {
            selectMode = true
            showAlert("ハードモード")
          // HOWの表示ラベルを表示
             howLabel.isHidden = false
        }
    }

    // アラートを表示する関数
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        //  OKボタンの設定
        let ok = UIAlertAction(title: "OK", style: .cancel)

        alert.addAction(ok)
        present(alert, animated: true)
    }

    // MARK: TabBarの処理
    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        // タイムライン画面へ遷移する
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }

    // ★ボタンを押したとき
    @IBAction func getThemeButoon(_ sender: Any) {
    // FIXME: 何も起こらない でよい??
    }

    @IBAction func toPostButton(_ sender: Any) {
        // PodtVCへ画面遷移する
        present(PostViewController.makePostVC(), animated: true)

    }


    // プロフィールボタンを押したとき
    @IBAction func toProfileButoon(_ sender: Any) {
        // ProfileVCへ画面遷移する
        present(ProfileViewController.makeProfileVC(), animated: true)
    }

}

extension MainViewController {
    // PostVCを返す関数(MainVCへの画面遷移に使う)
    static func makeMainVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        // MainVCを返す
        return vc
    }
}





