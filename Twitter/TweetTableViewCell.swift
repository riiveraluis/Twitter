//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Luis Rivera Rivera on 9/25/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var favorite: Bool = false
    var retweeted: Bool = false
    var tweetId: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func favoriteTweet(_ sender: UIButton) {
        let toBeFavorited = !favorite
        if toBeFavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { error in
                print("Favorite did not succeed")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { error in
                print("Favorite did not succeed")
            })
        }
    }
    
    
    func setFavorite(_ isFavorited: Bool) {
        favorite = isFavorited
        if favorite {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    @IBAction func retweetTweet(_ sender: UIButton) {
        let toBeRetweeted = !retweeted
        
        if toBeRetweeted {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { error in
                print("Could not retweet!")
            })
        } else {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { Error in
                print("Could not unretweet")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
//            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
//            retweetButton.isEnabled = true
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
