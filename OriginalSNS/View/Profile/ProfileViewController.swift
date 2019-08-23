//
//  ProfileViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/22.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // プロフィール画像を表示するImageView
    @IBOutlet weak var profImage: UIImageView!
    // ユーザー名を表示するLabel
    @IBOutlet weak var userNameLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        // タイムラインk画面に遷移する
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }

    // 探すボタンを押したとき
    @IBAction func searchButton(_ sender: Any) {

    }

    // プロフィールボタンを押したとき
    @IBAction func toProfile(_ sender: Any) {
        // リロードする
    }


}

extension ProfileViewController {
    // PostVCを返す関数(PostVCへの画面遷移に使う)
    static func makeProfileVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Profile")
        // PostVCを返す
        return vc
    }
}
