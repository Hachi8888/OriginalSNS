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

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // ホームボタンを押したときの処理
    // FIXME: 家マークのアイコンをボタンに表示させること
    @IBAction func homeButton(_ sender: Any) {
        present(HomeViewController.makeHomeVC(), animated: true)
    }

    // 投稿(Find!)ボタンを押したときの処理
    @IBAction func postButton(_ sender: Any) {
    }




}



