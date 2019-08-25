//
//  TableViewCell.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/25.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import IBAnimatable // ボタン、Viewなどのアニメーションをつけるライブラリ

// TableViewCellの中の要素に関する処理を書くクラス
class TimeLineTableViewCell: UITableViewCell {

    // プロフィール画像を表示させるImageView
    @IBOutlet weak var timeLineIconImageView: AnimatableImageView!
    // ユーザ名を表示するLabel
    @IBOutlet weak var timeLineNameLabel: UILabel!

      // 投稿した画像を表示させるImageView
    @IBOutlet weak var timeLinePostImageView: UIImageView!

    @IBOutlet weak var timeLineTextView: UITextView!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



