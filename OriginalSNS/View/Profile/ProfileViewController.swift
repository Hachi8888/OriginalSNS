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
    @IBOutlet weak var profIconImageView: UIImageView!
    // ユーザー名を表示するLabel
    @IBOutlet weak var profNameLabel: UILabel!

    // PostVCで投稿用に選択した画像を受け取る変数
    var willPostImage: UIImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
//        // SettingVCで選択したProfile画像を表示させる
//        profImage.image = willPostImage

        // UserDefaultからプロフィ-ル画像と名前情報を取得、反映
        getProfile()

    }

    // settingボタンを押したとき
    @IBAction func settingButton(_ sender: Any) {
        // SettingVC:プロフィール画像とユーザー名の設定画面に遷移
     performSegue(withIdentifier: "toSettingVC"
        , sender: nil)

    }

    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        // タイムライン画面に遷移する
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }

    // 探すボタンを押したとき
    @IBAction func searchButton(_ sender: Any) {
    }

    // プロフィールボタンを押したとき
    @IBAction func toProfile(_ sender: Any) {
        // リロードする
    }


    // UserDefaultに保存しているプロフィール画像と名前情報を反映させる関数
    func getProfile() {
        // 画像情報があればprofImageに格納
        if let profImage = UserDefaults.standard.object(forKey: "profileImage")  {
            // あればprofImageを型変換して投稿用のmyIconImageViewに格納
            // NSData型に変換
            let dataImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decodedImage = UIImage(data: dataImage! as Data)
            // profileImageViewに代入
            profIconImageView.image = decodedImage
        } else {
            // FIXME: 初期設定のアイコンを変えること!!
            // なければアイコン画像をprofImageViewに格納
            profIconImageView.image = #imageLiteral(resourceName: "人物(仮)")
        }
        // 名前情報があればprofNameに格納
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // myNameLabelへ代入
            profNameLabel.text = profName
        } else {
            // なければ匿名としておく
            profNameLabel.text = "匿名"
        }
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
