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
import XLPagerTabStrip // 横スクロール

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    // TableViewを紐付け
    @IBOutlet weak var tableView: UITableView!
    // 投稿情報をすべて格納(データベースからとってくる)
    var items = [NSDictionary]()
    // Firestoreをインスタンス化
    let db = Firestore.firestore()
    // 更新
    let refreshControl = UIRefreshControl()
    // メニューバーを押したときにメニューを表示させるView
    let menuView = UIView()
    /// menuViewの開閉を決める変数
    /// false: 閉じている、true: 開いている
    var menuViewState = false

    // Viewが開いたとき行う処理
    override func viewDidLoad() {
        super.viewDidLoad()
        //2つのdelegateを追加
        tableView.delegate = self
        tableView.dataSource = self

        // menuViewのサイズを確定
        menuView.frame = CGRect(x: 0, y: 60, width: self.view.frame.width / 2, height: self.view.frame.height)
        // menuViewの背景色を薄いグレーに設定
        menuView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
       // menuViewをViewに追加
        self.view.addSubview(menuView)
        // menuViewは最初に隠す
        menuView.isHidden = true

        // refreshControlのアクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // tableViewに追加
        tableView.addSubview(refreshControl)
    }

    override func viewWillAppear(_ animated: Bool) {
        // FireBaseから最新情報をとってくる
        fetch()
    }

    // メニューボタン(左上)を押したとき
    @IBAction func openMenuViewButton(_ sender: Any) {

        if menuViewState { // trueのとき:メニューが開いている
            // メニューを閉じる
            menuView.isHidden = true
            menuViewState = false
        } else { // falseのとき:メニューが閉じている
            // メニューを開く
            menuView.isHidden = false
            menuViewState = true
        }
    }

    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        /// FIXME: リロードする
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }

    // ★ボタンを押したとき
    @IBAction func getThemeButton(_ sender: Any) {
        // MainVC:お題決定画面へ遷移
        present(MainViewController.makeMainVC(), animated: true)
    }

    // 投稿ボタンを押したとき
    @IBAction func toPostButton(_ sender: Any) {
        // PostVC:投稿画面へ遷移
        present(PostViewController.makePostVC(), animated: true)
    }



    // プロフィールボタンを押したとき
    @IBAction func toProfileButton(_ sender: Any) {
        // ProfileVC:プロフィール設定へ画面遷
        present(ProfileViewController.makeProfileVC(), animated: true)
    }

    // 更新
    @objc func refresh() {
        // 初期化
        items = [NSDictionary]()
        // データをサーバから取得
        fetch()
//        // リロード
        tableView.reloadData()
        // リフレッシュ終了
        refreshControl.endRefreshing()
    }

    // Firebaseからデータを取得
    func fetch() {
        // getで全件取得
        db.collection("contents").getDocuments() {(querySnapshot, err) in
            // tempItemsという変数を一時的に作成
            var tempItems = [NSDictionary]()
            // for文で回し`item`に格納
            for item in querySnapshot!.documents {
                // item内のデータをdictという変数に入れる
                let dict = item.data()
                // dictをtempItemsに入れる
                tempItems.append(dict as NSDictionary)
            }
            // tempItemsをitems(クラスの変数として定義した)に入れる
            self.items = tempItems
            // リロード
            self.tableView.reloadData()
        }
    }

    // MARK: タイムラインの表示に関すること
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
       let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell

        // セルを選択不可にする
        cell.selectionStyle = .none

        // Firebaseからプロフィール画像、ユーザー名、投稿文、投稿画像を取得して反映する
        // まず、itemsの中からindexpathのrow番目を取得するdictを定義
        let dict = items[(indexPath as NSIndexPath).row]

        // 画像情報
        if let profImage = dict["iconImage"] {
            // NSData型に変換
            let dataProfImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decadedProfImage = UIImage(data: dataProfImage! as Data)
            // profileImageViewへ代入
            cell.timeLineIconImageView.image = decadedProfImage
        } else {

            cell.timeLineIconImageView.image = #imageLiteral(resourceName: "icons8-male-user-96")
        }

        // ②名前を反映
        cell.timeLineNameLabel.text = dict["userName"] as? String

//        print(dict["postImage"],dict["userName"],dict["comment"],dict["iconImage"])

        // ③投稿画像を反映
        // 画像情報
        if let postImage = dict["postImage"] {
            // NSData型に変換
            let dataPostImage = NSData(base64Encoded: postImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decadedPostImage = UIImage(data: dataPostImage! as Data)
            // postImageViewへ代入
            cell.timeLinePostImageView.image = decadedPostImage
        } else {
            cell.timeLinePostImageView.image = #imageLiteral(resourceName: "NO IMAGE")
        }

        if let comment = dict["comment"] as? String {
            // ④投稿文を反映
            cell.timeLineTextView.text = comment
        } else {
            cell.timeLineTextView.text = ""
        }

        return cell
    }

    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }


//    // MARK: XLPagerTabStrip導入のための実装
//
//    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        //管理されるViewControllerを返す処理
//        let firstVC = UIStoryboard(name: "TimeLine", bundle: nil).instantiateViewController(withIdentifier: "TimeLine")
//        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main")
//        let thirdVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile")
//        let childViewControllers:[UIViewController] = [firstVC, secondVC, thirdVC]
//        return childViewControllers
// }
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
