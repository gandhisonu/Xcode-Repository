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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
         //SG280324
    /*    let userEndPoint = UserLoginEndPoint()
        userEndPoint.userLogin(email: "testmaster@iotfy.com",
                               password: "test@123") { result in   //
            switch(result){
                case .success(let resultSucess):
                    print(resultSucess)
                case .failure(let resultError):
                    print(resultError)
            }
            //print(APIService.shared.currentUser?.accessToken);
          
        }*/
        //SG280324
        
        //SG290324
        let recipeEndPoint =  RecipeEndPoint()
    //creatorId:"5f07af46-ae1f-4a87-9b95-dfb2b135440b"
     /*   recipeEndPoint.getAllRecipes(apiVersion: "v0", state: nil, categoryId: nil, creatorId: nil,
                        ardentRecipes: false) { recipeResult in
            
            print(APIService.shared.currentUser?.accessToken);
            switch(recipeResult){
                case .success(let resultRecipe):
                     print("Sucess : \(resultRecipe)")
                case .failure(let resultError):
                    print("Failure : \(resultError)")
            }
        }
        */
        /*
        recipeEndPoint.getRecipeByID(apiVersion: "v0", recipeId: "2f4c6664-b04e-4401-9521-4f1f4826892e") { result in
            
            switch (result){
                case .success(let resultRecipe):
                    print("Sucess : \(resultRecipe)")
                case .failure(let resultError):
                    print("Failure : \(resultError)")
            }
        }
         
        */
        
        if let file = Bundle.main.path(forResource: "NewRecipe", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = try JSON(data: data)
                viewController.json = json
            } catch {
                viewController.json = JSON.null
            }
        } else {
            viewController.json = JSON.null
        }
        
        
        //recipeFile: APIService.shared.readLocalJSONFile(forName: NewRecipe
        recipeEndPoint.createNewRecipe(apiVersion: "v0",recipeFile: APIService.shared.readLocalJSONFile(forName: "NewRecipe")){ result in
            switch (result){
                case .success(let resultRecipe):
                    print("Sucess : \(resultRecipe)")
                case .failure(let resultError):
                    print("Failure : \(resultError)")
            }
        }
        
        
        
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


}

