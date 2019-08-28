//
//  GoodListTableViewCell.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/27.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import IBAnimatable

class GoodListTableViewCell: UITableViewCell {

    // いいねされた投稿を表すための書く要素の紐付け
    // プロフィール画像
    @IBOutlet weak var gooListIconImageView: AnimatableImageView!
    // 名前ラベル
    @IBOutlet weak var goodListNameLabel: UILabel!

    // お題表示ラベル
    @IBOutlet weak var goodListShowTheme: AnimatableLabel!

    // 投稿画像
    @IBOutlet weak var goodListPostImageView: AnimatableImageView!
    // 投稿文
    @IBOutlet weak var goodListTextView: AnimatableTextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
