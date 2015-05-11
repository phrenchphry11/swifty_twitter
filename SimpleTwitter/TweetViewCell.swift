//
//  TweetViewCell.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/3/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

protocol TweetCellDelegate : class {
    func didClickUserImage(tweetCell: TweetViewCell, tweetUser: User)
}

class TweetViewCell: UITableViewCell {

    var tweetUser: User!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    weak var delegate: TweetCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTweet(tweet: Tweet) {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "goToUserProfile:")

        var imageURL = tweet.user!.profileImageURL!
        var url = NSURL(string: imageURL)!
        self.userImageView.setImageWithURL(url)
        self.usernameLabel.text = tweet.user?.name
        self.twitterHandleLabel.text = "@\(tweet.user!.screenname!)"
        self.tweetTextLabel.text = tweet.text
        self.timestampLabel.text = tweet.createdAt!.timeAgoSinceNow()
        self.userImageView.addGestureRecognizer(tapGestureRecognizer!)
        self.tweetUser = tweet.user!
    }
    
    func goToUserProfile(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate!.didClickUserImage(self, tweetUser: self.tweetUser)
    }

}
