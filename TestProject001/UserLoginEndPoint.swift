//
//  UserLoginEndPoint.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
//
/* userLogin Requirement :-
method :- post,url
Headers :-  X-ARDENT-API-VERSION: v0',
            Content-Type: application/json,
            accept: application/json(NA)
d(parmeters for body)- email & password in string */

import Foundation
import SwiftyJSON


public class UserLoginEndPoint {
    
    fileprivate enum AuthApiPath : String {
        case login = "/auth/login"
        case logout = "/auth/logout"
    }
    

    
//MARK: UserLogin
    public func userLogin(email:String,password:String,
                          CompletionHandlerLogin:@escaping(Result<User,UserApiError>)->Void){
        
        //create URL String
        guard let url = URL(string: APIService.baseUrl + AuthApiPath.login.rawValue)else {
            return
        }
        print("url  \(url)")
        
        
        //create Parameters
        let params: [String:Any] = [
            "email": email,
            "password": password,
        ]
        
   
      //Processing Post Request and Getting response and status code
        APIService.shared.processPostRequestWithToken(apiVersion: "v0", url: url, parameters: params) { response, statusCode in
       
            if (statusCode >= 400){
                CompletionHandlerLogin(.failure(.invalidInput))
            }else if (statusCode >= 500){
                CompletionHandlerLogin(.failure(.userAccountDoesNotExist))
            }else if (statusCode == 200 ){
                do {
        
                    let jsonData = try JSONEncoder().encode(response)
                    print("jsonData of encoded Response  :- \(jsonData)")
            
                    //Decoding  Dict values and Adding into Model
                   let userJson = JSON([
                    "accessToken": response["access_token"].stringValue,
                     "expiresIN" : response["expires_in"].stringValue,
                     "tokenType" : response["token_type"].stringValue,
                     "emailID" : email,
                     "password": password
                   ])
                    guard let user = User.userFromJSON(from: userJson) else{
                        return
                    }
                    APIService.shared.setCurrentUser(currentUser: user) //
                    CompletionHandlerLogin(.success(user))
                    
                   /* or do it :-
                    let jsonData =  try JSONEncoder().encode(response)
                    print("jsonData of encoded Response  :- \(jsonData)")
                    var user = try JSONDecoder().decode(User.self, from: jsonData)
                    user.emailID = email
                    user.password = password
                    print("decoded User  :- \(user)")
                    CompletionHandlerLogin(.success(user))
                    */
                    
                }catch{
                    CompletionHandlerLogin(.failure(.userAccountDoesNotExist))
                }
            }
        }
    }
    
 
    
}


