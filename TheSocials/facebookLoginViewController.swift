//
//  facebookLoginViewController.swift
//  TheSocials
//
//  Created by Sylvia Sesay on 3/26/20.
//  Copyright © 2020 Sylvia Sesay. All rights reserved.
//
import FBSDKCoreKit
import FacebookCore
import FBSDKLoginKit
import UIKit
import FacebookLogin
//import FacebookLogin

class facebookLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onFbLoginButton(_ sender: Any) {
        facebookLogin()
    }
    
    func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions:[ .publicProfile, .email, .userFriends ], viewController: self) { (result) in
            switch result {
                case .cancelled:
                    print("User cancelled login")
        
            case .failed(let error):
                print("Login failed with error = \(error.localizedDescription)")
                break
            case .success( _, _, let accessToken):
                print("access token == \(accessToken)")
            }
        }
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
