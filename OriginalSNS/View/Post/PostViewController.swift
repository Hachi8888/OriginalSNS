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
    @IBOutlet weak var iconImage: UIImageView!
    // ユーザー名を表示するラベル
    @IBOutlet weak var nameLabel: UILabel!

    // 投稿文を記入するテキストラベル
    @IBOutlet weak var postTextLabel: UITextView!


    // 投稿する画像を表示するimageView
    @IBOutlet weak var postImageView: UIImageView!


    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()

        postImageView.isHidden = true

    }


    // ホームボタンを押したとき
    @IBAction func toHomeButton(_ sender: Any) {
        // HomeVCへ画面を遷移する。makeHomeVCはstaticで定義しているので、インスタンス化不要!
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
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




