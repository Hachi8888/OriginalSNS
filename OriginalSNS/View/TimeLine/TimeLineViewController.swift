//
//  TimeLineViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/22.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import FirebaseFirestore
import IBAnimatable
import NVActivityIndicatorView // インジゲータ

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    // TableViewを紐付け
    @IBOutlet weak var tableView: UITableView!
    // 投稿情報をすべて格納(Firebaseからとってくる)
    var items = [NSDictionary]()
    // Firestoreをインスタンス化
    let db = Firestore.firestore()
    // 更新
    let refreshControl = UIRefreshControl()
    
    // ロード中のインジゲータを取得
    private var activityIndicator: NVActivityIndicatorView!
    // toTimeLineButtonを押したときインジケータの背景として表示させるView
    let grayView = UIView()
    
    // Viewが開いたとき行う処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FIXME: 下二つはなくても自動的に幅が決まってくれているが、いる？
        //セルの高さの初期設定
        tableView.estimatedRowHeight = 250
        // セルの高さを自動設定
        tableView.rowHeight = UITableView.automaticDimension
        
        // tableBarの2つのdelegateを追加
        tableView.delegate = self
        tableView.dataSource = self
        
        // tabBerのデリゲート接続
        tabBar.delegate = self
        
        // FireBaseから最新情報をとってくる
        fetch()
        
        // インジケータの背景:grayView:grayViewの設定
        // grayViewのサイズを確定
        grayView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        // grayViewの背景色を薄いグレーに設定
        grayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        // grayViewをViewに追加
        self.view.addSubview(grayView)
        // grayViewは最初に隠す
        grayView.isHidden = true
        
        // refreshControlのアクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // tableViewに追加
        tableView.addSubview(refreshControl)
    }
    
    
    // tabbarに関する紐付け
    @IBOutlet weak var toTimeLineBar: UITabBarItem!
    @IBOutlet weak var toPostBar: UITabBarItem!
    @IBOutlet weak var toMyPageBar: UITabBarItem!
    @IBOutlet weak var getThemeTab: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    // tabbarを押したとき
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag{
        case 1 :
            // リロード
            tableView.reloadData()
            // grayViewを表示
            grayView.isHidden = false
            // インジケータの追加
            activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25), type: NVActivityIndicatorType.ballClipRotate, color: #colorLiteral(red: 0.9907757402, green: 1, blue: 0.9234979383, alpha: 1), padding: 0)
            // 位置を中心に設定
            activityIndicator.center = self.grayView.center
            grayView.addSubview(activityIndicator)
            
            // インジケータを表示
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            // 1.5秒後にインジケータを終了させる
            perform(#selector(delay), with: nil, afterDelay: 1.5)
            
        case 2 :
            // MainVC:お題決定画面へ遷移
            present(MainViewController.makeMainVC(), animated: true)
        case 3 :
            // PostVCへ遷移する
            present(PostViewController.makePostVC(), animated: true)
            
        case 4 :
            // ProfileVC:プロフィール設定へ画面遷
            present(ProfileViewController.makeProfileVC(), animated: true)
            
        default :
            return
        }
        
    }
    
    @objc func delay() {
        // インジケータ終了
        activityIndicator.stopAnimating()
        // grayViewを消す
        grayView.isHidden = true
    }
    
    // 更新
    @objc func refresh() {
        // 初期化
        items = [NSDictionary]()
        // データをサーバから取得
        fetch()
        // リロード
        tableView.reloadData()
        // リフレッシュ終了
        refreshControl.endRefreshing()
    }
    
    // Firebaseから投稿データを取得
    func fetch() {
        // getで全件取得
        db.collection("contents").getDocuments() {(querySnapshot, err) in
            // tempItemsという変数を一時的に作成
            var tempItems = [NSDictionary]()
            // for文で回し`item`に格納
            for item in querySnapshot!.documents {
                // item内のデータをdictという変数に入れる
                let dict = item.data()
                // dictをtempItemsに入れる
                tempItems.append(dict as NSDictionary)
            }
            // tempItemsをitems(クラスの変数として定義した)に入れる
            self.items = tempItems
            // リロード
            self.tableView.reloadData()
        }
    }
    
    // セクションの中のセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 投稿情報の数に設定
        return items.count
    }
    
    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell
        
        // FIXME: 下３つ書いても効かない（角が丸くならない）　TimeLineTableVCにも書いてみたけど効きません。
        // ラベルの角に丸みをもたせる
//        cell.timeLineNameLabel.layer.cornerRadius = 10
//        cell.timeLineNameLabel.layer.masksToBounds = true
//        cell.timeLineNameLabel.clipsToBounds = true
        
        // セルを選択不可にする
        cell.selectionStyle = .none
        
        // いいねされた投稿のいいねボタン(goodButton)に対して、タグ番号としてセルのindex番号を格納する
        cell.goodButton.tag = indexPath.row
        
        // Firebaseから全投稿のプロフィール画像、ユーザー名、投稿文、投稿画像、お題を取得して反映する
        // まず、itemsの中からindexpathのrow番目を取得するdictを定義
        let dict = items[(indexPath as NSIndexPath).row]
        
        // firebaseから以下①〜⑤の情報をとって反映させる
        // ①プロフィール画像情報
        if let profImage = dict["iconImage"] {
            // NSData型に変換
            let dataProfImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decadedProfImage = UIImage(data: dataProfImage! as Data)
            // profileImageViewへ代入
            cell.timeLineIconImageView.image = decadedProfImage
        } else {
            cell.timeLineIconImageView.image = #imageLiteral(resourceName: "icons8-male-user-96")
        }
        
        // ②名前を反映
        cell.timeLineNameLabel.text = dict["userName"] as? String
        
        // ③投稿画像を反映
        if let postImage = dict["postImage"] {
            
            if postImage as? String == "写真ないよ！！" {
                print("写真ないよ！！")
                // ImageViewを消す
                cell.timeLinePostImageView.isHidden = true
            } else {
                print("写真ありだよ")
                // NSData型に変換
                let dataPostImage = NSData(base64Encoded: postImage as! String, options: .ignoreUnknownCharacters)
                // さらにUIImage型に変換
                let decadedPostImage = UIImage(data: dataPostImage! as Data)
                // postImageViewへ代入
                cell.timeLinePostImageView.image = decadedPostImage
            }
        }
        
        // ④投稿文を反映
        if let comment = dict["comment"] as? String {
            
            cell.timeLinePostTextLabel.text = comment
        } else {
            cell.timeLinePostTextLabel.text = ""
        }
        cell.timeLinePostTextLabel.translatesAutoresizingMaskIntoConstraints = false

        // ⑤お題を反映
        if let theme = dict["theme"] as? String {
            cell.timeLineShowTheme.text = theme
        } else {
            cell.timeLinePostTextLabel.text = ""
        }
        return cell
    }
    
}

// TimeLineVCへの画面遷移に使う
extension TimeLineViewController {
    // TimeLineVCを返す関数
    static func makeTimeLineVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "TimeLine", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "TimeLine")
        // TimeLineVCを返す
        return vc
    }
}
