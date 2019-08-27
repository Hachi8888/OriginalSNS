//
//  HomeViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/21.
//  Copyright © 2019 N-project. All rights reserved.
//

import BubbleTransition
import UIKit
import IBAnimatable

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var testImageView: AnimatableImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
testImageView.animate(.pop(repeatCount: 1))

    }

    // Mainボタンを押したとき
    @IBAction func toMainButton(_ sender: Any) {
        // MainVCへ画面遷移する
        present(MainViewController.makeMainVC(), animated: true)
    }

    // TaimeLineボタンを押したとき
    @IBAction func toTimeLineButton(_ sender: Any) {
        // TimeLineVCへ画面遷移する
        present(TimeLineViewController.makeTimeLineVC(), animated: true)
    }

    // Postボタンを押したとき
    @IBAction func toPostVCbutton(_ sender: Any) {
        // PostVCへ画面遷移する
        present(PostViewController.makePostVC(), animated: true)
    }

   // Calenderボタンを押したとき
    @IBAction func toCalender(_ sender: Any) {
    // CalenderVCへ画面遷移する

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
