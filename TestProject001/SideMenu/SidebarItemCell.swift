//
//  SidebarItemCell.swift
//  TestProject001
//
//  Created by Mac on 16/04/24.
//

import UIKit

class SidebarItemCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    private func reset(){
        self.iconImg.image = nil
        self.itemLabel.text = ""
    }
    func configue(item: SideBarItems){
         self.iconImg.image = item.icon
         self.itemLabel.text = item.name
         if itemLabel.text == "Log out" {
             itemLabel.textColor = .red
         }
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
