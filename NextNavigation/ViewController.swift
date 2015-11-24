//
//  ViewController.swift
//  NextNavigation
//
//  Created by SON on 2015. 11. 16..
//  Copyright (c) 2015년 LearnToProgram.tv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentLB: UILabel!
    var depth : Int!
    @IBOutlet var nextBT: UIButton!
    @IBOutlet var firstBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstBT.addTarget(self, action: "goFirstBT:", forControlEvents: UIControlEvents.TouchDown)
        
        depth = self.navigationController?.viewControllers.count
        self.navigationItem.title = "\(depth)"
        currentLB.text = "\(depth)"
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPressGesture:"))
        longPress.minimumPressDuration = 1.0
        self.nextBT.gestureRecognizers = [longPress]
    }
    
    func handleLongPressGesture(recogizer: UILongPressGestureRecognizer) {
        print("Now Finger is pressing")
        self.navigationController?.pushViewController(LongPressView(), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goFirstBT(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
}

