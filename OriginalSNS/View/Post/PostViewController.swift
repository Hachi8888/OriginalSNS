//
//  PostViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/21.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore // Firebaseへのデータ保存に使用

// カメラ、ライブラリを開くので、クラスを2つ追加
class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    // 自分のアイコンを表示
    @IBOutlet weak var postIconImageView: UIImageView!
    // ユーザー名を表示するラベル
    @IBOutlet weak var postNameLabel: UILabel!

    // 投稿文を記入するテキストビュー
    @IBOutlet weak var postTextView: UITextView!

    // お題を表示するラベル
    @IBOutlet weak var postThemeLabel: UILabel!

    // 投稿する画像を表示するimageView
    @IBOutlet weak var postImageView: UIImageView!

   // Firestoreを使うためにインスタンス化
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 投稿画像用のImageViewを隠す
        postImageView.isHidden = true
        // UserDefaultからプロフィ-ル画像と名前情報を取得、反映
        getProfAndTheme()
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
        // Firebaseにプロフィール画像・名前・お題・コメント・投稿画像を送信する
        // ①各情報を定数化 
        // 名前
        let userName = postNameLabel.text
        // コメント(投稿文)
        let comment = postTextView.text
        // お題
        let theme = postThemeLabel.text

        // 投稿画像
        var ImageData: NSData = NSData()
        if let image = postImageView.image {
            // クオリティを10パーセントに下げる
            ImageData = image.jpegData(compressionQuality: 0.1)! as NSData
        }
        // 送信するためにbase64Stringという形式に変換
        let base64PostImage = ImageData.base64EncodedString(options: .lineLength64Characters) as String

        // プロフィール画像
        var iconImageData: NSData = NSData()
        if let iconImage = postIconImageView.image {
            iconImageData = iconImage.jpegData(compressionQuality: 0.1)! as NSData
        }
        let base64IconImage = iconImageData.base64EncodedString(options: .lineLength64Characters) as String

        // ②Firestoreに飛ばす箱を用意
        let user: NSDictionary = ["userName": userName ?? "" , "comment": comment ?? "","theme": theme ?? "", "postImage": base64PostImage, "iconImage": base64IconImage]

        // ③userごとFirestoreへpost
        db.collection("contents").addDocument(data: user as! [String : Any])
        print("firebaseに5つの情報を保管しました!")

        // ④画面を消す
        self.dismiss(animated: true)

    }

    // UserDefaultに保存しているプロフィール画像と名前、最新のお題を反映させる関数
    func getProfAndTheme() {
        // 画像情報があればprofImageに格納
        if let profImage = UserDefaults.standard.object(forKey: "iconImage") {
            // あればprofImageを型変換して投稿用のmyIconImageViewに格納
            // NSData型に変換
            let dataImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decodedImage = UIImage(data: dataImage! as Data)
            // profileImageViewに代入
            postIconImageView.image = decodedImage
        } else {
            // FIXME: 初期設定のアイコンを変えること!!
            // なければアイコン画像をprofImageViewに格納
            postIconImageView.image = #imageLiteral(resourceName: "人物(仮)")
        }

        // 名前情報があればprofNameに格納
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // myNameLabelへ代入
            postNameLabel.text = profName
        } else {
            // なければ匿名としておく
            postNameLabel.text = "匿名"
        }

        // お題情報があればpostThemeに格納
        if let postTheme = UserDefaults.standard.object(forKey: "currentTheme") as? String {
            print(postTheme)
            // postThemeLabelへ代入
            postThemeLabel.text = "お題 : \(postTheme)"
        } else {
            // なければ空白としておく
            postThemeLabel.text = ""
        }
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
        if (postTextView.isFirstResponder) {
            // 閉じる
            postTextView.resignFirstResponder()
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




