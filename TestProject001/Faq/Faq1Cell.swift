//
//  Faq1Cell.swift
//  TestProject001
//
//  Created by Mac on 01/05/24.
//

import UIKit

class Faq1Cell: UITableViewCell {

    @IBOutlet weak var lblText : UILabel!
    @IBOutlet weak var mainView : UIView!
    
    func reset(){
        self.lblText.text = " "
    }
    
    //For faq parent level
    func config(faqOption:Option){
        self.lblText.text = faqOption.label
    
    }
    
    //for faqQA
    func configQA(faqQ : FAQS){
        self.lblText.text = faqQ.question
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
