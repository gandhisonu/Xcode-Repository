//
//  Faq.swift
//  TestProject001
//
//  Created by Mac on 03/04/24.
//

import Foundation



public struct FAQ : Codable {
    let options : [Option]
    
    enum CodingKeys :String,CodingKey{
        case options
    }
}
public struct Option : Codable {
    let id: String
    let label :String
    let parent : String
    
    enum CodingKeys: String,CodingKey{
        case id,label,parent
    }
}

public struct FAQQA : Codable{
    let faqs : [FAQS]
    
    enum CodingKeys : String,CodingKey{
       case faqs
    }
}

public struct FAQS: Codable{
    let id : String
    let question : String
    let answer : String
    let parent : String
    
    enum CodingKeys: String,CodingKey {
        case id,question,answer,parent
    }
}
