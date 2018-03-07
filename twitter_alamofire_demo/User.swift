//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Han Chi on 3/6/18.
//  Copyright © 2018 Han Chi. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    static var current: User?
    var profileImageUrl: URL?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        if let urlstring = dictionary["profile_image_url_https"] as? String {
            profileImageUrl = URL(string: urlstring)!
        } else {
            profileImageUrl = nil
        }
    }
}
