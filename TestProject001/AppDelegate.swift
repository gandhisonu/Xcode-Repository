//
//  AppDelegate.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
// //testmaster@ardent.com" //testmaster@iotfy.com
//password: "test@123"


import UIKit
import SwiftyJSON

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? //SG
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //sg
     
    //   let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //    let navigationController = UINavigationController()
     /*   navigationController.pushViewController(SignInVC(), animated: true)
        
        appDelegate.window? = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = navigationController
        self.window = appDelegate.window
    
        self.window?.makeKeyAndVisible()
        */

        
       
/*
        //MARK: User Login
        let userEndPoint = UserLoginEndPoint()  //SG280324
        userEndPoint.userLogin(email: "testmaster@iotfy.com",
                               password: "test@123") { user in
            switch(user) {
                case .success(let resultSucess):
                  
                    
                  //  self.getReceipes() //to be used
                  //  self.getRecipeById()
                   // self.deleteReceipe()
                    
                   // self.shopProducts()
                   self.shopProductList() // to be used
                   // self.shopProductById()
                   // self.shopProductByCategory()
                    
                   // self.faqLevelOption()
                 //   self.getFaqQA()
                    
                    print(resultSucess)
                case .failure(let resultError):
                    print(resultError)
            }
            
        }
        
     */
          
        
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func deleteReceipe() {
        //MARK: Delete recipes by ID's
        //Recipe ID:-
        //9f287885-7501-4a6f-9aab-c881fe7fcf05 tr1 (dhurv upadhyay)
        //b545eaed-6ef5-43ec-a91c-bcf055fd52ac  tr1
        
        let recipeEndPoint =  RecipeEndPoint()
        recipeEndPoint.deleteRecipe(apiVersion: "v0", recipeId: "cc590457-7d69-47b5-bfaa-84aeb7627e73") { resultDel in
            
            switch(resultDel) {
                case .success(let delRecipe):
                    print(delRecipe)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
  public  func getReceipes() {
        
        //MARK: Recipes
        //MARK: Get All recipes
        //creatorId:"5f07af46-ae1f-4a87-9b95-dfb2b135440b"
        
        let recipeEndPoint =  RecipeEndPoint()
        recipeEndPoint.getAllRecipes(apiVersion: "v0", state: nil, categoryId: nil, creatorId: nil,
                                     ardentRecipes: false) { recipeResult in
            
            switch(recipeResult) {
                case .success(let resultRecipe):
                    print("Sucess : \(resultRecipe)")
                case .failure(let resultError):
                    print("Failure : \(resultError)")
            }
        }
    }
    
    func getRecipeById(){
        let recipeEndPoint =  RecipeEndPoint()
        //b545eaed-6ef5-43ec-a91c-bcf055fd52ac
        //MARK: Get  recipes by ID's
        //recipeId: "2f4c6664-b04e-4401-9521-4f1f4826892e"
             recipeEndPoint.getRecipeByID(apiVersion: "v0", recipeId: "2c801cf0-bd87-4d06-8e7d-c9822b65d27d") { result in
                 
         switch (result){
         case .success(let resultRecipe):
         print("Sucess : \(resultRecipe)")
         case .failure(let resultError):
         print("Failure : \(resultError)")
         }
         }
         
    }
    //MARK: Add recipes
    /* not done 
     let test = APIService.shared.loadJsonString(fileName: "NewRecipe")
     
     //recipeFile: APIService.shared.readLocalJSONFile(forName: NewRecipe
     recipeEndPoint.createNewRecipe(apiVersion: "v0",recipeFile:NewRecipe.json ){ result in
     switch (result){
     case .success(let resultRecipe):
     print("Sucess : \(resultRecipe)")
     case .failure(let resultError):
     print("Failure : \(resultError)")
     }
     }
     */

    
    
    
//MARK: Shopping
//MARK: Getting Products / categoryId
    func shopProducts(){
        //categoryId: "82505252-d2bd-46cd-9750-97fbc17faa6f"
        let shopEndPoint =  ShopEndPoint()
         shopEndPoint.getProducts(apiVersion: "v0", categoryId: "82505252-d2bd-46cd-9750-97fbc17faa6f",pageCursor: nil,pageSize: nil) { productMaster in
         switch (productMaster){
             case .success(let sucessProduct):
                print(sucessProduct)
         case .failure(let errorProduct):
                    print(errorProduct)
         }
         }
         
    }
//MARK: Getting Products List
    func shopProductList(){
        let shopEndPoint =  ShopEndPoint()
        shopEndPoint.getProductsList(apiVersion: "v0"){ productList in
         switch (productList){
             case .success(let sucessProduct):
                 print(sucessProduct)
             case .failure(let errorProduct):
                 print(errorProduct)
            }
         }
    }
     
//MARK: Getting Products List by Product Id
    func shopProductById(){
        let shopEndPoint =  ShopEndPoint()
        shopEndPoint.getProductById(apiVersion: "v0", productid: "a85c22e0-8644-41a6-ac0e-7e2f89cb4727"){ resultProduct in
       switch (resultProduct){
           case .success(let sucessProduct):
               print(sucessProduct)
           case .failure(let errorProduct):
               print(errorProduct)
       }
       }
    }
    
//MARK: Getting Products List by Categories
    func shopProductByCategory(){
        let shopEndPoint =  ShopEndPoint()
        //Category:- 82505252-d2bd-46cd-9750-97fbc17faa6f"
        shopEndPoint.getProductByCategory(apiVersion: "v0") { productCategory in
         switch (productCategory){
             case .success(let sucessProduct):
                 print(sucessProduct)
             case .failure(let errorProduct):
                 print(errorProduct)
            }
         }
         
    }
    

//MARK: FAQ
//MARK: FAQ level parent
    func faqLevelOption(){
        let faqEndPoint =  FAQEndPoint()
        faqEndPoint.getFaqLevelOption(apiVersion: "v0", level: "2", parent: "3") { result in
        switch (result){
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }
    }

//MARK: FAQ QA
    func getFaqQA(){
        let faqEndPoint =  FAQEndPoint()
        faqEndPoint.getFaqQA(apiVersion: "v0",optionId: "3"){ result in
        switch (result){
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

