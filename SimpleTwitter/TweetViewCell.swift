//
//  TweetViewCell.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/3/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(tweet: Tweet) {
                var imageURL = tweet.user!.profileImageURL!
                var url = NSURL(string: imageURL)!
                self.userImageView.setImageWithURL(url)
                self.usernameLabel.text = tweet.user?.name
                self.twitterHandleLabel.text = "@\(tweet.user!.screenname!)"
                self.tweetTextLabel.text = tweet.text
                self.timestampLabel.text = tweet.createdAt!.timeAgoSinceNow()
    }
    
}
