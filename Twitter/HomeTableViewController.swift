//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Luis Rivera Rivera on 9/23/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeTableViewController: UITableViewController {
    
    var tweets = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userIsLogIn")
        self.dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }
    
    @objc func loadTweets() {
        let requestURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = 20
        let parameters = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: requestURL, parameters: parameters, success: { (tweets: [NSDictionary]) in
            
            self.tweets.removeAll()
            
            self.tweets = tweets
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { error in
            print(error.localizedDescription)
            print("Could not load tweets!")
        })
    }
    
    func loadMoreTweets() {
        let requestURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets += 20
        let parameters = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: requestURL, parameters: parameters, success: { (tweets: [NSDictionary]) in
            
            self.tweets.removeAll()
            
            self.tweets = tweets
            
            self.tableView.reloadData()
        }, failure: { error in
            print(error.localizedDescription)
            print("Could not load tweets!")
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        // Configure the cell...
        let user = tweets[indexPath.row]["user"] as! NSDictionary
        let profilePictureURL = user["profile_image_url_https"] as! String
        
        cell.userProfileImageView.af_setImage(withURL: URL(string: profilePictureURL)!)
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContentLabel.text = tweets[indexPath.row]["text"] as? String
        
        cell.setFavorite(tweets[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweets[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweets[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count {
            loadMoreTweets()
        }
    }
}
