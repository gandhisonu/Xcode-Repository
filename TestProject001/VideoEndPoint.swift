//
//  VideoEndPoint.swift
//  TestProject001
//
//  Created by Mac on 24/05/24.
//

import Foundation


public class VideoEndPoint{
    
    fileprivate enum VideoApiPath : String {
        case  videos = "/videos"
    }
    
    public func getVideosList(apiVersion:String,categoryIDs: String?,completionHandlerMain:@escaping(Result<VideoMaster,VideoApiError>)->Void){
        
     //createURL
        var urlComponents = URLComponents(string: APIService.baseUrl + VideoApiPath.videos.rawValue)
        
     //Adding QueryString for option
        urlComponents?.queryItems = [URLQueryItem]()
        
        if let categoryId = categoryIDs {
            urlComponents?.queryItems?.append(URLQueryItem(name: "category_ids", value: categoryId))
        }
    //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        
   //calling API processVideo func
        APIService.shared.processVideo(url: url) { response, statusCode in
            
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
                    let videoObj = try JSONDecoder().decode(VideoMaster.self, from: jsonData)
                    print("decoded response :- \(videoObj)")
                    completionHandlerMain(.success(videoObj))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
        
    }
    
}
