//
//  Videos.swift
//  TestProject001
//
//  Created by Mac on 24/05/24.
//

import Foundation


public struct VideoMaster : Codable {
    var videos : [Video]
    
    enum CodingKeys : String,CodingKey {
        case videos
    }
}

public struct Video : Codable {
    let id: String?
    let title: String?
    let description: String?
    let createdID : String?
    let createdBy : String?
    let views : Int?
    let createdOn : Int?
    let updatedOn : Int?
    let categories : [Categories]?  //VideoCategory
    let assetUrl : String?
    let thumbUrl : String?
    let signedUrl : String?
    
    enum CodingKeys : String,CodingKey {
        case id,title,description,views
        case createdID = "creator_id"
        case createdBy  = "creator_name"
        case createdOn =  "created"
        case updatedOn = "updated"
        case categories = "categories"
        case assetUrl = "asset_url"
        case thumbUrl =  "thumb_url"
        case signedUrl = "signed_url"
    }

}

public struct Categories: Codable{
    let id: String
    let name : String
    let childs : [Childs]
    
    enum CodingKeys : String,CodingKey {
       case id, name,childs
    }
}
public struct Childs : Codable{
    let id : String
    let name: String
    let childs :[String]
    enum CodingKeys : String,CodingKey {
        case id , name,childs
    }
}


