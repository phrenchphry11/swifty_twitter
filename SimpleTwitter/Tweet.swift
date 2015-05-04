//
//  Tweet.swift
//  Twitter
//
//  Created by Holly French on 4/30/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

var _timelineTweets: [Tweet]?

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favorited: Bool?
    var retweeted: Bool?
    var statusId: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        statusId = dictionary["id"] as? Int
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        self.favorited = dictionary["favorited"] as? Bool
       
        self.retweeted = dictionary["retweeted"] as? Bool
       
    }
    
    class func tweetWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
    class var timelineTweets: [Tweet]? {
        get {
        return _timelineTweets
        }
        
        set(tweets) {
            _timelineTweets = tweets
        }
    }
}
