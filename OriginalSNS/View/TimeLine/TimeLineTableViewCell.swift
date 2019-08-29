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
    // いいね獲得数を表すラベル
    @IBOutlet weak var showGoodNumLabel: UILabel!
    // いいねボタンを紐付け
    @IBOutlet weak var goodButton: AnimatableButton!

    var num = 0

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

        // didAddTheme(currentStateでUDから取得)をfalseにして、次にいいね数が10個単位になったときに、お題追加ボタンが出るようにする
        if var currentState: Bool = UserDefaults.standard.object(forKey: "didAddTheme") as? Bool {
            if currentState == true {

            currentState = false
            UserDefaults.standard.set(currentState, forKey: "didAddTheme")
            print("いいね数が更新されたのでdidAddThemeをfalseに戻します!")
            }
        }

        // ユーザーの全投稿に対するいいねの総数を +1 する
        getGoodNum += 1

        // いいねした投稿単体のいいねカウントを+1する
        num += 1
        // String型に変換して表示させる
        let stringNum = String(num)
        showGoodNumLabel.text = stringNum
        // UDに保存させる
        UserDefaults.standard.set(num, forKey: "\(goodButton.tag)")
        print(goodButton.tag)

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
        db.collection("goodContent").addDocument(data: goodList as! [String : Any])

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
        // 各投稿のいいね数をUserDefaultからとってきて反映させる
        if let eachNum: Int = UserDefaults.standard.object(forKey: "\(goodButton.tag)") as? Int {
            num = eachNum
            showGoodNumLabel.text = "\(num)"
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// やむを得ずここで宣言します

// 全体で獲得したいいね数
var getGoodNum: Int = 0
// 獲得したいいね数を投稿順に格納する配列
var eachGoodNumArray:  [Int] = []

