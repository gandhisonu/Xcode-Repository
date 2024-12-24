//
//  Recipe.swift
//  TestProject001
//
//  Created by Mac on 28/03/24.
//Design Model as per Schema from swegger names can be differ in model
//add coding keys as per swegger names

import Foundation



public struct RecipeMaster : Codable {
    var recipes : [Recipe]
    var nextCursor : String
    
    enum CodingKeys : String,CodingKey{
        case recipes
        case nextCursor = "next_cursor"
    }
}

public struct Recipe: Codable {
    var recipeId : String? = ""
    var title : String? = ""
    var state : String? = ""
    var creatorId : String? = ""
    var creatorName : String? = ""
    var publishedOn : Int? = 0
    var submittedOn : Int? = 0
    var rejectedOn : Int? = 0
    var updated : Int? = 0
    var created : Int? = 0
    var categories : [RecipeCategory]? = []
    var assestUrl : String?
    
    enum CodingKeys : String ,CodingKey{
        case recipeId  = "recipe_id"
        case title,state,updated,created
        case creatorId = "creator_id"
        case creatorName = "creator_name"
        case publishedOn = "published_on"
        case submittedOn = "submitted_on"
        case rejectedOn = "rejected_on"
        case categories = "categories"  //category_ids
        case assestUrl = "asset_url"
    }
}
public struct RecipeCategory : Codable{
    var id : String? = ""
    var name : String? = ""
    
    enum CodingKeys : String,CodingKey{
        case id,name
    }
}
