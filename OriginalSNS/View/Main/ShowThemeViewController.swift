    //
    //  ThemeViewController.swift
    //  OriginalSNS
    //
    //  Created by VERTEX22 on 2019/08/20.
    //  Copyright © 2019 N-project. All rights reserved.
    //

    import UIKit
    import FirebaseFirestore
    import IBAnimatable

    class ShowThemeViewController: UIViewController {

        // 決まったお題を表示させるStackView
        @IBOutlet weak var showThemeStackView: AnimatableStackView!
        // 決まったお題を表示させるラベル
        @IBOutlet weak var themeLabel: UILabel!

        // インスタンス化
        let db = Firestore.firestore()
        // MainVCからsegueで送られたデータを格納する変数3つ
        var receiveWhat: String = ""
        var receiveTodo: String = ""
        var receiveHow: String = ""

        // 画面が読み込まれたときの処理
        override func viewDidLoad() {
            super.viewDidLoad()
            // themeLabelの角を丸くできるようにする
            themeLabel.layer.masksToBounds = true
            // ラベルにお題を表示
            themeLabel.text = "\n\(receiveWhat)" + "\n\(receiveTodo)" + "\n\(receiveHow)"
        }
        
        // チェックボタンを押したときの処理
        @IBAction func batsuButton(_ sender: UIButton) {
            // お題をUserDefaultに保存する
            let currentTheme = "\(receiveWhat)" + "\(receiveTodo)" + "\(receiveHow)"
            UserDefaults.standard.set(currentTheme, forKey: "currentTheme")
            print("UserDefaultに最新のお題の保存完了")
            // FIXME: ↓不要かも。もしくはライブラリを使う。
            // 背景色を緑色に変更する
            sender.backgroundColor = UIColor.green
            // ホーム画面へ遷移する
            present(TimeLineViewController.makeTimeLineVC(), animated: true)
        }
    }
