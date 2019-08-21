//
//  ThemeViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/20.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {

    // 決まったお題を表示させるラベル
    @IBOutlet weak var themeLabel: UILabel!

    // MainVCからsegueで送られたデータを格納する変数3つ
    var receiveWhat: String = ""
    var receiveTodo: String = ""
    var receiveHow: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
     // ラベルにお題を表示
     themeLabel.text = "\n\(receiveWhat)" + "\n\(receiveTodo)" + "\n\(receiveHow)"
    }

}
