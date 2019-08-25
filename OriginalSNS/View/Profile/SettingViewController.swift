//
//  SettingViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/23.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    // プロフィール画像
    @IBOutlet weak var myIconImageView: UIImageView!
    // ユーザーネーム
    @IBOutlet weak var myNameLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaultからぴプロフィール画像と名前をの情報を取得する
        getProfile()
    }
    

    // ImageViewの下にボタンあり。押すとプロフィール画像を設定できる
    @IBAction func settingImageButton(_ sender: Any) {
        // 写真を撮る or ライブラリから選択 のアラートを出す
        showSelectAlert()
    }


    // 画像選択を 写真を撮る or ライブラリ から選択させるアラートを表示
    func showSelectAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // 写真を撮るボタンの設定
        let takePhoto = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
            // ボタンを押したときの処理
            // カメラを起動する
            self.cameraAction(sourceType: .camera)
        }

        // ライブラリを開くボタンの設定
        let openLibrary = UIAlertAction(title: "Library", style: .default) { (UIAlertAction) in
            // ボタンを押したときの処理
            // ライブラリを開く
            self.cameraAction(sourceType: .photoLibrary)
        }

        // Cancelボタンの設定
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)

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
            print("画像の選択失敗")
            return
        }

        // FIXME: 選択しても表示が変わらない(コンソールにエラーが起きている)
        // 選択した画像をプロフィール画像に設定
        myIconImageView.image = pickedImage

        // 画像をUserDefaultに保存する
        dismiss(animated: true, completion: nil)
    }

    // UserDefaultに保存しているプロフィール画像と名前情報を反映させる関数
    func getProfile() {
        // 画像情報があればprofImageに格納
        if let profImage = UserDefaults.standard.object(forKey: "profileImage")  {
            // あればprofImageを型変換して投稿用のmyIconImageViewに格納
            // NSData型に変換
            let dataImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decodedImage = UIImage(data: dataImage! as Data)
            // profileImageViewに代入
            myIconImageView.image = decodedImage

        } else {
            // FIXME: 初期設定のアイコンを変えること!!
            // なければアイコン画像をprofImageViewに格納
            myIconImageView.image = #imageLiteral(resourceName: "人物(仮)")
        }
        // 名前情報があればprofNameに格納
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // myNameLabelへ代入
            myNameLabel.text = profName
        } else {
            // なければ匿名としておく
            myNameLabel.text = "匿名"
        }
    }
}


