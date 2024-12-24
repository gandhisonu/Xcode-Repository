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
   // var recipeId : String? = ""
    var id :String? = ""
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
       // case recipeId  = "recipe_id"
        case id
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


//AddRecipe
public struct AddRecipeMaster : Codable {
    let title : String
    let categoryIDs : [String]
    let deviceID : String
    let ingredients :String
    let equipments : String
    let steps : [AddRecipeSteps]
    let uploadAsset : String?
    
    enum CodingKeys : String, CodingKey {
        case title
        case categoryIDs = "category_ids"
        case deviceID = "device_id"
        case ingredients
        case equipments
        case steps
        case uploadAsset = "upload_asset"
    }
}

public struct AddRecipeSteps : Codable {
    let info : AddRecipeInfo
    let assets :   [AddRecipeAsset]? //[String
    let uploadAssets : [String]?
    
    enum CodingKeys: String, CodingKey {
        case info , assets
        case uploadAssets = "upload_assets"
    }
}

public struct AddRecipeInfo : Codable {
    let mode : String?
    let temp : String?
    let tempUnit : String?
    let time : String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case mode, temp
        case tempUnit = "temp_unit"
        case time, description
    }
}

public struct AddRecipeAsset : Codable {
    let assetType: String
    let assetURL: String
    
    enum CodingKeys: String, CodingKey {
        case assetType = "asset_type"
        case assetURL = "asset_url"
    }
}

//AddRecipe close
/* //Add recipe output string
public struct AddRecipeOutput :Codable {
    let id : String
    let steps : [AssetDetail]
    let signedUrl : String
    
    enum CodingKeys : String, CodingKey {
        case id,steps
        case signedUrl  = "signed_url"
    }
}
public struct AssetDetail : Codable {
    let assets : [OutputAssets]
    
    enum CodingKeys : String,CodingKey {
        case assets
     
    }
}

public struct OutputAssets :Codable {
    let assetType : String
    let assetUrl : String
    
    enum CodingKeys : String,CodingKey {
        case assetType = "asset_type"
        case assetUrl = "signed_url"
    }
}
*/
