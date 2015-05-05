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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onSubmitTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.composeTweet(tweetTextField.text)
        let controller = storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as! TweetsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}
