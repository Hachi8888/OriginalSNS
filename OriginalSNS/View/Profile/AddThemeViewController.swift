//
//  AddThemeViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/29.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class AddThemeViewController: UIViewController {

    // 追加するwhatを入力する
    @IBOutlet weak var addWhatTextField: UITextField!
    // 追加するToDoを入力する
    @IBOutlet weak var addToDoTextField: UITextField!
     // 追加するHowを入力する
    @IBOutlet weak var addHowTextField: UITextField!

    let singleton :Singleton =  Singleton.sharedInstance

    // 値を入れる空の配列を用意
    var currentWhat: [String] = []
    var currentToDo: [String] = []
    var currentHow: [String]  = []

    // Viewが読み込まれたときの処理
    override func viewDidLoad() {
        super.viewDidLoad()

       // 現在登録されている語句を取得し、定数に格納
        currentWhat = singleton.getWhatList()
        currentToDo = singleton.getToDoList()
        currentHow = singleton.getHowList()
    }

    // 決定ボタンを押したとき、お題を追加する
    @IBAction func decideToAddButton(_ sender: Any) {
       // 文字が入力されているか確認
        guard let what: String = addWhatTextField.text, let todo: String = addToDoTextField.text, let how: String = addHowTextField.text else {
            return
        }
        // 3つとも入力しているか確認
        guard what.count != 0 && todo.count != 0 && how.count != 0 else {
            // どれか未入力の場合
            print("入ってないところがあるよ!すべて入力してください")
            showAlert("すべて入力してください!")
            return
        }

        // 3つとも入力されている場合
        // 各語句リストに入力した語句を追加する
        currentWhat.append(what)
        currentToDo.append(todo)
        currentHow.append(how)
        // 現在登録されている語句の配列に入力した語句を加えて新たに配列を作る
        singleton.saveWhatList(whatList: currentWhat)
        singleton.saveToDoList(toDoList: currentToDo)
        singleton.saveHowList(howList: currentHow)
        showAlert("お題の語句が追加されました!")
    }

    // アラートを表示する関数
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        //  OKボタンの設定
        let ok = UIAlertAction(title: "OK", style: .cancel)

         alert.addAction(ok)
        present(alert, animated: true)
    }
}
