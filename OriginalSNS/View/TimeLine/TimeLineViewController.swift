//
//  TimeLineViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/22.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore
import IBAnimatable


class TimeLineViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {

    // TableViewを紐付け
    @IBOutlet weak var tableView: UITableView!



    // FIXME: 必要か不明。ここに決まったお題を表示する?
    // Find!ボタン
    @IBOutlet weak var findImageButton: UIButton!


    // 投稿情報をすべて格納(データベースからとってくる)
    var items = [NSDictionary]()

    // Firestoreをインスタンス化
    let db = Firestore.firestore()

    // Viewが開いたとき行う処理
    override func viewDidLoad() {
        super.viewDidLoad()
        //2つのdelegateを追加
        tableView.delegate = self
        tableView.dataSource = self

        // FIXME: ProfileVCから設定してあるプロフィール画像と名前情報を取得して反映できない!!
//        getProfile()

    }


    override func viewDidLayoutSubviews() {

        findImageButton.imageView?.contentMode = .scaleToFill
        //        findImageButton.contentHorizontalAlignment = .fill
        findImageButton.contentVerticalAlignment = .fill


    }

    // 投稿ボタンを押したとき
    @IBAction func toPostButton(_ sender: Any) {
        // PostVC:投稿画面へ遷移
        present(PostViewController.makePostVC(), animated: true)
    }

    // Find!ボタンを押したとき
    @IBAction func toMainButton(_ sender: Any) {
        // MainVC:お題決定画面へ遷移
        present(MainViewController.makeMainVC(), animated: true)
    }

    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        /// FIXME: リロードする
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }


    @IBAction func searchButton(_ sender: Any) {
        /// FIXME: キーワード検索でひっかかった投稿をタイムラインに表示させる
    }

    // プロフィールボタンを押したとき
    @IBAction func toProfileButton(_ sender: Any) {
        // ProfileVC:プロフィール設定へ画面遷
        present(ProfileViewController.makeProfileVC(), animated: true)
    }

    // UserDefaultに保存しているプロフィール画像と名前情報を反映させる関数
    func getProfile() {

        // 画像情報があればprofImageに格納
        if let profImage = UserDefaults.standard.object(forKey: "iconImage")  {
            // あればprofImageを型変換して投稿用のtimeLineIconImageViewに格納
            // まずNSData型に変換
            let dataImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decodedImage = UIImage(data: dataImage! as Data)
            // FIXME: TimeLineTableViewCellの要素の指定方法が変??
            // profileImageViewに代入
            TimeLineTableViewCell()
                .timeLineIconImageView.image = decodedImage
        } else {
            // FIXME: 初期設定のアイコンを変えること!!
            // なければアイコン画像をprofImageViewに格納
            TimeLineTableViewCell().timeLineIconImageView.image = #imageLiteral(resourceName: "人物(仮)")
        }
        // 名前情報があればprofNameに格納
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // myNameLabelへ代入
            TimeLineTableViewCell().timeLineNameLabel.text = profName
        } else {
            // なければ匿名としておく
            TimeLineTableViewCell().timeLineNameLabel.text = "匿名"
        }
    }




    // タイムラインの表示に関すること
    // セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // セクションの中のセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 投稿情報の数に設定する
        return items.count
    }

    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // セルを選択不可にする
        cell.selectionStyle = .none

        return cell
    }

    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension TimeLineViewController {
    // TimeLineVCを返す関数(TimeLineVCへの画面遷移に使う)
    static func makeTimeLineVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "TimeLine", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "TimeLine")
        // TimeLineVCを返す
        return vc
    }
}
