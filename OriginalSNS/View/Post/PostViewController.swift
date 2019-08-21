//
//  PostViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/21.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    // 自分のアイコンを表示
    @IBOutlet weak var iconImage: UIImageView!
    // ユーザー名を表示するラベル
    @IBOutlet weak var nameLabel: UILabel!
    // 投稿画像を表示
    @IBOutlet weak var postPhoto: UIImageView!
    // 投稿文を記入するテキストラベル
    @IBOutlet weak var postTextLabel: UITextView!

//    // HomeVCに書いたファイル共通で使うため、インスタンス化
//    let commonFunction = HomeViewController()


    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // ホームボタンを押したときの処理
    // FIXME: 家マークのアイコンをボタンに表示させること
    @IBAction func homeButton(_ sender: Any) {
       // FIXME: ①ではなぜか遷移できない!!
       // HomeVCへ遷移する
       // ①HomeVCのクラスで定義したtransfer()を使用する場合
       // commonFunction.transferVC("Home", "Home")

       // ②このクラス内で定義したtransferVC()を使用する場合
          transferVC("Home", "Home")

    }

    // 投稿(Find!)ボタンを押したときの処理
    @IBAction func postButton(_ sender: Any) {
    }

    // VCを遷移する関数(②)
    func transferVC(_ SBname: String, _ SBIdName: String) {
        // HomeVC画面に遷移する
        // storyboardをHomeのファイルを特定
        let storyboard: UIStoryboard = UIStoryboard(name: SBname, bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: SBIdName)
        // 遷移処理
        present(vc, animated: true)
    }


}



