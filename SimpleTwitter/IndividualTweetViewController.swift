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
    
    @IBOutlet weak var replyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = tweet.user!.name
        userTwitterHandleLabel.text = "@\(tweet.user!.screenname!)"
        tweetTextLabel.text = tweet.text
        var imageURL = tweet.user!.profileImageURL!
        var url = NSURL(string: imageURL)!
        self.userImageView.setImageWithURL(url)

        if (tweet.favorited == 1) {
            favoriteButton.enabled = false
            favoriteButton.alpha = 0.4
        }
        
        if (tweet.retweeted == 1) {
            retweetButton.enabled = false
            retweetButton.alpha = 0.4
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet!.statusId!)
        retweetButton.enabled = false
        retweetButton.alpha = 0.4
        
    }
    @IBAction func onFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet!.statusId!)
        favoriteButton.enabled = false
        favoriteButton.alpha = 0.4
    }
    
    @IBAction func onReply(sender: AnyObject) {
        performSegueWithIdentifier("replySegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "replySegue") {
            var composeViewController = segue.destinationViewController as! ComposeViewController
            composeViewController.user = User.currentUser!
            composeViewController.tweet = self.tweet
        }
    }

}
