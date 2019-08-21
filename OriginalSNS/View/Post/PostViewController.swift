//
//  PostViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/21.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    // 自分のアイコンを表示
    @IBOutlet weak var iconImage: UIImageView!
    // ユーザー名を表示するラベル
    @IBOutlet weak var nameLabel: UILabel!
    // 投稿画像を表示
    @IBOutlet weak var postPhoto: UIImageView!
    // 投稿文を記入するテキストラベル
    @IBOutlet weak var postTextLabel: UITextView!

    // HomeVCに書いたファイル共通で使う関数を使用するため、インスタンス化
    let commonFunction = HomeViewController()


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // キャンセルボタンを押したときの処理
    @IBAction func canselButton(_ sender: Any) {
       // HomeVCへ遷移する
        commonFunction.transferVC("Home", "Home")

    }

    // 投稿(Find!)ボタンを押したときの処理
    @IBAction func postButton(_ sender: Any) {

    }

}



