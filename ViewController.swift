//
//  ViewController.swift
//  TestProject001
//
//  Created by Mac on 27/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
  //  let userEndPoint = UserLoginEndPoint()
  //  let recipeEndPoint =  RecipeEndPoint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //Result of CompletionHandlerLogin will received here
    @IBAction func loginButtonClicked(_ sender: Any) {
      /*
        userEndPoint.userLogin(email: emailIdTextField.text ?? "", password: passwordTextField.text ?? "" ){ result in
        
            switch(result){
                case .success(let resultSuccess):
                    print("Sucess : \(resultSuccess)")
                case .failure(let resultFailure):
                    print("Failure: \(resultFailure)")
            }
        }
*/
   
    }
    
}

