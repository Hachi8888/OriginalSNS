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

    override func viewDidLoad() {
        super.viewDidLoad()

     themeLabel.layer.masksToBounds = true


     // ラベルにお題を表示
     themeLabel.text = "\n\(receiveWhat)" + "\n\(receiveTodo)" + "\n\(receiveHow)"
    }


    @IBAction func batsuButton(_ sender: UIButton) {


   // お題をUserDefaultに保存する
        let currentTheme = "\(receiveWhat)" + "\(receiveTodo)" + "\(receiveHow)"

   // 保存
    UserDefaults.standard.set(currentTheme, forKey: "currentTheme")
        print("UserDefaultに最新のお題の保存完了")



//   // お題をFirebaseに保存する
//        // Firestoreに飛ばす箱を用意
//        let myTheme: NSDictionary = ["what": receiveWhat, "toDo": receiveTodo, "how": receiveHow]
//        // userごとFirestoreへpost
//        db.collection("themes").addDocument(data: myTheme as! [String : String])
//        print("Firebaseへお題の保存完了")


   // ホーム画面へ遷移する
   present(TimeLineViewController.makeTimeLineVC(), animated: true)
        
    }


}
