//
//  CreateTweetViewController.swift
//  Twitter
//
//  Created by Luis Rivera Rivera on 9/28/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class CreateTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tweetComposeTextView: RSKPlaceholderTextView!
    @IBOutlet weak var charactersLeftLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetComposeTextView.delegate = self
        tweetComposeTextView.text = ""
        tweetComposeTextView.placeholder = "What is your status?"
        tweetComposeTextView.layer.borderWidth = 1
        tweetComposeTextView.becomeFirstResponder()
    }
    
    @IBAction func tweetButtonPressed(_ sender: Any) {
        if !tweetComposeTextView.text.isEmpty {
            TwitterAPICaller.client?.postTweet(tweetComposeTextView.text, success: {
                self.dismiss(animated: true)
            }, failure: { error in
                print(error.localizedDescription)
            })
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        
        let newText = NSString(string: tweetComposeTextView.text!).replacingCharacters(in: range, with: text)
        
        charactersLeftLabel.text = "Characters left: \( characterLimit - newText.count)"
        
        return newText.count < characterLimit
    }
}
