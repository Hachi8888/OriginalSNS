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


    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        // HomeVCへ画面を遷移する。makeHomeVCはstaticで定義しているので、インスタンス化不要!
        present(HomeViewController.makeHomeVC(), animated: true)
    }


    // 検索ボタンを押したとき
    @IBAction func SearchButton(_ sender: Any) {

    }

   // プロフィールボタンを押したとき
    @IBAction func toProfileButoon(_ sender: Any) {
        
    }

    // 投稿(Find!)ボタンを押したときの処理
    @IBAction func postButton(_ sender: Any) {

    }

}

extension PostViewController {
    // PostVCを返す関数(PostVCへの画面遷移に使う)
    static func makePostVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Post", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Post")
        // PostVCを返す
        return vc
    }
}




