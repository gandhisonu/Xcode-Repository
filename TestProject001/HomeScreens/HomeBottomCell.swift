//
//  HomeBottomCell.swift
//  TestProject001
//
//  Created by Mac on 15/04/24.
//

import UIKit

class HomeBottomCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
   
    func confige(item : SideBarItems){
        self.imgView.image = item.icon
        self.titleLabel.text = item.name
    }
    func reset(){
        self.imgView.image = nil
        self.titleLabel.text = ""
    }
    
    func setupView(){
        self.mainView.backgroundColor = .white  //clear
        self.mainView.layer.cornerRadius = 20.0
        self.mainView.layer.masksToBounds = false
        self.mainView.layer.shadowOffset = CGSize(width: 0, height: 0)//
        self.mainView.layer.shadowColor = UIColor.lightGray.cgColor
        self.mainView.layer.shadowOpacity = 0.7
        self.mainView.layer.shadowRadius = 4.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        setupView()
    
    }

}
