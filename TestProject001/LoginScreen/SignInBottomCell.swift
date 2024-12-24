//email: "testmaster@iotfy.com",
//password: "test@123"
//  SignInBottomCell.swift
//  TestProject001
//
//  Created by Mac on 10/04/24.
//

import UIKit



class SignInBottomCell: UITableViewCell {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    
    @IBOutlet weak var loginButton: AppButton!
    
    var parentVC : UIViewController?
 
    
    @IBOutlet weak var loadingView: UIView!{
        didSet{
            loadingView.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hideSpinner()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
//MARK: Activity Handler
    private func showSpinner() {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        
    }

//MARK: Activity Handler
    private func hideSpinner() {
        activityIndicator.stopAnimating()
        activityIndicator.color = .purple
        loadingView.isHidden = true

    }
//MARK: Password Toggle
    @IBAction func passwordToggle(_ sender: Any) {
        passwordTextFeild.isSecureTextEntry = !passwordTextFeild.isSecureTextEntry
       
    }
//MARK: Email Validate
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
       // "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
//MARK: Password Validate
    func validatePassword(password: String) -> Bool {
        
        return true
        
        let passwordRegex =
        //"^(?=.*[A-Za-z])(?=.*[!@#$&*])(?=.*\\d)[A-Za-z\\d]{8,}$"
        "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
       // print(password)
        print(passwordPredicate.evaluate(with: password))
        return passwordPredicate.evaluate(with: password)
    }

    
    @IBAction func loginButtonClicked(_ sender: Any ) {

        if (self.emailTextField.text!.isEmpty  || self.passwordTextFeild.text!.isEmpty ){
          let  alert = UIAlertController(title: "Sign In Error", message: "You must enter a username and password", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(OKAction)
            parentVC?.present(alert, animated: true)
            return
            }
        let email = isValidEmail(email: emailTextField.text!)
        //let password = validatePassword(password:self.passwordTextFeild.text!)
        
        //"\(self.passwordTextFeild.text!)")
        
        let password = validatePassword(password:"Test@123")
        
        if (email == false) { //}|| (password == false) {
            let  alert = UIAlertController(title: "Sign In Error.", message: "Invalid Email or Password", preferredStyle: .alert)
              let OKAction = UIAlertAction(title: "Ok", style: .default)
              alert.addAction(OKAction)
              parentVC?.present(alert, animated: true)
              return
        }
        self.showSpinner()
        let userEndPoint = UserLoginEndPoint()
        userEndPoint.userLogin(email: self.emailTextField.text!, password: self.passwordTextFeild.text!) { user in
           
            switch(user){
                case.success(let successResult):
                    print(successResult)
                    self.hideSpinner()
                    //
                    APIService.shared.defaults.set(true, forKey: "isUserLogIn")
                    APIService.shared.defaults.storeData(successResult, key: "userData")
                    APIService.shared.defaults.synchronize()//
                    DispatchQueue.main.async {
                        self.parentVC?.navigationController?.pushViewController(HomeVC(), animated: true)
                    }
                case .failure(let failureResult):
                    print(failureResult)
                    self.hideSpinner()
            }
            
        }
        
    }
    
    
}
