//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            if let profileImageUrl = tweet.user.profileImageUrl {
                userProfileImageView.af_setImage(withURL: profileImageUrl)
            } else {
                userProfileImageView.image = nil
            }
            userNameLabel.text = tweet.user.name
            let screenName = tweet.user.screenName
            screenNameLabel.text = "@\(screenName)"
            timestampLabel.text = tweet.createdAtString
            favoriteCountLabel.text = String(tweet.favoriteCount!)
            retweetCountLabel.text = String(tweet.retweetCount)
            
            if tweet.favorited! {
                favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            if tweet.retweeted {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
        }
    }
    

    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited! {
            tweet.favorited = false
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            tweet.favoriteCount = tweet.favoriteCount! - 1
            APIManager.shared.un_favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = true
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            tweet.favoriteCount = tweet.favoriteCount! + 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        favoriteCountLabel.text = String(tweet.favoriteCount!)
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted {
            tweet.retweeted = false
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            tweet.retweetCount = tweet.retweetCount - 1
            APIManager.shared.un_retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.retweeted = true
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            tweet.retweetCount = tweet.retweetCount + 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        retweetCountLabel.text = String(tweet.retweetCount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
