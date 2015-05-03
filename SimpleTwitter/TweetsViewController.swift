//
//  TweetsViewController.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/3/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.getHomeFeed(nil, completion: { (tweets, error) -> () in
            Tweet.timelineTweets = tweets
            self.tableView.reloadData()
        })

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
        let cell = self.tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        
        var tweets = Tweet.timelineTweets
        if let tweets = tweets {
            var tweet = tweets[indexPath.row]
            cell.setTweet(tweet)

        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
