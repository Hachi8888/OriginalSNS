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

    var currentWhat: [String] = []
    var currentToDo: [String] = []
    var currentHow: [String]  = []

    var addedWhat: [String] = []
    var addedTodo: [String] = []
    var addedHow: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

       // 現在登録されている語句を取得し、定数に格納
        currentWhat = singleton.getWhatList()
        currentToDo = singleton.getToDoList()
        currentHow = singleton.getHowList()

//        singleton.getWhatList()
//        singleton.getToDoList()
//        singleton.getHowList()
    }

    // 決定ボタンを押したとき
    @IBAction func decideToAddButton(_ sender: Any) {

        guard let what: String = addWhatTextField.text, let todo: String = addToDoTextField.text, let how: String = addHowTextField.text else {
            return
        }

        guard what.count != 0 && todo.count != 0 && how.count != 0 else {
            print("入ってないところがあるよ")
            return
        }

        currentWhat.append(what)
        currentToDo.append(todo)
        currentHow.append(how)


        // 現在登録されている語句の配列に入力した語句を加えて新たに配列を作る


        singleton.saveWhatList(whatList: currentWhat)
        singleton.saveToDoList(toDoList: currentToDo)
        singleton.saveHowList(howList: currentHow)


    }




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
