//
//  ViewLongPress.swift
//  NextNavigation
//
//  Created by SON on 2015. 11. 24..
//  Copyright © 2015년 LearnToProgram.tv. All rights reserved.
//

import UIKit

class LongPressView: UITableViewController  {
    
    var depth : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - TableViewDeagate
    override func tableView(tableview : UITableView, didSelectRowAtIndexPath indexPath : NSIndexPath){
        print("You selected row #\(indexPath.row)!")
        //self.navigationController?.viewControllers.removeRange((indexPath.row + 1)...depth)
        let topNavigationController = self.presentingViewController as? UINavigationController
        presentingViewController?.dismissViewControllerAnimated(true) { () -> Void in
            assert(topNavigationController!.viewControllers.count > indexPath.row)
            topNavigationController!.popToViewController(topNavigationController!.viewControllers[indexPath.row], animated: true)
        }
    }
    
    // MARK: - TableViewDataSource
    override func tableView(tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depth
    }
    
    override func tableView(tableview : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath)->UITableViewCell{
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel!.text = "\(indexPath.row + 1)"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
