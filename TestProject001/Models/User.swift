//
//  User.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
//

import Foundation
import SwiftyJSON


public struct User : Codable {
    var accessToken: String?
    var expiresIN: String?
    var tokenType: String?
    var emailID: String?
    var password: String?
    
    init(accessToken: String) {
        self.accessToken = accessToken
        self.expiresIN = ""
        self.tokenType = ""
        self.emailID = ""
        self.password = ""
    }
    
    public static func userFromJSON(from json: JSON)->User? {
        
        //if access token did not generate then user will be nil
        guard let accessToken =  json["accessToken"].string else {
            return nil
        }
        var userObj = User(accessToken: accessToken)
        userObj.expiresIN =  json["expiresIN"].string ?? ""
        userObj.tokenType =  json["tokenType"].string ?? ""
        userObj.emailID =  json["emailID"].string ?? ""
        userObj.password =  json["password"].string ?? ""
        return userObj
    }
    
}
 





