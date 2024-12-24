//
//  RecipeEndPoint.swift
//  TestProject001
//  
//
//  Created by Mac on 28/03/24.
//




import Foundation
import SwiftyJSON


public class RecipeEndPoint {
    
    fileprivate enum RecipeApiPath:String{
        case recipe = "/recipes"
        case singleRecipe = "/recipes/"
    
    }
    
    
    
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
        APIService.shared.processRecipeRequest(url: url,method:HttpMethod.get, completionHandlerGetRecipe: { response, statusCode in
            
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
        
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        
        //Getting Single Recipe
        APIService.shared.processRecipeRequest(url: url,method: HttpMethod.get) { response, statusCode in
            
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
        }
    }
   
//MARK: Create New Recipe
    //recipeFile:JSON, recipeRequestObj: AddRecipeMaster, recipeId: String?
    public func createNewRecipe(apiVersion:String,recipeId:String?,recipeObj: AddRecipeMaster ,completionHandlerNewRecipe: @escaping(Result< Dictionary<String, Any> ,RecipeApiError>)->Void){
        
   //     public func createNewRecipe(apiVersion:String,recipeId:String?,recipeObj: AddRecipeMaster, completionHandlerNewRecipe: @escaping(Result< AddRecipeOutput ,RecipeApiError>)->Void){
        
        //Create URL for accessing Recipes with additional queryStrings
        var urlComponents = URLComponents(string: APIService.baseUrl + RecipeApiPath.recipe.rawValue )
        print(urlComponents)
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)

        
        APIService.shared.processPostRequestWithToken_ModelData(apiVersion: "v0", url: url,addRecipeRequest: recipeObj) { response, statusCode in
        
            if (statusCode == 400){
                completionHandlerNewRecipe(.failure(.invalidInput))
            }else if (statusCode > 400){
               completionHandlerNewRecipe(.failure(.autherror))
            }else if (statusCode >= 500){
                completionHandlerNewRecipe(.failure(.serverError))
            }else if (statusCode == 200){
                print("Response .....\(response)")
                do{
                
                    let json = JSON(try response.rawData())
                    if let result = json.dictionaryObject {
                        completionHandlerNewRecipe(.success(result))
                    }
                    //Encoding Response Data
               /*     let jsonData = try JSONEncoder().encode(response)
                    print("jsonData of encoded Response  :- \(jsonData)")
                    
                    //Decoding  Dict values and Adding into Model
                    let outputRecipe = try JSONDecoder().decode(AddRecipeOutput.self, from: jsonData)
                    print("decoded Response to Model output recipe :- \(outputRecipe)")
                    completionHandlerNewRecipe(.success(outputRecipe)) */
                }catch{
                    print(error.localizedDescription)
                    completionHandlerNewRecipe(.failure(.parseError))
                }
            }
        }
        
        
    }
    
//MARK: Delete Recipe
    public func deleteRecipe(apiVersion:String, recipeId: String, completionHandlerDelRecipe : @escaping(Result<RecipeSucessCode,RecipeApiError>)->Void) {
        
        let urlComponents = URLComponents(string: APIService.baseUrl + RecipeApiPath.singleRecipe.rawValue + recipeId)
        print(urlComponents ?? "")
        
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        //completionHandlerDeleteRecipeByID:
        APIService.shared.processRecipeRequest(url: url, method: .delete) { response, statusCode in
            
            if (statusCode == 400) {
                completionHandlerDelRecipe(.failure(.invalidInput))
            }else if (statusCode > 403){
                completionHandlerDelRecipe(.failure(.autherror))
            }else if (statusCode >= 500){
                completionHandlerDelRecipe(.failure(.serverError))
            }else if (statusCode == 200){
                do{
                    
                    let jsonData =  try JSONEncoder().encode(response)
                    print("jsonData of encoded Response  :- \(jsonData)")
                    let recipe = try JSONDecoder().decode(RecipeMaster.self, from: jsonData)
                    print("decoded Recipe to delete  :- \(recipe)")
                    completionHandlerDelRecipe(.success(.sucess))
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
}//class
    





