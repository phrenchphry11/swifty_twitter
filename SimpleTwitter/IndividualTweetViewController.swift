//
//  IndividualTweetViewController.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/3/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

class IndividualTweetViewController: UIViewController {
    
    var tweet: Tweet!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userTwitterHandleLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userNameLabel.text = tweet.user!.name
        userTwitterHandleLabel.text = "@\(tweet.user!.screenname!)"
        tweetTextLabel.text = tweet.text
        var imageURL = tweet.user!.profileImageURL!
        var url = NSURL(string: imageURL)!
        self.userImageView.setImageWithURL(url)
        
        if (tweet.favorited == true) {
            println("favorited")
            favoriteButton.enabled = false
            favoriteButton.userInteractionEnabled = false
        }
        
        if (tweet.retweeted == true) {
            println("retweeted")
            retweetButton.enabled = false
            retweetButton.userInteractionEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet!.statusId!)
        retweetButton.enabled = false
        retweetButton.userInteractionEnabled = false
        
    }
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet!.statusId!)
        favoriteButton.enabled = false
        favoriteButton.userInteractionEnabled = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
