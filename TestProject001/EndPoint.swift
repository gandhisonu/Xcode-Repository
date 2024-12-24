//
//  EndPoint.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
// request.setValue("application/json", forHTTPHeaderField: "Accept") not used 
/*
import Foundation
import SwiftyJSON

//let defaultApiVersion: String = "v0"
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

fileprivate enum AuthApiPath : String {
    case login = "/auth/login"
    case logout = "/auth/logout"
}

public class EndPoint {
    
    public static var baseUrl: String = BaseURL.test.value //SG
    public static let shared = EndPoint()
    
    private let REQUEST_TIMEOUT_SECS = 15.0
    private let SERVICE_REQUEST_TIMEOUT_SECS = 30.0
    
    private init() {
    }
    
//MARK: prepareRequest
    private func prepareRequest(url:URL,method: HttpMethod,apiVersion: String? = nil,accessToken: String? = nil)-> URLRequest?{
        
        //Create URLRequest
        var request = URLRequest(url:url)
        
        //Adding Headers (APIVersion) to URLRequest
        if let apiVersion = apiVersion {
            request.addValue(apiVersion, forHTTPHeaderField: "X-ARDENT-API-VERSION")
        }
        
        //Adding Headers (Authorization) to URLRequest if required
      /*  if let accessToken = accessToken {
            let token: String = "Bearer " + accessToken
            request.addValue(token, forHTTPHeaderField: "Authorization")
        }*/
        
        //Adding Method to URLRequest
        request.httpMethod = method.rawValue
        request.timeoutInterval = SERVICE_REQUEST_TIMEOUT_SECS
        return request
    }
    
//MARK: processPostRequestWithToken
    //method -post,url, headers -accept: application/json', X-ARDENT-API-VERSION: v0',Content-Type: application/json, d(paarmeters for body)- email & password in string
    public func processPostRequestWithToken(apiVersion:String,url:URL,parameters:[String:Any],completionHandlerPostReq:@escaping(_ response:JSON, _ statusCode:Int)->Void){
        
        //Prepare URLRequest
        guard var request = prepareRequest(url: url, method: HttpMethod.post,apiVersion: apiVersion) else {
            return
        }
        
        //Creating JSON for paramters(email,password)
        guard let requestBody = getJsonRequestBodyFor(params: parameters)else{
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
        let requestTask =  URLSession.shared.dataTask(with: request,completionHandler: { (data, response, error)->Void in
            
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
            completionHandlerExecute(jsonData,httpResponse.statusCode)
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
        
    
    
    
}
*/
