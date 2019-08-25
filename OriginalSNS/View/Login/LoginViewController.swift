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
    @IBOutlet weak var emailTextField: UITextField!
    // パスワード入力欄
    @IBOutlet weak var passwordTextField: UITextField!

    // インスタンス化
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 新規登録ボタンを押したおとき
    @IBAction func createUser(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // 新規アカウント作成
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            // エラーがnilでない=エラーが発生しているとき
            if let error = error { // エラー時の処理
                print("新規登録失敗")
                // エラーアラートの表示
                self.showErrorAlert(error: error)
            } else { // 成功した場合の処理
                print("新規登録成功")
                // TimeLineVCへ画面遷移(タイムライン画面へ)
                self.present(TimeLineViewController.makeTimeLineVC(), animated: true)
            }
        })
    }

    // ログインボタンを押したとき
    @IBAction func userLogin(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // FirebaseAuthのログイン処理
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("ログイン失敗")
                // エラーアラートの表示
                self.showErrorAlert(error: error)
            } else {  // 認証成功
                print("ログイン成功")
                // TimeLineVCへ画面遷移(タイムライン画面へ)
                self.present(TimeLineViewController.makeTimeLineVC(), animated: true)
            }
        })
    }

    // エラーが返ってきた場合のアラート
    func showErrorAlert(error: Error?) {
        let alert = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        // 表示
        self.present(alert, animated: true)
    }

    // キーボードを閉じる処理
    // タッチされたかを判断
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードが開いていたら
        if (emailTextField.isFirstResponder) {
            // 閉じる
            emailTextField.resignFirstResponder()
        }
        if (passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        }
    }
}
