//
//  shopHeaderCell.swift
//  TestProject001
//
//  Created by Mac on 25/04/24.
//

import UIKit

class shopHeaderCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!

    func reset(){
        self.productName.text = " "
    }
   
    //Issue>>>>>
    func config(prod: ShopProduct){
        self.productName.text = prod.name
    }
    
    override func awakeFromNib() {
    reset()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
}
