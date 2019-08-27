//
//  TableViewCell.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/25.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import IBAnimatable // アニメーションをつけるライブラリ

// TableViewCellの中の要素に関する処理を書くクラス
class TimeLineTableViewCell: UITableViewCell {

    // プロフィール画像を表示させるImageView
    @IBOutlet weak var timeLineIconImageView: AnimatableImageView!
    // ユーザ名を表示するLabel
    @IBOutlet weak var timeLineNameLabel: UILabel!
    // 投稿した画像を表示させるImageView
    @IBOutlet weak var timeLinePostImageView: AnimatableImageView!
    // 投稿文をのせるTextView
    @IBOutlet weak var timeLineTextView: AnimatableTextView!
    // いいねボタンを紐付け
    @IBOutlet weak var goodButton: AnimatableButton!

   // いいねボタンの切り替えを判断する変数
    var iThinkGood: Bool = false

   // いいねボタンを押したとき
    @IBAction func tappedGoodButton(_ sender: UIButton) {

        if iThinkGood {
            // 背景色を白に戻す
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            iThinkGood = false

            // いいね一覧から削除する
            print("いいね一覧から削除しました")

       } else{
         // いいねをつける
        // 背景色を黄色に変更
        sender.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        iThinkGood = true

        // いいね一覧の箱に追加
        print("いいね一覧に追加しました")

        }




    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



