//
//  HomeViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/21.
//  Copyright © 2019 N-project. All rights reserved.
//

import BubbleTransition
import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    // BubbleTransition用
    var startingPoint = CGPoint(x:0,y:0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // FIXME: storyboardの移動をstruct?で作成できないか検討中(クラスの下にコメントアウトしている)
    // 【ファイル間共通で使用】②storyboardを移動させる関数
    func transferVC(_ SBname: String, _ SBIdName: String) {
        // HomeVC画面に遷移する
        // storyboardをHomeのファイルを特定
        let storyboard: UIStoryboard = UIStoryboard(name: SBname, bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: SBIdName)
        // 遷移処理
        present(vc, animated: true)
    }


    // Mainボタン
    @IBAction func mainButton(_ sender: UIButton) {


    }


}


extension HomeViewController {
 // HomeVCを返す関数(HomeVCへの画面遷移に使う)
    static func makeHomeVC() -> UIViewController {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Home")
        // 遷移処理
        //    self.present(vc, animated: true)

        // HomeVCを返す
        return vc
    }
}
