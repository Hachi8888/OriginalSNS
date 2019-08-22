//
//  TestViewController.swift
//  OriginalSNS
//
//  Created by VERTEX22 on 2019/08/22.
//  Copyright © 2019 N-project. All rights reserved.
//

import UIKit
import BubbleTransition

class TestViewController: UIViewController , UIViewControllerTransitioningDelegate{

    @IBOutlet weak var nextButton: UIButton!

    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }


    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = nextButton.center
        transition.bubbleColor = nextButton.backgroundColor!
        return transition
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = nextButton.center
        transition.bubbleColor = nextButton.backgroundColor!
        return transition
    }


}

//  ★別のクラスを作ります!!★

class Test2ViewController: UIViewController {

    // dismiss用
    var interactiveTransition = BubbleInteractiveTransition()

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let controller = segue.destination as? Test2ViewController {
        controller.transitioningDelegate = self as? UIViewControllerTransitioningDelegate
        controller.modalPresentationStyle = .custom
        controller.interactiveTransition = interactiveTransition
        interactiveTransition.attach(to: controller)
    }
}

// dismiss用
func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactiveTransition
}

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }

}
