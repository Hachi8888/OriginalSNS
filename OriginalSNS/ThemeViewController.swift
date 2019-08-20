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

     themeLabel.text = "\n\(receiveWhat)" + "\n\(receiveTodo)" + "\n\(receiveHow)"

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
