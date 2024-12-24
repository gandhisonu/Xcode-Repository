//
//  Products.swift
//  TestProject001
//
//  Created by Mac on 03/04/24.
//

import Foundation


public struct ProductMaster: Codable{
    var products : [Product]
    var nextCursor :String
    
    enum CodingKeys:String,CodingKey{
        case products
        case nextCursor = "next_cursor"
    }
    
}

public struct Product: Codable {
    var id : String
    var name : String
    var tag : String
    var price : Double
    var discount : Double
    var shippingCharges : Double
    var categories : [productCategories]
    var assets : [String]
  //  var signedUrls :[String]
    
    enum CodingKeys : String, CodingKey{
        //case productId = "id"
        case id,name,tag
        case price,discount
        
        case shippingCharges  = "shipping_charges"
        case categories
        case assets
       // case signedUrls = "signed_urls"
    }
}
public struct productCategories : Codable{
    var id : String
    var name : String
   // var parent : String //
    
    enum CodingKeys: String,CodingKey{
        case id, name  //, parent
    }
}
    


//product_List
public struct ShopProductList: Codable {
    var products :[ShopProduct]
    
    enum CodingKeys : String,CodingKey{
        case products
    }
}

public struct ShopProduct: Codable {
    var id : String
    var name : String
    
    enum CodingKeys : String,CodingKey{
        case id,name
    }
}




