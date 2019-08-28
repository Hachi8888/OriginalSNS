//
//  TableViewCell.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/25.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import IBAnimatable // アニメーションをつけるライブラリ
import FirebaseFirestore // Firebaseへのデータ保存に使用
import FirebaseAuth // ログイン情報

// TableViewCellの中の要素に関する処理を書くクラス
class TimeLineTableViewCell: UITableViewCell {

    // プロフィール画像を表示させるImageView
    @IBOutlet weak var timeLineIconImageView: AnimatableImageView!
    // ユーザ名を表示するLabel
    @IBOutlet weak var timeLineNameLabel: UILabel!
    // 自分のお題を表示させるラベル
    @IBOutlet weak var timeLineShowTheme: AnimatableLabel!
    // 投稿した画像を表示させるImageView
    @IBOutlet weak var timeLinePostImageView: AnimatableImageView!
    // 投稿文をのせるTextView
    @IBOutlet weak var timeLineTextView: AnimatableTextView!
    // いいねボタンを紐付け
    @IBOutlet weak var goodButton: AnimatableButton!

    // Firestoreを使うためにインスタンス化
    let db = Firestore.firestore()
    // いいね獲得数
//    var getGoodNum: Int = 0
    // いいねした投稿情報のみ格納(Firebaseへ送る)
    var goodListItems = [NSDictionary]()

   // いいねボタンを押したとき、いいねリストに追加する。一度つけたいいねは元に戻せない。
    @IBAction func tappedGoodButton(_ sender: UIButton) {
        // 背景色を黄色に変更
        sender.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)

        // いいね数を +1 する
        getGoodNum += 1

        print(goodButton.tag)

        // FIXME: firebaseではなく、UserDefaultに保存のほうがいいかも
        // いいね一覧の箱に追加
        // ①名前
        let goodUserName = timeLineNameLabel.text
        // ②投稿文
        let goodComment = timeLineTextView.text

        // ③投稿画像
            var ImageData: NSData = NSData()
            if let postImage = timeLinePostImageView.image {
                // クオリティを10パーセントに下げる
                ImageData = postImage.jpegData(compressionQuality: 0.1)! as NSData
            }
            // 送信するためにbase64Stringという形式に変換
            let base64PostImage = ImageData.base64EncodedString(options: .lineLength64Characters) as String

        // ④プロフィール画像
            var iconImageData: NSData = NSData()
            if let iconImage = timeLineIconImageView.image {
                iconImageData = iconImage.jpegData(compressionQuality: 0.1)! as NSData
            }
            let base64IconImage = iconImageData.base64EncodedString(options: .lineLength64Characters) as String

       // ⑤お題
            let theme = timeLineShowTheme.text

        // goodListの辞書に①〜⑤を入れる
            let goodList: NSDictionary = ["goodUserName": goodUserName ?? "空です", "goodComment": goodComment ?? "空です", "goodPostImage": base64PostImage, "goodIconImage": base64IconImage, "goodTheme": theme ?? "空です"]

        // firebaseにgoodListの情報を保存する
        db.collection("goodContents").addDocument(data: goodList as! [String : Any])

        print("いいね一覧に追加しました")

        // ログインしているユーザ情報を取得する
        if Auth.auth().currentUser != nil {
            // ログイン中
            print(getGoodNum)
           let stringGetGoodNum = String(getGoodNum)
            // UserDefaultにgetGoodNumを保存
            UserDefaults.standard.set(stringGetGoodNum, forKey: "currentGetGoodNum")
            print("いいね獲得数を+1してUserDefaultに保存しました!\n 現在のいいね獲得数は\(stringGetGoodNum)です")
        } else {
            // ログインしていない
            print("ログイン情報取得できません")
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

// やむを得ずここで宣言します
var getGoodNum: Int = 0

