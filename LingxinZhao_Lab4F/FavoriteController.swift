//
//  FavoriteController.swift
//  LingxinZhao_Lab4F
//
//  Created by Lingxin Zhao on 10/10/16.
//  Copyright © 2016 Lingxin. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        let data=NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovie")!
        if data.count==0{
            showAlert()
        }
        setupTableView()
        self.title = "Favorites"
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let data=NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovie")!
        if data.count==0{
            showAlert()
        }
        tableView.reloadData()
    }
    func showAlert(){
        let alertController = UIAlertController(title: "", message:
            "NO FAVORITE", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.frame.offsetBy(dx:0, dy: 20))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovie")!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovie")![indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var arrayInDefault=NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovie") as! [String]
            arrayInDefault.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(arrayInDefault, forKey: "favoriteMovie")
            NSUserDefaults.standardUserDefaults().synchronize()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        }
        tableView.reloadData()
    }
    
    
}

