 //
 //  Detailed.swift
 //  LingxinZhao_Lab4F
 //
 //  Created by Lingxin Zhao on 10/10/16.
 //  Copyright © 2016 Lingxin. All rights reserved.
 //
import UIKit

class Detailed: UIViewController {

    var image: UIImage!
    var name: String!
    var year: String!
    var score: String!
    var rated: String!
    var id:String!
    
    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var theYear: UILabel!
    @IBOutlet weak var theScore: UILabel!
    @IBOutlet weak var theRated: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        theImage.image = image
        theLabel.text = name
        theYear.text = "Released:\(year)"
        theYear.textAlignment = .Center
        theScore.text="Score:\(score)/10"
        theRated.text="Rated:\(rated)"
        
        self.navigationItem.title = name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //add the movie to favorite
    @IBAction func add(sender: AnyObject) {
        var storedData=NSUserDefaults.standardUserDefaults().objectForKey("favoriteMovie") as? [String] ?? [String]()
        if !storedData.contains(name){
            storedData.append(name)
        }
        NSUserDefaults.standardUserDefaults().setObject(storedData,forKey: "favoriteMovie")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
