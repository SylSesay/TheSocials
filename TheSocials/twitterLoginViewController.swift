//
//  twitterLoginViewController.swift
//  TheSocials
//
//  Created by Sylvia Sesay on 2/26/20.
//  Copyright © 2020 Sylvia Sesay. All rights reserved.
//
import UIKit
import TwitterKit

class twitterLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        

    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedin") == true {
            self.performSegue(withIdentifier: "LoggintoHome", sender: self)
        }
    }


    @IBAction func onLoginButton(_ sender: Any) {
        
        let URL = "https://api.twitter.com/oauth/request_token"
            TwitterAPICaller.client?.login(url: URL, success: {
                
                UserDefaults.standard.set(true, forKey: "userLoggedin")
                self.performSegue(withIdentifier: "LogintoHome", sender: self)
            }, failure: { (Error) in
                print("Could not log on!")
            })
        
      /*
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if session != nil{
                UserDefaults.standard.set(session?.userID, forKey: "userId")
                UserDefaults.standard.set(session?.userName, forKey: "userName")
                UserDefaults.standard.set(true,forKey: "userLoggedin")
                
                let twitterNav = self.storyboard?.instantiateViewController(withIdentifier:"toTwitter") as? twitterNavViewController
                //twitterHomeTableViewController
                self.present(twitterNav!, animated: false, completion: nil)
            } else{
                print(error.debugDescription)
            }
            
        }
    */
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
