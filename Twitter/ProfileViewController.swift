//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Luis Rivera Rivera on 10/1/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
import AlamofireImage
class ProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userTweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var profileDetails = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterAPICaller.client?.getProfileDetails(success: { (profileDetails: [Any]) in
            
            self.profileDetails = profileDetails
            self.updateUI()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    func updateUI() {
     print(profileDetails)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
