//
//  ProfileViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/22.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import IBAnimatable
import FirebaseFirestore

class ProfileViewController: UIViewController {

    // プロフィール画像を表示するImageView
    @IBOutlet weak var profIconImageView: UIImageView!
    // ユーザー名を表示するLabel
    @IBOutlet weak var profNameLabel: UILabel!

    // 決定したお題を表示するラベル
    @IBOutlet weak var showThemeTextView: AnimatableTextView!

    // Firestoreをインスタンス化
    let db = Firestore.firestore()

    // PostVCで投稿用に選択した画像を受け取る変数
    var willPostImage: UIImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaultからプロフィ-ル画像、名前、最新のお題を取得、反映
        getProfile()
        fetch()

    }


    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        // タイムライン画面に遷移する
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }
    // ★ボタンを押したとき
    @IBAction func getThemeButton(_ sender: Any) {
        // MainVC:お題決定画面へ遷移
        present(MainViewController.makeMainVC(), animated: true)
    }

    // プロフィールボタンを押したとき
    @IBAction func toProfile(_ sender: Any) {
        // リロードする
    }

    // UserDefaultに保存しているプロフィール画像と名前情報を反映させる関数
    func getProfile() {
        // 画像情報があればprofImageに格納
        if let profImage = UserDefaults.standard.object(forKey: "iconImage") {
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

 // UserDefaultから最新のお題をとってくる
    func fetch() {
        if let showCurrentTheme =  UserDefaults.standard.object(forKey: "currentTheme") as? String {
            showThemeTextView.text = showCurrentTheme
        }
    }

//    // Firebaseからお題のデータを取得
//    func fetch() {
//        // getで全件取得
//        db.collection("themes").getDocuments() {(querySnapshot, err) in
//            // tempThemeという変数を一時的に作成
//            var tempTheme = [NSDictionary]()
//            // for文で回し`item`に格納
//            for theme in querySnapshot!.documents {
//                // item内のデータをdictという変数に入れる
//                let dict = theme.data()
//                // dictをtempItemsに入れる
//                tempTheme.append(dict as NSDictionary)
//            }
//            // tempItemsをitems(クラスの変数として定義した)に入れる
//            self.items = tempTheme
//            // リロード
//            self.tableView.reloadData()
//        }



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
