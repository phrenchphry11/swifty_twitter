//
//  TwitterClient.swift
//  Twitter
//
//  Created by Holly French on 4/30/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

let twitterConsumerKey = "E21mq7bApk9WGMvZDMgGwCuOI"
let twitterConsumerSecret = "6N7Zj8k13fUe3cldb0WCPGc1MVxIUrv1dbfjSNQY7tjGvwUFFI"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    override init!(baseURL: NSURL!, consumerKey: String!, consumerSecret: String!) {
        super.init(baseURL: baseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            
        }
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token, redirect to auth page.
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }, failure: { (error: NSError!) -> Void in
                println("FAILED TO GET THE REQUEST TOKEN")
                self.loginCompletion?(user: nil, error: error)
        })
        
    }
    
    func loginWithBlock(url: NSURL) {
        fetchAccessTokenWithPath(
            "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
                TwitterClient.sharedInstance.GET(
                    "1.1/account/verify_credentials.json",
                    parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        var user = User(dictionary: response as! NSDictionary)
                        User.currentUser = user
                        self.loginCompletion?(user: user, error: nil)
                        println("success in login")
                    },
                    failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("failed to get current user")
                        self.loginCompletion?(user: nil, error: error)
                    }
                )
                
                TwitterClient.sharedInstance.getHomeFeed(nil, completion: { (tweets, error) -> () in
                    Tweet.timelineTweets = tweets
                })
                
            },
            failure: { (error: NSError!) -> Void in
                println("Failed to get the access token")
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }
    
    func getHomeFeed(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET(
            "1.1/statuses/home_timeline.json",
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
                Tweet.timelineTweets = tweets

            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                completion(tweets: nil, error: error)
            }
        )
    }
    
    func favorite(id: Int) {
        TwitterClient.sharedInstance.POST(
            "1.1/favorites/create.json",
            parameters: ["id": id],
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("favorited tweet: \(id)")
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed to favorite")
                println(error)
            }
        )
    }
    
    func retweet(id: Int) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/retweet/\(id).json",
            parameters: ["id": id],
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("retweeted tweet: \(id)")
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed to retweet")
                println(error)
            }
        )
    }
    
    func composeTweet(text: String) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/update.json",
            parameters: ["status": text],
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("tweeted:")
                println(text)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed to get current user")
                println(error)
            }
        )
    }
    
    func reply(text: String, id: Int) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/update.json",
            parameters: [
                "status": text,
                "in_reply_to_status_id": id
            ],
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("replied to tweet")
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed reply")
                println(error)
            }
        )
    }
    
}
