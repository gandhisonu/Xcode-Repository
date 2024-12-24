//
//  ShopEndPoint.swift
//  TestProject001
//
//  Created by Mac on 03/04/24.
//

import Foundation
import SwiftyJSON


public class ShopEndPoint{
    
    fileprivate enum ShoppingApiPath:String{
        case shopProduct = "/products"
        case shopProductList = "/products/list"
        case shopProductId = "/products/"
        case shopCategory = "/products/categories"
    }
    
//MARK: Get List of Products pagination
    public func getProducts(apiVersion:String,categoryId: String?,pageCursor:String?,pageSize:String?,completionHandlerMain: @escaping(Result<ProductMaster,ShoppingApiError>)->Void){
        
        //Create URL
        var urlComponents = URLComponents(string: APIService.baseUrl + ShoppingApiPath.shopProduct.rawValue)
        
        //Adding QueryString for categories ID
        urlComponents?.queryItems = [URLQueryItem]()
        
        if let categoryIDVal =  categoryId {
            urlComponents?.queryItems?.append(URLQueryItem(name: "category_ids", value: categoryIDVal))
        }
        if let pageCursorVal = pageCursor {
            urlComponents?.queryItems?.append(URLQueryItem(name: "page_cursor", value: pageCursorVal))
        }
        if let pageSizeVal = pageSize {
            urlComponents?.queryItems?.append(URLQueryItem(name: "page_size", value: pageSizeVal))
        }
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        APIService.shared.processGetAllProducts(url:url,method:HttpMethod.get) { response, statusCode in
             
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
                    let product = try JSONDecoder().decode(ProductMaster.self, from: jsonData)
                    print("decoded response :- \(product)")
                    completionHandlerMain(.success(product))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
        
    }
//MARK: Get List of Products.(only Id and Name)
    public func getProductsList(apiVersion:String,completionHandlerMain: @escaping(Result<ShopProductList,ShoppingApiError>)->Void){
        
        //Create URL
        var urlComponents = URLComponents(string: APIService.baseUrl + ShoppingApiPath.shopProductList.rawValue)
        print(urlComponents)
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        APIService.shared.processGetAllProducts(url:url,method: HttpMethod.get) { response, statusCode in
             
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
                    let product = try JSONDecoder().decode(ShopProductList.self, from: jsonData)
                    print("decoded response :- \(product)")
                    completionHandlerMain(.success(product))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
    }
//MARK: Get List of Products by Prodyct Id.
    public func getProductById(apiVersion:String,productid: String, completionHandlerMain:@escaping(Result<Product,ShoppingApiError>)->Void){
        
        //Create URL
        var urlComponents = URLComponents(string: APIService.baseUrl + ShoppingApiPath.shopProductId.rawValue + productid)
        print(urlComponents)
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        APIService.shared.processGetAllProducts(url:url,method:HttpMethod.get) { response, statusCode in
            
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
                    let product = try JSONDecoder().decode(Product.self, from: jsonData)
                    print("decoded response :- \(product)")
                    completionHandlerMain(.success(product))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
    }
//MARK: Get List of Products by Category Id.
    public func getProductByCategory(apiVersion:String,completionHandlerMain:@escaping(Result<productCategories,ShoppingApiError>)->Void){
        
        //Create URL
        var urlComponents = URLComponents(string: APIService.baseUrl + ShoppingApiPath.shopCategory.rawValue )
        print(urlComponents)
        
        //getting Basic URL from urlComponets
        guard let url = urlComponents?.url else {
            return
        }
        print(url)
        
        APIService.shared.processGetAllProducts(url:url,method:HttpMethod.get) { response, statusCode in
            
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
                    let product = try JSONDecoder().decode(productCategories.self, from: jsonData)
                    print("decoded response :- \(product)")
                    completionHandlerMain(.success(product))
                }catch{
                    print(error.localizedDescription)
                    completionHandlerMain(.failure(.parseError))
                }
            }
        }
    }
    
}




