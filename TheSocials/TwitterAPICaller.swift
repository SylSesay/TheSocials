//
//  TwitterAPICaller.swift
//  APIManager.swift
//  TheSocials
//
//  Created by Sylvia Sesay on 2/27/20.
//  Copyright © 2020 Sylvia Sesay. All rights reserved.
//  Created by Dan on 1/3/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
import TwitterKit
import BDBOAuth1Manager

//https://developer.twitter.com/en/apps/create
/* My info
consumerKey:vooS3mq5l9wLnMCbub4qYPaRD
consumerSecret:CzMnh060YMQhPLPZRwb0ronAOh4JV996eDWCM83JO8EWocDjE0

*/
class TwitterAPICaller: BDBOAuth1SessionManager {
    static let client = TwitterAPICaller(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "vooS3mq5l9wLnMCbub4qYPaRD", consumerSecret: "CzMnh060YMQhPLPZRwb0ronAOh4JV996eDWCM83JO8EWocDjE0")
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        TwitterAPICaller.client?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            self.loginSuccess?()
        }, failure: { (error: Error!) in
            self.loginFailure?(error)
        })
    }
    
    func login(url: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterAPICaller.client?.deauthorize()
        TwitterAPICaller.client?.fetchRequestToken(withPath: url, method: "GET", callbackURL: URL(string: "alamoTwitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")!
            UIApplication.shared.open(url)
        }, failure: { (error: Error!) -> Void in
            print("Error: \(error.localizedDescription)")
            self.loginFailure?(error)
        })
    }
    func logout (){
        deauthorize()
    }
    
    func getDictionaryRequest(url: String, parameters: [String:Any], success: @escaping (NSDictionary) -> (), failure: @escaping (Error) -> ()){
        TwitterAPICaller.client?.get(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success(response as! NSDictionary)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func getDictionariesRequest(url: String, parameters: [String:Any], success: @escaping ([NSDictionary]) -> (), failure: @escaping (Error) -> ()){
        print(parameters)
        TwitterAPICaller.client?.get(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success(response as! [NSDictionary])
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }

    func postRequest(url: String, parameters: [Any], success: @escaping () -> (), failure: @escaping (Error) -> ()){
        TwitterAPICaller.client?.post(url, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func postTweet(tweetString:String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/statuses/update.json"
        TwitterAPICaller.client?.post(url, parameters: ["status":tweetString], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    func favoriteTweet(tweetId:Int, success: @escaping() -> (), failure: @escaping (Error) -> ()) {
        let url = "https://api.twitter.com/1.1/favorites/create.json"
        TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    func unfavoriteTweet(tweetId:Int, success: @escaping() -> (), failure: @escaping (Error) -> ()) {
        let url = "https://api.twitter.com/1.1/favorites/destroy.json"
        TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    func retweet(tweetId:Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/statuses/retweet/\(tweetId).json"
        TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    func unretweet(tweetId:Int, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        let url = "https://api.twitter.com/1.1/statuses/retweet/destroy.json"
        TwitterAPICaller.client?.post(url, parameters: ["id":tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            success()
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func tweetView(_ tweetView: TWTRTweetView, didChange newState: TWTRVideoPlaybackState) {
      switch newState {
      case .paused:
        print("Do something when video is paused")
      case .playing:
        print("Do something when video starts to play")
      case .completed:
        print("Do something when video play is completed")
      @unknown default: break
        }
    }
    
}

