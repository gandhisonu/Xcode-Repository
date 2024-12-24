//
//  FaqEndPoint.swift
//  TestProject001
//
//  Created by Mac on 03/04/24.
//

import Foundation
import SwiftyJSON


public class FAQEndPoint {
    
    fileprivate enum FAQApiPath:String{
        case faqLevelParent = "/faq"
        case faqQAOption = "/faq/qa"
    
    }
//MARK: FAQ
    public func getFaqLevelOption(apiVersion:String,level:String?,parent:String?, completionHandlerMain:@escaping(Result<FAQ,FAQApiError>)->Void){
        
        //Create URL
        var urlComponents = URLComponents(string: APIService.baseUrl + FAQApiPath.faqLevelParent.rawValue)
        
        //Adding QueryString for Level Parent
        urlComponents?.queryItems = [URLQueryItem]()
        
        if let levelVal =  level {
            urlComponents?.queryItems?.append(URLQueryItem(name: "level", value: levelVal))
        }
        if let parentVal =  parent {
            urlComponents?.queryItems?.append(URLQueryItem(name: "parent", value: parentVal))
        }
        
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        APIService.shared.processFAQ(url: url){ response, statusCode in
             
            if (statusCode == 400){
                completionHandlerMain(.failure(.invalidInput))
            }else if (statusCode > 400){
                completionHandlerMain(.failure(.autherror))
            }else if (statusCode >= 500){
                completionHandlerMain(.failure(.serverError))
            }else if (statusCode == 200){
                do{
                    //Encoding Response Data
                    let jsonData = try JSONEncoder().encode(response)
                    print("jsonData encoded Response  :- \(jsonData)")
                    
                    //Decoding  Dict values and Adding into Model
                    let faqObj = try JSONDecoder().decode(FAQ.self, from: jsonData) //
                    print("decoded response :- \(faqObj)")
                    completionHandlerMain(.success(faqObj))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
        
    }
//MARK: FAQ /QA
    public func getFaqQA(apiVersion:String, optionId:String?, completionHandlerMain: @escaping(Result<FAQQA,FAQApiError>)->Void){
        
        //Create URL
        var urlComponents = URLComponents(string: APIService.baseUrl + FAQApiPath.faqQAOption.rawValue)
        print(urlComponents ?? "")
        
        //Adding QueryString for option
        urlComponents?.queryItems = [URLQueryItem]()
        
        if let optionVal =  optionId {
            urlComponents?.queryItems?.append(URLQueryItem(name: "option_id", value: optionVal))
        }
        
       // urlComponents?.queryItems?.append(URLQueryItem(name: "option_id", value: optionId))
             
        //getting Basic URL from urlComponets
            guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        
        APIService.shared.processFAQ(url: url) { response, statusCode in
           
            if (statusCode == 400){
                completionHandlerMain(.failure(.invalidInput))
            }else if (statusCode > 400){
                completionHandlerMain(.failure(.autherror))
            }else if (statusCode >= 500){
                completionHandlerMain(.failure(.serverError))
            }else if (statusCode == 200){
                do{
                    //Encoding Response Data
                    let jsonData = try JSONEncoder().encode(response)
                    print("jsonData encoded Response  :- \(jsonData)")
                    
                    //Decoding  Dict values and Adding into Model
                    let faqObj = try JSONDecoder().decode(FAQQA.self, from: jsonData)
                    print("decoded response :- \(faqObj)")
                    completionHandlerMain(.success(faqObj))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
        
        
    } 
}
