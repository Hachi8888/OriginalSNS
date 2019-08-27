//
//  ThemeViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/20.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ShowThemeViewController: UIViewController {

    // 決まったお題を表示させるラベル
    @IBOutlet weak var themeLabel: UILabel!

    // インスタンス化
    let db = Firestore.firestore()

    // MainVCからsegueで送られたデータを格納する変数3つ
    var receiveWhat: String = ""
    var receiveTodo: String = ""
    var receiveHow: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
     // ラベルにお題を表示
     themeLabel.text = "\n\(receiveWhat)" + "\n\(receiveTodo)" + "\n\(receiveHow)"
    }


    @IBAction func batsuButton(_ sender: UIButton) {

   // お題をFirebaseに保存する
        // Firestoreに飛ばす箱を用意
        let myTheme: NSDictionary = ["what": receiveWhat, "toDo": receiveTodo, "how": receiveHow]
        // userごとFirestoreへpost
        db.collection("themes").addDocument(data: myTheme as! [String : String])
        print("Firebaseへお題の保存完了")


   // ホーム画面へ遷移する
   present(TimeLineViewController.makeTimeLineVC(), animated: true)
        
    }


}
