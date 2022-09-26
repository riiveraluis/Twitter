//
//  LoginViewController.swift
//  Twitter
//
//  Created by Luis Rivera Rivera on 9/23/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userIsLogIn") {
            self.performSegue(withIdentifier: "toHomeSegue", sender: self)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let authenticationURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: authenticationURL, success: {
            UserDefaults.standard.set(true, forKey: "userIsLogIn")
            self.performSegue(withIdentifier: "toHomeSegue", sender: self)
        }, failure: { Error in
            print(Error.localizedDescription)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
