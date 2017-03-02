//
//  ViewController.swift
//  LingxinZhao_Lab4F
//
//  Created by Lingxin Zhao on 10/10/16.
//  Copyright © 2016 Lingxin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var theData: [Movie] = []
    var theImageCache: [UIImage] = []
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        //self.title = "Favorite"
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
            self.fetchDataForTableView()
            self.cacheImages()
            
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.frame.offsetBy(dx:0, dy: 0))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
    }
    
    func fetchDataForTableView() {
        let json = getJSON("http://research.engineering.wustl.edu/~todd/studio.json")
        print(json.arrayValue.count)
        for result in json.arrayValue {
            let name = result["name"].stringValue
            let description = result["description"].stringValue
            let url = result["image_url"].stringValue
            let released = result["Year"].stringValue
            let score = result["Year"].intValue
            let rating=result["Year"].stringValue
            //theData.append(Movie(name:name,description:description,url:url,released:released,score:score,rating:rating))
        }
        print("printData: "+"\(theData)")
    }
    
    
    private func getJSON(url: String) -> JSON {
        
        if let nsurl = NSURL(string: url){
            print("nsurl:\(nsurl)")
            if let data = NSData(contentsOfURL: nsurl) {
                print("data: \(data)")
                let json = JSON(data: data)
                print("json:\(json)")
                return json
            } else {
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func cacheImages() {
        
        //NSURL
        //NSData
        //UIImage
        
        for item in theData {
            
            let url = NSURL(string: item.url)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            theImageCache.append(image!)
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("I have \(theData.count) items in my array")
        
        return theData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = theData[indexPath.row].name
        //cell.detailTextLabel?.text = theData[indexPath.row].description
        cell.imageView?.image = theImageCache[indexPath.row]
        
        return cell
    }
    
}

