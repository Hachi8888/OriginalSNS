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
import IBAnimatable // アニメーション

class LoginViewController: UIViewController {
    
    // ロゴのimageView
    @IBOutlet weak var logoImage: AnimatableImageView!
    // email入力欄
    @IBOutlet weak var emailTextField: UITextField!
    // パスワード入力欄
    @IBOutlet weak var passwordTextField: UITextField!
    // ログイン情報保持のイメージ画像を貼るラベル
    @IBOutlet weak var loginStateImageView: UIImageView!
    
    // Firestoreをインスタンス化
    let db = Firestore.firestore()
    
    /// ログイン状態の保持機能のオンオフを判断するのに使用する。
    ///  loginState = false(保持しない)
    ///  loginState = true(保持する)
    var loginState: Bool = false
    
    // 画面が読み込まれたときの処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find!ロゴにアニメーションをつける
        logoImage.animate(.flip(along: .x))
        
        // 最新のloginStateを反映させる
        loginState = UserDefaults.standard.object(forKey: "currentLoginState") as? Bool ?? false
        
        print("ログイン保持:\(loginState) ※trueならログイン保持")
        // ログイン状態を保持する設定(true)の場合、UserDefaultからemailとpasswordの情報を読んで反映させる
        if loginState { // trueのときはログイン情報を保持
            // emailについて反映
            emailTextField.text = UserDefaults.standard.object(forKey: "registeredEmail") as? String
            // passwordについて反映
            passwordTextField.text = UserDefaults.standard.object(forKey: "registeredPassword") as? String
        } else {  // falseのとき、初期化する
            emailTextField.text = ""
            passwordTextField.text = ""
        }
    }
    
    // 新規登録ボタンを押したとき
    @IBAction func createUser(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // 新規アカウント作成
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            // エラーがnilでない = エラーが発生しているとき
            if let error = error { // エラー時の処理
                print("新規登録失敗")
                // エラーアラートの表示
                self.showErrorAlert(error: error)
            } else { // 成功した場合の処理
                print("新規登録成功")
                // ログイン情報を保持
                self.registerLoginInfo()
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
                // ログイン情報を保持
                self.registerLoginInfo()
                // TimeLineVCへ画面遷移(タイムライン画面へ)
                self.present(TimeLineViewController.makeTimeLineVC(), animated: true)
            }
        })
    }
    
    // ログイン状態を保持するかどうか
    @IBAction func tappedLoginStateButton(_ sender: Any) {
        print("押されました")
        // ログイン保持の選択を切り替える
        if loginState {
            loginState = false
            // UserDefaltにloginStateの情報を保存
            UserDefaults.standard.set(loginState, forKey: "currentLoginState")
            // 画像を切替える
            loginStateImageView.image = #imageLiteral(resourceName: "icons8-unchecked-checkbox-24")
            print("「ログイン情報:保持しない」でUserDefaultに保存しました")
        } else {
            loginState = true
            // UserDefaltにloginStateの情報を保存
            UserDefaults.standard.set(loginState, forKey: "currentLoginState")
            loginStateImageView.image = #imageLiteral(resourceName: "icons8-checked-checkbox-48")
            // 画像を切替える
            print("「ログイン情報:保持する」でUserDefaultに保存しました")
            
        }
    }
    
    // emailとpasswoedをFirebaseに保存する
    func registerLoginInfo() {
        let registeredEmail = emailTextField.text
        let registeredPassword = passwordTextField.text
        
        // trueならログイン情報を保持させるためにUserDefaultにemailとpasswordを登録する
        if loginState {
            UserDefaults.standard.set(registeredEmail, forKey: "registeredEmail")
            UserDefaults.standard.set(registeredPassword, forKey: "registeredPassword")
            print("ログイン情報をUserDefaultに保存完了")
        }
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

extension LoginViewController {
    // LoginVCを返す関数(LoginVCへの画面遷移に使う)
    static func makeLoginVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        // LoginVCを返す
        return vc
    }
}
