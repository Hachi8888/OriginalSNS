//
//  SettingViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/23.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseAuth  // ログアウト処理に使用
import FirebaseFirestore // Firebaseへのデータ保存に使用

class SettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // プロフィール画像
    @IBOutlet weak var settingIconImageView: UIImageView!
    // ユーザーネーム
    @IBOutlet weak var settingNameLabel: UITextField!

    // インスタンス化
    let db = Firestore.firestore()

    // Viewが読み込まれたときの処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaultからプロフィール画像と名前の情報を取得する
        getProfile()
    }

    // ImageViewの下にボタンあり。押すとプロフィール画像を設定できる
    @IBAction func settingImageButton(_ sender: Any) {
        // 写真を撮る or ライブラリから選択 のアラートを出す
        showSelectAlert()
    }

    // ログアウトボタン
    @IBAction func logoutButton(_ sender: Any) {
        // ログアウト処理
        try! Auth.auth().signOut()
        // LoginVCへ画面遷移
        self.present(LoginViewController.makeLoginVC(), animated: true)
    }

    // 決定ボタンを押したとき
    @IBAction func registerButton(_ sender: Any) {
        //  名前とプロフィール画像を①UserDefaultと②Firebaseに保存する
        /* Firebaseにもほ情報を保存する理由:タイムラインに戻ったときに、新たに投稿しなくても過去の自分の投稿に対して最新のプロフィール画像と名前が反映されるようにするため
         */
        // ①UserDefaulへの保存
        //  名前ついて
        let userName = settingNameLabel.text
        // 保存
        UserDefaults.standard.set(userName, forKey: "userName")
        print("UserDefaultに名前の保存完了")

        // プロフィール画像について(UIImage型→NSData型→base64String型へ要変換)
        guard let image = settingIconImageView.image else {
            return
        }
        // NSData型の箱を用意
        var data: NSData = NSData()
        // クオリティを10パーセントに下げる
        data = image.jpegData(compressionQuality: 0.1)! as NSData
        // NSData型からbase64String型へ変更
        let base64IconImage = data.base64EncodedString(options: .lineLength64Characters) as String
        // 保存
        UserDefaults.standard.set(base64IconImage, forKey: "iconImage")
        print("UserDefaultへicon画像の保存完了")

        // ②Firebaseへの保存
        let postImage = "プロフィール設定用"
        let comment = "プロフィール設定用"
        // Firestoreに飛ばす箱を用意
        let user: NSDictionary = ["userName": userName ?? "", "iconImage": base64IconImage, "postImage": postImage , "comment": comment]
        // userごとFirestoreへpost
        db.collection("contents").addDocument(data: user as! [String : Any])
        print("Firebaseへ名前とicon画像の保存完了")

    }

    // 画像選択を 写真を撮る or ライブラリ から選択させるアラートを表示
    func showSelectAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 写真を撮るボタンの設定
        let takePhoto = UIAlertAction(title: "写真を撮る", style: .default) { (UIAlertAction) in
            // ボタンを押したときの処理
            // カメラを起動する
            self.cameraAction(sourceType: .camera)
        }

        // ライブラリを開くボタンの設定
        let openLibrary = UIAlertAction(title: "ライブラリから選択", style: .default) { (UIAlertAction) in
            // ボタンを押したときの処理
            // ライブラリを開く
            self.cameraAction(sourceType: .photoLibrary)
        }

        // Cancelボタンの設定
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)

        // 上記で設定した3つのボタンを追加する
        alert.addAction(takePhoto)
        alert.addAction(openLibrary)
        alert.addAction(close)

        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }

    // カメラ・フォトライブラリへの遷移処理
    func cameraAction(sourceType: UIImagePickerController.SourceType) {
        // カメラ・フォトライブラリが使用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            // インスタンス化
            let cameraPicker = UIImagePickerController()
            // ソースタイプの代入
            cameraPicker.sourceType = sourceType
            // デリゲートの接続
            cameraPicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            // 画面遷移
            self.present(cameraPicker, animated: true)
        }
    }

    // 画像が選択された時に自動的に呼ばれる関数
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 取得できた画像情報の存在確認とUIImage型へキャスト。pickedImageという定数に格納
        guard let pickedImage = info[.originalImage] as? UIImage else {
            print("画像選択の失敗")
            return
        }
        // 選択した画像をこの画面(SettingVC)のプロフィール画像に反映
        settingIconImageView.image = pickedImage
        // ピッカーを閉じる
        picker.dismiss(animated: true)
    }

    // UserDefaultに保存しているプロフィール画像と名前情報を反映させる関数
    func getProfile() {
        // 画像情報があればprofImageに格納
        if let profImage = UserDefaults.standard.object(forKey: "iconImage")  {
            // あればprofImageを型変換して投稿用のmyIconImageViewに格納
            // NSData型に変換
            let dataImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decodedImage = UIImage(data: dataImage! as Data)
            // settingIconImageViewに代入
            print("UserDefaultからプロフィール画像を取得")
            settingIconImageView.image = decodedImage
        } else {
//             なければアイコン画像をpsettingIconImageViewに格納
            settingIconImageView.image = #imageLiteral(resourceName: "icons8-male-user-96")
        }
        // 名前情報があればprofNameに格納
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // myNameLabelへ代入
            print("UserDefaultから名前情報を取得")
            settingNameLabel.text = profName
        } else {
            // なければ匿名としておく
            settingNameLabel.text = "匿名"
        }
    }

    // settingNameLabelからフォーカスを外したときにキーボードを閉じる処理
    // タッチされたかを判断
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードが開いていたら
        if (settingNameLabel.isFirstResponder) {
            // 閉じる
            settingNameLabel.resignFirstResponder()
        }
    }

}


