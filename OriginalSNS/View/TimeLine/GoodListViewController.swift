//
//  GoodListViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/27.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class GoodListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // いいねした投稿情報のみ格納(データベースからとってくる)
    var goodListItems = [NSDictionary]()

    // MARK: TableViewCellの表示に関すること
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

        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
