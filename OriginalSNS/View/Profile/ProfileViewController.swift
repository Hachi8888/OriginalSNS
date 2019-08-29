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
    // いいねの獲得数を表すラベル
    @IBOutlet weak var showGetGoodNumLabel: UILabel!
    // お題を増やすボタンの紐付け(押すと、お題追加画面に遷移)
    @IBOutlet weak var addThemeButton: AnimatableButton!

    // Firestoreをインスタンス化
    let db = Firestore.firestore()
    // お題を増やすボタンを押したかどうかの判定に使う変数
    var didAddTheme: Bool = false

    // PostVCで投稿用に選択した画像を受け取る変数
    var willPostImage: UIImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaultからプロフィ-ル画像、名前、最新のお題を取得、反映
        getInfo()

        // お題を増やすボタンは最初は非表示にしておく
         addThemeButton.isHidden = true

        // お題を増やすボタンを押したかどうか読み込む
        if let currentState = UserDefaults.standard.object(forKey: "didAddTheme") as? Bool {
           didAddTheme = currentState
        }

    }

    // 画面が読み込まれたときの処理
    override func viewDidAppear(_ animated: Bool) {
        // いいね数が10個貯まるごとに、お題を1回増やせるようにする
        // FIXME: 以下の条件式だと、いいねが10個単位でないとボタンが出現しない
        if getGoodNum == 0 || getGoodNum % 10 != 0 {
             // 何もしない
            return
        } else { // いいねが10個単位のとき

            // すでにお題を増やすボタンをおしているか確認
            if didAddTheme { // ボタンをすでに押していたとき
                // お題追加ボタンは隠す
                addThemeButton.isHidden = true
            } else {  // まだボタンを押していないとき
                // お題追加ボタンを表示
                addThemeButton.isHidden = false
                // アラート表示でユーザーにお知らせ
                showAlert()
            }
        }
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


    @IBAction func toPostButton(_ sender: Any) {
        // PostVCへ遷移する
        present(PostViewController.makePostVC(), animated: true)
    }

    // プロフィールボタンを押したとき
    @IBAction func toProfile(_ sender: Any) {
        // FIXME: リロードする or してるようにみせかける
    }

    // UserDefaultに保存している①プロフィール画像、②名前情報、③お題、④いいね獲得数を反映させる関数
    func getInfo() {
        // ①プロフィール画像
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

        // ②名前情報
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // myNameLabelへ代入
            profNameLabel.text = profName
        } else {
            // なければ匿名としておく
            profNameLabel.text = "匿名"
        }

        // ③現在のお題
        if let showCurrentTheme =  UserDefaults.standard.object(forKey: "currentTheme") as? String {
            showThemeTextView.text = showCurrentTheme
        }

        // ④現在のいいね獲得数
        if let goodNum = UserDefaults.standard.object( forKey: "currentGetGoodNum") as? String {
            showGetGoodNumLabel.text = goodNum
            print("現在のいいね数:\(goodNum)")
        } else {
            print("いいね数をUserDefaultから取得失敗")
        }
    }

    // いいねが10個たまるごとにお題追加のボタンができることを知らせる関数
    func showAlert() {
        let alert = UIAlertController(title: "祝", message: "いいねが10個たまりました!\nお題の語句を増やせます!!", preferredStyle: .actionSheet)
        //  OKボタンの設定
        let ok = UIAlertAction(title: "OK", style: .cancel)

        alert.addAction(ok)
        present(alert, animated: true)
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


