//
//  HomeTopCell.swift
//  TestProject001
//
//  Created by Mac on 12/04/24.
//

import UIKit

class HomeTopCell: UICollectionViewCell {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.layer.cornerRadius = 20.0
        self.imgView.clipsToBounds = true

        self.mainView.backgroundColor = .clear
        self.mainView.layer.cornerRadius = 20.0
        self.mainView.layer.masksToBounds = false
        self.mainView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.mainView.layer.shadowColor = UIColor.lightGray.cgColor
        self.mainView.layer.shadowOpacity = 0.7
        self.mainView.layer.shadowRadius = 4.0
    }

}
