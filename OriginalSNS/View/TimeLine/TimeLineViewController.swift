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

    // 更新
    let refreshControl = UIRefreshControl()

    // Viewが開いたとき行う処理
    override func viewDidLoad() {
        super.viewDidLoad()
        //2つのdelegateを追加
        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.register(UINib(nibName: "TimeLineTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        // アクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // tableViewに追加
        tableView.addSubview(refreshControl)


    }

    override func viewWillAppear(_ animated: Bool) {
        // FireBaseから最新情報をとってくる
        fetch()
    }

    override func viewDidLayoutSubviews() {
        // FIXME: お題画面への遷移ボタンの画像の位置について見直すこと!!
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

    // 更新
    @objc func refresh() {
        // 初期化
        items = [NSDictionary]()
        // データをサーバから取得
        fetch()
        // リロード
        tableView.reloadData()
        // リフレッシュ終了
        refreshControl.endRefreshing()
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

    // FIXME: リロードの処理で落ちる。。
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
//            self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimeLineTableViewCell

        // セルを選択不可にする
        cell.selectionStyle = .none

        // Firebaseからぷプロフィール画像、ユーザー名、投稿文、投稿画像を取得して反映する
//        cell.timeLineIconImageView.image = items["iconImage"][indexPath.row] as? UIImage
//

//        cell.fromLabel.text = likedFrom[indexPath.row]
//        cell.xibImage.image = UIImage(named: likedName[indexPath.row])






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
