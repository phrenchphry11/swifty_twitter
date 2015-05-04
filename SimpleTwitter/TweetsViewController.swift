//
//  TweetsViewController.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/3/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

let TwitterColor = UIColor(red: 0.3320, green: 0.6745, blue: 0.9333, alpha: 1)

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweet: Tweet?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "TweetViewCell", bundle: nil), forCellReuseIdentifier: "TweetViewCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.getHomeFeed(nil, completion: { (tweets, error) -> () in
            Tweet.timelineTweets = tweets
            self.tableView.reloadData()
        })
    
        self.title = "Twitter"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "onLogout")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Compose", style: .Plain, target: self, action: "onCompose")
        
        self.navigationController?.navigationBar.barTintColor = TwitterColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tweets = Tweet.timelineTweets
        if let tweets = tweets {
            println("Count:")
            println(Tweet.timelineTweets!.count)
            return Tweet.timelineTweets!.count
        }
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("TweetViewCell") as! TweetViewCell
        
        var tweets = Tweet.timelineTweets
        if let tweets = tweets {
            var tweet = tweets[indexPath.row]
            cell.setTweet(tweet)

        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var tweets = Tweet.timelineTweets
        self.tweet = tweets![indexPath.row]
        performSegueWithIdentifier("tweetViewSegue", sender: self)

    }
    
    func onLogout() {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tweetViewSegue") {
            var individualTweetViewController = segue.destinationViewController as! IndividualTweetViewController
            individualTweetViewController.tweet = self.tweet
        }
    }
    
    func onCompose() {
        performSegueWithIdentifier("composeViewSegue", sender: self)
    }

}
