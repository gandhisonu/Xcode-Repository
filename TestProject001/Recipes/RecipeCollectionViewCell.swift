//
//  RecipeCollectionViewCell.swift
//  TestProject001
//
//  Created by Mac on 22/04/24.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView :UIView!
    @IBOutlet weak var recipeCategoryBtn : UIButton!
    
    func confige(_ btnName:String,btnBgColor:String,btnTextColor:String){
        
        self.recipeCategoryBtn.setTitle(btnName, for: .normal)
        self.recipeCategoryBtn.backgroundColor = UIColor(hexString: btnBgColor)
        self.recipeCategoryBtn.titleLabel?.textColor = UIColor(hexString: btnTextColor)
      
   
        
        //To Round the corners
        recipeCategoryBtn.layer.cornerRadius = 20
        recipeCategoryBtn.clipsToBounds = false
        
        //To Provide Shadow
        recipeCategoryBtn.layer.shadowRadius = 10
        recipeCategoryBtn.layer.shadowOpacity =  0.9
    // recipeCategoryBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        recipeCategoryBtn.layer.shadowColor = UIColor.gray.cgColor
      
        recipeCategoryBtn.layer.masksToBounds = true //SG n
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

}
