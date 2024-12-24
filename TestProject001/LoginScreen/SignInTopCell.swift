//
//  SignInTopCell.swift
//  TestProject001
//
//  Created by Mac on 10/04/24.
//

import UIKit

class SignInTopCell: UITableViewCell {

    @IBOutlet weak var signInTopView: AppView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //E0C1F1
     //   self.signInTopView.applyGradient(firstColor: UIColor(red: 0xE0, green: 0xC1, blue: 0xFC, alpha: 0.5), SecoundColor: UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, alpha: 0.5))
      //  self.signInTopView.applyGradient()
       
        self.signInTopView.addGradient([UIColor(hexString: "#E0C1F1"),UIColor(hexString: "#FFFFFF")], locations: [0.0,0.1],viewToApply: self.signInTopView)
        //frame: self.signInTopView.frame
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


