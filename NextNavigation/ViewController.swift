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
        print("viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstBT.addTarget(self, action: "goFirstBT:", forControlEvents: UIControlEvents.TouchDown)
        depth = self.navigationController?.viewControllers.count
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeNumber", name: UIDeviceOrientationDidChangeNotification, object: nil)
        changeNumber()
        
        //let longPress = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPressGesture:"))
        //longPress.minimumPressDuration = 1.0
        //self.nextBT.gestureRecognizers = [longPress]
    }
    
    func hangul(num: Int) -> String
    {
        let digit_1 : [String] = ["", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
        let digit_10 : [String] = ["십", "백", "천"]
        let digit_10000 : [String] = ["만", "억", "조", "경"]
        
        var first : Int = 1
        var pos_10 : Int = 0
        var pos_10000 : Int = 0
        var quotient : Int = num
        var remainder : Int = 0
        var hangul : String = ""
        print(num)
        
        while(true)
        {
            if(quotient == 0)
            {
                break
            }
            remainder = quotient % 10
            quotient = quotient / 10
            //print(remainder)
            //print(quotient)
            if(first == 1)
            {
                first = 0
                hangul = digit_1[remainder]
                continue;
            }
        
            if(pos_10 == 3)
            {
                pos_10 = 0
                hangul = digit_1[remainder] + digit_10000[pos_10000++] + hangul
            }
            else
            {
                hangul = digit_1[remainder] + digit_10[pos_10++] + hangul
            }
        }
        
        print(hangul)
        return hangul
    }
    
    func changeNumber()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            print("landscape")
            //depth = self.navigationController?.viewControllers.count
            self.navigationItem.title = hangul(depth)
            currentLB.text = hangul(depth)
            return
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            print("Portrait")
            self.navigationItem.title = "\(depth)"
            currentLB.text = "\(depth)"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "depth") {
            let LongPressNavigationController = segue.destinationViewController as! UINavigationController
            let LongPressViewController = LongPressNavigationController.viewControllers[0] as! LongPressView
            LongPressViewController.depth = depth
        }
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
    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {
        performSegueWithIdentifier("depth", sender: self)
    }
}

