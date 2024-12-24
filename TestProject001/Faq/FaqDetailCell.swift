//
//  FaqDetailCell.swift
//  TestProject001
//
//  Created by Mac on 03/05/24.
//

import UIKit

class FaqDetailCell: UITableViewCell {
    
    @IBOutlet weak var btnHideUnhide: UIButton!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var plusMinusImgView : UIImageView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView :UIView!
    @IBOutlet weak var detailedTextView : UITextView!

   
    
    func reset(){
        self.titleLabel.text = ""
        self.detailedTextView.text = ""
        
    }
//MARK: QA configration in cell
    func configQA(faqQ:FAQS){
        self.titleLabel.text = faqQ.question
        self.detailedTextView.text = faqQ.answer
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       reset()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
    
}
