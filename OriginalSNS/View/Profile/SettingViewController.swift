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

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
