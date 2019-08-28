//
//  GoodListViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/27.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore

class GoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // tableViewを紐付け
    @IBOutlet weak var tableView: UITableView!
    // いいねした投稿情報のみ格納(Firebaseからとってくる)
    var goodListItems = [NSDictionary]()

    // Firestoreをインスタンス化
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        // FireBaseから最新情報をとってくる
        fetch()
    }

    // Firebaseからデータを取得
    func fetch() {
        // getで全件取得
        db.collection("goodContents").getDocuments() {(querySnapshot, err) in
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
            self.goodListItems = tempItems

            print(tempItems)
            // リロード
            self.tableView.reloadData()
        }
    }


    // セクションの中のセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 投稿情報の数に設定
        return goodListItems.count
    }

     // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoodListTableViewCell", for: indexPath) as! GoodListTableViewCell

        // セルを選択不可にする
        cell.selectionStyle = .none

        print(goodListItems.count)

        // Firebaseからいいねを押した投稿のプロフィール画像、ユーザー名、投稿文、投稿画像、お題を取得して反映する(コレクション名:goodContentsでFirebaseに保管)
        // まず、goodItemsの中からindexpathのrow番目を取得するdictを定義
        let dict = goodListItems[(indexPath as NSIndexPath).row]

        // ①プロフィール画像情報
        if let profImage = dict["goodIconImage"] {
            // NSData型に変換
            let dataProfImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decadedProfImage = UIImage(data: dataProfImage! as Data)
            // gooListIconImageViewへ代入
            cell.goodListIconImageView.image = decadedProfImage
        } else {

            cell.goodListIconImageView.image = #imageLiteral(resourceName: "icons8-male-user-96")
        }

        // ②名前を反映
        cell.goodListNameLabel.text = dict["goodUserName"] as? String

        // ③投稿画像を反映
        if let postImage = dict["goodPostImage"] {
            // NSData型に変換
            let dataPostImage = NSData(base64Encoded: postImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decadedPostImage = UIImage(data: dataPostImage! as Data)
            // postImageViewへ代入
            cell.goodListPostImageView.image = decadedPostImage
        } else {
            cell.goodListPostImageView.image = #imageLiteral(resourceName: "NO IMAGE")
        }

        // ④投稿文を反映
        if let comment = dict["goodComment"] as? String {
            cell.goodListTextView.text = comment
        } else {
            cell.goodListTextView.text = ""
        }

        // ⑤お題を表示
        if let theme = dict["goodTheme"] as? String {
            cell.goodListShowTheme.text = theme
        } else {
            cell.goodListShowTheme.text = ""
        }

        return cell
    }
}
