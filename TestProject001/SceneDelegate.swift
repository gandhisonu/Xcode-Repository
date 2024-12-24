//
//  SceneDelegate.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navController = UINavigationController() //SG

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
       guard let _ = (scene as? UIWindowScene) else { return }
        
        //SG
       guard let windowScene = (scene as? UIWindowScene) else { return }
        let windowLocal = UIWindow(windowScene: windowScene)
        
        //UserDefault 
        if APIService.shared.defaults.bool(forKey: "isUserLogIn") == true {
            let usr : User? = APIService.shared.defaults.retrieveData(for: "userData")
            print("userdata:- \(usr)")
            APIService.shared.setCurrentUser(currentUser: usr) //
          self.navController.pushViewController(HomeVC(), animated: false)
        }else{
            navController = moveToLoginScreen()
        }
    
        navController.navBarAppearance()
        navController.isNavigationBarHidden = false
        windowLocal.rootViewController = navController
        self.window = windowLocal
        windowLocal.makeKeyAndVisible()
        //SG
     
   
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


    //SG
    func moveToLoginScreen()->UINavigationController {
        let navigationController = UINavigationController.init(rootViewController: SignInVC())
        navigationController.isNavigationBarHidden = true
        return navigationController
    }

    
    func moveToHomeScreen()->UINavigationController{
        let navigationController = UINavigationController.init(rootViewController:   MainViewController()) //HomeVC()) 
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
    
    
}

