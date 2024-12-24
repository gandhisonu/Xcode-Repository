//
//  ApiServices.swift
//  TestProject001
//
//  Created by Mac on 28/03/24.
//

import Foundation
import SwiftyJSON
import UIKit


fileprivate enum BaseURL {
    case test
    case prod
    
    var value: String {
        switch (self) {
        case .test:
            return "https://4dygr3pjy7.execute-api.us-east-2.amazonaws.com/prod"
        case .prod:
            return "https://4dygr3pjy7.execute-api.us-east-2.amazonaws.com/prod"
        }
    }
}

public enum HttpMethod: String {
    case post = "POST"
    case get = "Get"
    case delete = "Delete"
}



public class APIService {
    
    public static var baseUrl: String = BaseURL.test.value //SG
    public static let shared = APIService()
    
    private let REQUEST_TIMEOUT_SECS = 15.0
    private let SERVICE_REQUEST_TIMEOUT_SECS = 30.0
    
    private init() {
    }
    
    private var _currentUser: User?
    public var currentUser: User?{
        get {
            return self._currentUser
        }
    }

    var localJsonRecipeData : RecipeMaster?
    
    let defaults = UserDefaults.standard
    
//MARK: prepareRequest
    private func prepareRequest(url:URL,method: HttpMethod,apiVersion: String? = nil,accessToken: String? = nil)-> URLRequest?{
            
        //Create URLRequest from url
        var request = URLRequest(url:url)
            
        //Adding Headers (APIVersion) to URLRequest
        if let apiVersion = apiVersion {
            request.addValue(apiVersion, forHTTPHeaderField: "X-ARDENT-API-VERSION")
        }
           
        //Adding Headers (Authorization) to URLRequest if required
          if let accessToken = accessToken {
            let token: String = "Bearer " + accessToken
            request.addValue(token, forHTTPHeaderField: "Authorization")
          }
      
        
        //Adding Method to URLRequest
        request.httpMethod = method.rawValue
        request.timeoutInterval = SERVICE_REQUEST_TIMEOUT_SECS
        return request
    }

//MARK: processPostRequestWithToken
    //method -post,url, headers -accept: application/json', X-ARDENT-API-VERSION: v0',Content-Type: application/json, d(paarmeters for body)- email & password in string
    public func processPostRequestWithToken(apiVersion:String,url:URL,parameters:[String:Any], completionHandlerPostReq:@escaping(_ response:JSON, _ statusCode:Int)->Void){
        
   
        //Getting Access Token of current user For authorization
        let accessTokenCurrentUser : String
        if ((APIService.shared.currentUser) != nil) {
            accessTokenCurrentUser = (APIService.shared.currentUser?.accessToken)!
        }else{
            accessTokenCurrentUser = ""
        }
   
        
        //Prepare URLRequest
        guard var request = prepareRequest(url: url, method: HttpMethod.post,apiVersion: apiVersion,accessToken: accessTokenCurrentUser) else {
            return
        }
            
        //Creating JSON for paramters(like email,password)
        guard let requestBody = getJsonRequestBodyFor(params:parameters)else{
            return
        }
            
        //Adding Encoded  8 bit integer value(converting JSON String into Encoded 8 bit integer)as Body to URLRequest
        request.httpBody = Data(requestBody.utf8)
            
        //Adding value application/json for Header Feild Content-Type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
            
        //completionHandlerExecute output will be recived in completionHandlerPostReq
        executeRequest(request: request, completionHandlerExecute: completionHandlerPostReq)
        
    }
    
    //MARK: processPostRequestWithToken_ModelData
        //method -post,url, headers -accept: application/json', X-ARDENT-API-VERSION: v0',Content-Type: application/json, d(paarmeters for body)- ModelData
        public func processPostRequestWithToken_ModelData(apiVersion:String,url:URL,addRecipeRequest:AddRecipeMaster, completionHandlerPostReq:@escaping(_ response:JSON, _ statusCode:Int)->Void){
            
       
            //Getting Access Token of current user For authorization
            let accessTokenCurrentUser : String
            if ((APIService.shared.currentUser) != nil) {
                accessTokenCurrentUser = (APIService.shared.currentUser?.accessToken)!
            }else{
                accessTokenCurrentUser = ""
            }
       
            
            //Prepare URLRequest
            guard var request = prepareRequest(url: url, method: HttpMethod.post,apiVersion: apiVersion,accessToken: accessTokenCurrentUser) else {
                return
            }
           
            do{
                let encodedRequest = try JSONEncoder().encode(addRecipeRequest)
                request.httpBody = encodedRequest
                print("Add Recipe Request Param String ======= \(String(data: encodedRequest, encoding: .utf8) ?? "")")
                    
                }catch(let error){
                    print("JSONEncoder error \(error.localizedDescription)")
                }
            
          /*  do{
                let addRecipeJson :[String:Any] =
                    ["title": "Delicious Pasta",
                     "categoryIDs":["345a6789-bcde-01fg-234h-567890123456","456e7890-12ab-34cd-56ef-789012345678"],
                     "deviceID": "123e4567-e89b-12d3-a456-426614174001",
                     "ingredients": "Pasta, Tomato Sauce, Cheese",
                     "equipments": "Pot, Oven, Knife",
                     "steps": ["info":["mode":"m1","temp":"t1","tempUnit":"F","description":"test"],
                         "assets": ["assetType": "","assetURL":"https://s3.example.com/step1_image.png"] ,"uploadAssets": []
                              ],
                     "uploadAsset": "" ]
                let recipeJsonData = try? JSONSerialization.data(withJSONObject: addRecipeJson)
                request.httpBody  = recipeJsonData
            }*/
                
            //Adding value application/json for Header Feild Content-Type
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
            print(request) //tobe remove
                
            //completionHandlerExecute output will be recived in completionHandlerPostReq
            executeRequest(request: request, completionHandlerExecute: completionHandlerPostReq)
            
        }
//MARK: Execute Request
    private func executeRequest(request:URLRequest ,completionHandlerExecute: @escaping(_ response:JSON , _ statusCode :Int)->Void ){
           
        //Creating Session for URLRequest with Server for feting data
        let requestTask =  URLSession.shared.dataTask (with: request,completionHandler: { (data, response, error)->Void in
           
            
            //If Error in Network
            if error != nil {
                completionHandlerExecute(
                    JSON([
                    "code": APIError.NETWORK_ERROR.rawValue,
                    "message": "Netwrok Error"]),
                -1)
                return
            }
               
            guard let httpResponse = response as? HTTPURLResponse else {
                   completionHandlerExecute(
                       JSON([
                       "code": APIError.PARSE_ERROR.rawValue,
                       "message": "Unable to Parse Response"]),
                   -2 )
                return
            }
              
          
            guard let data = data , !data.isEmpty else {
                completionHandlerExecute(JSON(),httpResponse.statusCode)
                return
            }
            
            //Converting Json data  into String
            let string = String(data: data, encoding: .utf8)!
            print("data in encoded bytes /response status code .:- \(data)...\(httpResponse.statusCode)")
            print("Output String====>\(string)")
               
               
            //Converting encoded data into JSON Dict or error
            guard let jsonData = try? JSON(data: data) else {
                completionHandlerExecute(
                    JSON([
                        "code": APIError.PARSE_ERROR.rawValue,
                        "message": "Unable to parse response data"
                    ]),
                    -2
                   )
                return
               }
            print("json data/response fom Execute:- \(jsonData),\(httpResponse.statusCode)")
            //sending back JSONData Dict or ErrorCode to Executerequest's CompletionHandler
            completionHandlerExecute (jsonData, httpResponse.statusCode)
        })
        requestTask.resume()
    }

    
//MARK: getJsonRequestBodyForParam
    private func getJsonRequestBodyFor(params: [String: Any]) -> String? {
        let paramJson = JSON(params)
        print("param Json...:- \(paramJson)") // JSON Dictionary
         
        //converting JSON Dictionery into String by adding "\" in json dictionory
        let jsonString =  paramJson.rawString([.castNilToNSNull : true,.jsonSerialization: JSONSerialization.WritingOptions.withoutEscapingSlashes])
        print(jsonString)
        return jsonString
           
    }
    
//MARK: currentUser
    public func setCurrentUser(currentUser:User?){
        self._currentUser =  currentUser
    }
    

    
//MARK: RecipeAPI's
    public func processRecipeRequest(url:URL, method:HttpMethod,
                completionHandlerGetRecipe: @escaping(_ response: JSON ,_ statusCode : Int)->Void){
        
        
        //Getting Access Token of current user For authorization
       guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
            return
        }

        //prepare request
        guard let request = APIService.shared.prepareRequest(url: url, method:method ,apiVersion: "v0",accessToken: accessTokenCurrentUser )else {
            return
        }
        
       //Execute Request
        APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandlerGetRecipe)
        
    }

    
   
//MARK: Reading Local JSON
    func loadJsonString(fileName:String)->String?{
        guard let localJSONURL = Bundle.main.url(forResource: fileName , withExtension: "json"),
            let data = try? Data(contentsOf: localJSONURL) else{ return nil }
      
        let jsonString =  String(data: data, encoding: .utf8)
        return jsonString
    }


    func fetchLocalJSONData() -> RecipeMaster? {
        let localUrl = Bundle.main.url(forResource: "NewRecipe", withExtension: "json")!
        do{
            let data = try Data(contentsOf: localUrl)
            print("data \(data)")
            let jsonData =  try JSONDecoder().decode(RecipeMaster.self, from: data)
            print("local json Data :- \(jsonData)")
        }catch{
            print(error)
        }
        return localJsonRecipeData
     
    }
    
    
//MARK: Shopping GET All Products
    public func processGetAllProducts(url:URL,method:HttpMethod ,completionHandlerProcessProducts: @escaping (_ response:JSON, _ statusCode: Int)->Void){
        
        
         //Getting Access Token of current user For authorization
           guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
             return
         }
        
        //prepare request
        guard let request = APIService.shared.prepareRequest(url: url, method:method,apiVersion: "v0",accessToken: accessTokenCurrentUser) else {
            return
        }
        
       //Execute Request
        APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandlerProcessProducts)
    }
  
    
//MARK: FAQ 
    public func processFAQ(url:URL,completionHandlerFAQ: @escaping (_ response:JSON, _ statusCode: Int)->Void){
            
            
             //Getting Access Token of current user For authorization
               guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
                 return
             }
      
            
            //prepare request
            guard let request = APIService.shared.prepareRequest(url: url, method: HttpMethod.get,apiVersion: "v0",accessToken: accessTokenCurrentUser) else {
                return
            }
            
           //Execute Request
            APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandlerFAQ)
        }
    
//MARK: Videos
    //as per SwaggerEditor -URL having request query result will be statuscode with json
    public func processVideo(url:URL,completionHandlerVideo:@escaping(_ response:JSON , _ statusCode:Int)->Void){
        
        //Getting Access Token of current user For authorization
          guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
            return
        }
        
        //prepare request -commonly used by all
        guard let request = APIService.shared.prepareRequest(url: url, method: HttpMethod.get,apiVersion: "v0",accessToken: accessTokenCurrentUser) else {
            return
        }
        
       //Execute Request  -commonly used by all
        APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandlerVideo)
    }
}



 
 
