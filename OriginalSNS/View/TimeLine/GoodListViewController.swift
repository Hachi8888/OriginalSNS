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


        // FIXME: 処理を書く!!!
        // Firebaseからいいねを押した投稿のプロフィール画像、ユーザー名、投稿文、投稿画像を取得して反映する(コレクション名:goodContentsでFirebaseに保管)
        // まず、goodItemsの中からindexpathのrow番目を取得するdictを定義
        let dict = goodListItems[(indexPath as NSIndexPath).row]

        // ②名前を反映
        cell.goodListNameLabel.text = dict["goodUserName"] as? String


        // ④投稿文を反映
        if let comment = dict["goodComment"] as? String {
            cell.goodListTextView.text = comment
        } else {
            cell.goodListTextView.text = ""
        }


        return cell
    }
}
