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
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var trayView: UIView!
    
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    var trayOriginalCenter: CGPoint!

    var bannerOriginalCenter: CGPoint!
    
    var bannerOriginalBounds: CGRect!
    
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
        
        var bannerURL = user!.bannerURL
        if let bannerURL = bannerURL {
            url = NSURL(string: bannerURL)!
            self.bannerImageView.setImageWithURL(url)
        }


        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "scrollUserView:")
        var bannerGestureRecognizer = UIPanGestureRecognizer(target: self, action: "scrollUserView:")

        trayView.addGestureRecognizer(panGestureRecognizer)
        bannerImageView.addGestureRecognizer(bannerGestureRecognizer)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollUserView(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
            bannerOriginalBounds = bannerImageView.bounds
            bannerOriginalCenter = bannerImageView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + panGestureRecognizer.translationInView(self.trayView).y)
            bannerImageView.center = CGPoint(x: bannerOriginalCenter.x, y: bannerOriginalCenter.y + panGestureRecognizer.translationInView(self.bannerImageView).y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            var slideFactor = 0.1
            UIView.animateWithDuration(Double(slideFactor * 2),
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseOut,
                animations: {self.trayView.center.y = self.trayOriginalCenter.y
                    self.bannerImageView.center.y = self.bannerOriginalCenter.y
            },
            completion: nil)
        }
    }
    
}
