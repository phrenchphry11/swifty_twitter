//
//  UserViewController.swift
//  SimpleTwitter
//
//  Created by Holly French on 5/10/15.
//  Copyright (c) 2015 Holly French. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            
        } else {
            self.user = User.currentUser
        }
        
        var imageURL = user!.profileImageURL!
        var url = NSURL(string: imageURL)!
        self.userImageView.setImageWithURL(url)
        self.userNameLabel.text = user?.name
        self.twitterHandleLabel.text = "@\(user!.screenname!)"
        self.followersLabel.text = "\(user!.followersCount!) Followers"
        self.followingLabel.text = "\(user!.followingCount!) Following"
        self.bioLabel.text = user?.bio

        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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

}
