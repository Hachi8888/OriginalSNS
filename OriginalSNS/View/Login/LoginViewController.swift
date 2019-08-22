//
//  LoginViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/19.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth // ログイン機能

class LoginViewController: UIViewController {

   // ロゴのimageView
    @IBOutlet weak var logoImage: UIImageView!

    // email入力欄
    // FIXME: firebaseでIDで認証できないか
    @IBOutlet weak var emailTextField: UITextField!

    // パスワード入力欄

    @IBOutlet weak var passwordTextField: UITextField!

    // インスタンス化
    let db = Firestore.firestore()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 新規登録ボタン
    @IBAction func createUser(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("新規登録失敗")
            return
        }
        // 新規アカウント作成
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            // エラーがnilでない=エラーが発生しているとき
            if let error = error {
                // エラー時の処理
                print("Firebaseでの新規登録失敗")
                // エラーアラートの表示
                self.showErrorAlert(error: error)
            } else {
                // 成功した場合の処理


            }
        })




    }

    // ログインボタン
    @IBAction func userLogin(_ sender: Any) {

    }



    // エラーが帰ってきた場合のアラート
    func showErrorAlert(error: Error?) {

        let alert = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        // 表示
        self.present(alert, animated: true)
    }

    // ホーム画面への遷移
    func toTimeLine() {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のvcをインスタンス化(ここの"Main"はStoryboardId。"Main"は起動時に設定されています。)
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        // 遷移処理
        self.present(vc, animated: true)
    }


}
