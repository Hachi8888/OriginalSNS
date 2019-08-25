//
//  PostViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/21.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore

// カメラ、ライブラリを開くので、クラスを2つ追加
class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    // 自分のアイコンを表示
    @IBOutlet weak var postIconImageView: UIImageView!
    // ユーザー名を表示するラベル
    @IBOutlet weak var postNameLabel: UILabel!

    // 投稿文を記入するテキストラベル
    @IBOutlet weak var postTextLabel: UITextView!
    // 投稿する画像を表示するimageView
    @IBOutlet weak var postImageView: UIImageView!


    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()

        postImageView.isHidden = true

    }


    // イメージボタンを押したとき
    @IBAction func selectImageButton(_ sender: Any) {
        // ライブラリを開く
        cameraAction(sourceType: .photoLibrary)
    }

    // カメラボタンを押したとき
    @IBAction func selectCameraButton(_ sender: Any) {
        // カメラを起動する
        cameraAction(sourceType: .camera)
    }


    // キャンセルボタンを押したとき
    @IBAction func cancelButton(_ sender: Any) {
        // postVCを破棄してTimeLineVCへ戻る
        dismiss(animated: true, completion: nil)
    }


    // 投稿(Find!)ボタンを押したときの処理
    @IBAction func postButton(_ sender: Any) {
        // ①各情報を定数化
        // 投稿する情報は４つ。名前・コメント・投稿画像・プロフィール画像
        // FIXME: 名前もfirebaseにぽpostする必要ある?
        let userName = postNameLabel.text
        // コメント(投稿文)
        let comment = postTextLabel.text

        // 投稿画像
        var postImageData: NSData = NSData()
        if let postImage = postImageView.image {
            // クオリティを10パーセントに下げる
            postImageData = postImage.jpegData(compressionQuality: 0.1)! as NSData
        }
        // 送信するためにbase64Stringという形式に変換
        let base64PostImage = postImageData.base64EncodedString(options: .lineLength64Characters) as String

        // FIXME: プロフィール画像(firebaseに送る必要ある?)
        var profileImageData: NSData = NSData()
        if let profileImage = postIconImageView.image {
            profileImageData = profileImage.jpegData(compressionQuality: 0.1)! as NSData
        }
        let base64ProfileImage = profileImageData.base64EncodedString(options: .lineLength64Characters) as String

        // ②Firestoreに飛ばす箱を用意
        let user: NSDictionary = ["userName": userName ?? "" , "comment": comment ?? "", "postImage": base64PostImage, "profileImage": base64ProfileImage]

        // ③userごとFirestoreへpost
        db.collection("contents").addDocument(data: user as! [String : Any])

        // ④画面を消す
        self.dismiss(animated: true)


    }

    // FIXME: ProfileVCのsettingでも以下処理を使用。staticでまとめられないか?
    // カメラ・フォトライブラリへの遷移処理
    func cameraAction(sourceType: UIImagePickerController.SourceType) {
        // カメラ・フォトライブラリが使用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            // インスタンス化
            let cameraPicker = UIImagePickerController()
            // ソースタイプの代入
            cameraPicker.sourceType = sourceType
            // デリゲートの接続
            cameraPicker.delegate = self
            // 画面遷移
            self.present(cameraPicker, animated: true)
        }
    }

    // 画像が選択された時に自動的に呼ばれる関数
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 取得できた画像情報の存在確認とUIImage型へキャスト。pickedImageという定数に格納
        guard let pickedImage = info[.originalImage] as? UIImage else {
            print("画像の選択失敗")
            return
        }
        postImageView.isHidden = false
        postImageView.image = pickedImage


        // 元の画面に戻る
        dismiss(animated: true, completion: nil)
    }

    // キーボードを閉じる処理
    // タッチされたかを判断
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードが開いていたら
        if (postTextLabel.isFirstResponder) {
            // 閉じる
            postTextLabel.resignFirstResponder()
        }
    }
}

extension PostViewController {
    // PostVCを返す関数(PostVCへの画面遷移に使う)
    static func makePostVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Post", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Post")
        // PostVCを返す
        return vc
    }
}




