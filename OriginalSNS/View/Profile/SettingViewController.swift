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
    @IBOutlet weak var settingIconImageView: UIImageView!
    // ユーザーネーム
    @IBOutlet weak var settingNameLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaultからプロフィール画像と名前の情報を取得する
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

        // FIXME: 選択しても表示が変わらない(コンソールにエラーが起きている)
        // 選択した画像をこの画面(SettingVC)のプロフィール画像に反映
        settingIconImageView.image = pickedImage

        // 画像をUserDefaultに保存する(ProfileVC,


        // FIXME: 画面を閉じる(必要? コメントアウトしていても画面閉じた!!)
//        dismiss(animated: true, completion: nil)
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


