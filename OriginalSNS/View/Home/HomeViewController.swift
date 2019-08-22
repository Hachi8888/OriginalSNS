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

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // HomeVCを返す
        return vc
    }
}
