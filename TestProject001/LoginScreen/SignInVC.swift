//
//  SignInVC.swift
//  TestProject001
//
//  Created by Mac on 10/04/24.
//

import UIKit


class SignInVC: UIViewController {

    
    @IBOutlet weak var signInTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        signInTableView.register(UINib(nibName: "SignInTopCell", bundle: nil), forCellReuseIdentifier: "SignInTopCell")
        
        self.signInTableView.register(UINib(nibName: "SignInBottomCell", bundle: nil), forCellReuseIdentifier: "SignInBottomCell")
   
        signInTableView.dataSource = self
        signInTableView.delegate = self
        
        
        self.signInTableView.separatorStyle = .none
        self.signInTableView.reloadData()
  
    }
    
}

extension SignInVC :UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  290
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignInTopCell", for: indexPath)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignInBottomCell", for: indexPath) as! SignInBottomCell
            cell.parentVC = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

