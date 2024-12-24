//
//  ApiServices.swift
//  TestProject001
//
//  Created by Mac on 28/03/24.
//

import Foundation
import SwiftyJSON


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

fileprivate enum HttpMethod: String {
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
            
        //Prepare URLRequest
        guard var request = prepareRequest(url: url, method: HttpMethod.post,apiVersion: apiVersion,accessToken: nil) else {
            return
        }
            
        //Creating JSON for paramters(email,password)
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
               
            // Connection Build up and unable to parse response JSON
            guard let httpResponse = response as? HTTPURLResponse else {
                   completionHandlerExecute(
                       JSON([
                       "code": APIError.PARSE_ERROR.rawValue,
                       "message": "Unable to Parse Response"]),
                   -2 )
                return
            }
              
            // Connection Build up and either data Fetched in JSON or error in response
            guard let data = data , !data.isEmpty else {
                completionHandlerExecute(JSON(),httpResponse.statusCode)
                return
            }
            
            //Converting Json data of Encoded .utf8 integer form into String
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
    public func setCurrentUser(currentUser:User){
        self._currentUser =  currentUser
    }
    
    
    
//MARK: RecipeAPI's
//MARK: Get All Recipes
    public func processGetAllRecipe(url:URL,
                completionHandlerGetRecipe: @escaping(_ response: JSON ,_ statusCode : Int)->Void){
        
        
        //Getting Access Token of current user For authorization
    /*   guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
            return
        }*/
     let accessTokenCurrentUser = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOiJkZjM1ZGMxMi1mNGE0LTQ5OTAtYjYxOS02MTBjNzVlNGMzYTgiLCJzZXNzaW9uX2lkIjoiMDgwOGViYTEtZmI2NS00Mzg4LTkzY2ItZjBiOTk5MWQwNGVkIn0sImV4cCI6MTcxNDY0NzY1ODM5NX0.U5Zx-__u_o2zOkUEtEbYf37eqywY4Q5zYx_UwaC3dNE"
        
        //prepare request
        guard let request = APIService.shared.prepareRequest(url: url, method:HttpMethod.get,apiVersion: "v0",accessToken: accessTokenCurrentUser )else {
            return
        }
        
       //Execute Request
        APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandlerGetRecipe)
        
    }
//MARK: Get Recipe By ID -2
    public func processGetRecipeByID(url:URL,apiVersion:String,
                                     completionHandleGetRecipeID:@escaping (_ response:JSON,_ statusCode:Int)->Void) {
        
        //Getting Access Token of current user For authorization
     /*   guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
            return
        }*/
        
        let accessTokenCurrentUser = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOiJkZjM1ZGMxMi1mNGE0LTQ5OTAtYjYxOS02MTBjNzVlNGMzYTgiLCJzZXNzaW9uX2lkIjoiMDgwOGViYTEtZmI2NS00Mzg4LTkzY2ItZjBiOTk5MWQwNGVkIn0sImV4cCI6MTcxNDY0NzY1ODM5NX0.U5Zx-__u_o2zOkUEtEbYf37eqywY4Q5zYx_UwaC3dNE"
        
        //prepare request
        guard let request = APIService.shared.prepareRequest(url: url, method: HttpMethod.get,apiVersion:"v0" ,accessToken: accessTokenCurrentUser) else{
            return
        }
        
        //Execute Request
        APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandleGetRecipeID)
        
    }
//MARK: Create New Recipe
//2
    public func addNewRecipe(url:URL,apiVersion:String, completionHandleAddRecipe :@escaping (_ response: JSON, _ statusCode:Int )->Void ){
        
        //Getting Access Token of current user For authorization
     /*   guard let accessTokenCurrentUser = APIService.shared.currentUser?.accessToken else{
            return
        }*/
        
        let accessTokenCurrentUser = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7InVzZXJfaWQiOiJkZjM1ZGMxMi1mNGE0LTQ5OTAtYjYxOS02MTBjNzVlNGMzYTgiLCJzZXNzaW9uX2lkIjoiMDgwOGViYTEtZmI2NS00Mzg4LTkzY2ItZjBiOTk5MWQwNGVkIn0sImV4cCI6MTcxNDY0NzY1ODM5NX0.U5Zx-__u_o2zOkUEtEbYf37eqywY4Q5zYx_UwaC3dNE"
        
        //prepare request
        guard let request = APIService.shared.prepareRequest(url: url, method: HttpMethod.post,apiVersion:"v0" ,accessToken: accessTokenCurrentUser) else{
            return
        }
        
        //Execute Request
        APIService.shared.executeRequest(request: request, completionHandlerExecute: completionHandleAddRecipe)
        
    }
   
//MARK: Reading Local JSON
    public func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
//MARK: Parsing Local JSON
    func parse(jsonData: Data) -> RecipeMaster? {
        do {
            let decodedData = try JSONDecoder().decode(RecipeMaster.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}


