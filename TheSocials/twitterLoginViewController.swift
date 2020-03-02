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
        
  /*
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedin") == true {
            self.performSegue(withIdentifier: "totwitter", sender: self)
        }
    }
    */

    @IBAction func onLoginButton(_ sender: Any) {
      
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if session != nil{
                UserDefaults.standard.set(session?.userID, forKey: "userId")
                UserDefaults.standard.set(session?.userName, forKey: "userName")
                UserDefaults.standard.set(true,forKey: "userLoggedin")
                //"twitterNavViewController"
                let twitterNav = self.storyboard?.instantiateViewController(withIdentifier: "twitterNavViewController") as? twitterNavigationViewController
                //twitterHomeTableViewController
                self.present(twitterNav!, animated: false, completion: nil)
            } else{
                print(error.debugDescription)
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
