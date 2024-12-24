//
//  RecipeEndPoint.swift
//  TestProject001
//  
//
//  Created by Mac on 28/03/24.
//
/* Get All Recipes Requirement :-
 method :- get,url
 Headers :-  X-ARDENT-API-VERSION: v0,
             accept: application/json(NA)
 query items:- category_ids,state,creator_id,ardent_recipes
 */



import Foundation
import SwiftyJSON


public class RecipeEndPoint {
    
    fileprivate enum RecipeApiPath:String{
        case recipe = "/recipes"
        case singleRecipe = "/recipes/"
    
    }
    
    var json: JSON = JSON.null
    
//MARK: Get All Recipes
    public func getAllRecipes(apiVersion: String,state:String?,categoryId:String?,creatorId:String?,ardentRecipes:Bool?, completionHandlerRecipe:@escaping(Result<RecipeMaster,RecipeApiError>)->Void) {
        
        //Create URL for accessing Recipes with additional queryStrings
        var urlComponents =  URLComponents(string: APIService.baseUrl +
                                           RecipeApiPath.recipe.rawValue)
        
        print("url to get all Recipes :- \(urlComponents)")
        
        
        //appending queryItems in URLComopnents to create queryString
        urlComponents?.queryItems = [URLQueryItem]()
        
        //Creating ueryString creatorId
        if let createrIdVal = creatorId {
            urlComponents?.queryItems?.append(URLQueryItem(name: "creator_id", value: createrIdVal))
        }else if ardentRecipes == true  {
            urlComponents?.queryItems?.append(URLQueryItem(name: "ardent_recipes", value: "true"))
        }
        
        //Creating ueryString categoryId
        if let categoryID = categoryId {
            urlComponents?.queryItems?.append(URLQueryItem(name:"category_ids", value: categoryID))
        }
        //Creating ueryString State
        if let stateVal = state {
            urlComponents?.queryItems?.append(URLQueryItem(name: "state", value: stateVal))
        }
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        
        //Getting Recipes
        APIService.shared.processGetAllRecipe(url: url, completionHandlerGetRecipe: { response, statusCode in
            //  APIService.shared.processGetAllRecipe(url: url) { response, statusCode in
            
            if (statusCode == 400){
                completionHandlerRecipe(.failure(.invalidInput))
            }else if (statusCode > 400){
                completionHandlerRecipe(.failure(.autherror))
            }
            else if (statusCode >= 500){
                completionHandlerRecipe(.failure(.serverError))
            }else if (statusCode == 200){
                do{
                    //Encoding Response Data
                    let jsonData = try JSONEncoder().encode(response)
                    print("jsonData encoded Response  :- \(jsonData)")
                    
                    //Decoding  Dict values and Adding into Model
                    let recipe = try JSONDecoder().decode(RecipeMaster.self, from: jsonData)
                    print("decoded response :- \(recipe)")
                    completionHandlerRecipe(.success(recipe))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerRecipe(.failure(.parseError))
                }
            }//200
        } )
        
    }
 
    
  //MARK: getRecipeByID 1
    public func getRecipeByID(apiVersion: String, recipeId:String, completionHandlerRecipeByID : @escaping (Result<RecipeMaster,RecipeApiError>)->Void){
        
        //Create URL for accessing Recipes with additional queryStrings
        var urlComponents = URLComponents(string: APIService.baseUrl + RecipeApiPath.singleRecipe.rawValue + recipeId)
        print(urlComponents)
        
        
        //appending queryItems in URLComopnents to create queryString
       // urlComponents?.queryItems = [URLQueryItem]()
        //Creating queryString RecipeId
       // urlComponents?.queryItems?.append(URLQueryItem(name: "id", value: recipeId))
     
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        
        //Getting Single Recipe
        APIService.shared.processGetRecipeByID(url: url, apiVersion: apiVersion, completionHandleGetRecipeID: { response, statusCode in
            
            if (statusCode == 400){
                completionHandlerRecipeByID(.failure(.invalidInput))
            }else if (statusCode > 400){
                completionHandlerRecipeByID(.failure(.autherror))
            }else if (statusCode >= 500){
                completionHandlerRecipeByID(.failure(.serverError))
            }else if (statusCode == 200){
                do {
                    //Encoding Response Data
                    let jsonData = try JSONEncoder().encode(response)
                    print("jsonData of encoded Response  :- \(jsonData)")
                    
                    //Decoding  Dict values and Adding into Model
                    let singleRecipe = try JSONDecoder().decode(RecipeMaster.self, from: jsonData)
                    print("decoded Response to Model  :- \(singleRecipe)")
                    completionHandlerRecipeByID(.success(singleRecipe))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerRecipeByID(.failure(.parseError))
                }
                
            }//200
        })
    }
   
//MARK: Create New Recipe
    /* Requirements :-//method -post,
        url-"https://4dygr3pjy7.execute-api.us-east-2.amazonaws.com/prod/recipes"
        headers -accept: application/json',
                X-ARDENT-API-VERSION: v0',
                Content-Type: application/json,
        d(paarmeters for body)- Recipe Master JSON
    */
    //recipeFile:JSON,
    public func createNewRecipe(apiVersion:String,recipeFile:JSON, completionHandlerNewRecipe: @escaping(Result<RecipeMaster,RecipeApiError>)->Void){
        
        //Create URL for accessing Recipes with additional queryStrings
        var urlComponents = URLComponents(string: APIService.baseUrl + RecipeApiPath.recipe.rawValue )
        print(urlComponents)
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        APIService.shared.addNewRecipe(url: url, apiVersion: apiVersion) { response, statusCode in
            
            if (statusCode == 400){
                completionHandlerNewRecipe(.failure(.invalidInput))
            }else if (statusCode > 400){
               completionHandlerNewRecipe(.failure(.autherror))
            }else if (statusCode >= 500){
                completionHandlerNewRecipe(.failure(.serverError))
            }else if (statusCode == 200){
                do{
                    
                    
                    
                    let jsonData = APIService.shared.readLocalJSONFile(forName: "NewRecipe")
                    if let data = jsonData{
                        if let recipeObj = APIService.shared.parse(jsonData: data){
                            print("recipe \(recipeObj.recipes)")
                        }
                            
                    }
                   // completionHandlerNewRecipe(.success(newRecipe))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerNewRecipe(.failure(.parseError))
                }
            }
        }
        
        
    }
    
}//class
    





