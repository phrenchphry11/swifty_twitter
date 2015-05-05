//
//  ComposeViewController.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/4/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var user: User!
    
    var tweet: Tweet?
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var tweetTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var charactersAllowedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = user.name
        twitterHandleLabel.text = user.screenname
        var imageURL = user.profileImageURL!
        var url = NSURL(string: imageURL)!
        self.userImageView.setImageWithURL(url)
        
        if tweet != nil {
            tweetTextField.text = "@\(tweet!.user!.screenname!) "
            submitButton.setTitle("Reply", forState: UIControlState.Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmitTweet(sender: AnyObject) {
        if tweet != nil {
            TwitterClient.sharedInstance.reply(tweetTextField.text, id: tweet!.statusId!)
        } else {
            TwitterClient.sharedInstance.composeTweet(tweetTextField.text)
        }
        let controller = storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}
