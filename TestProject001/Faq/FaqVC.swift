//
//  FaqVC.swift
//  TestProject001
//
//  Created by Mac on 01/05/24.
//

import UIKit

//MARK: Faq Parent
enum FaqParentOption: Int, CaseIterable {
    case Device = 0, Shop, Recipe, General
}

class FaqVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQs"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backBarButtonItem

    }
    
//MARK: passing Parent to next controller on click
    @IBAction func btnDeviceClicked(_ sender: UIButton) {
        print(sender.titleLabel)

        let controller = Faq1VC()
        controller.faqParent = sender.tag
        print(" controller.faqParent :- \( controller.faqParent)")
        self.navigationController?.pushViewController(controller, animated: true)
    }
//MARK: passing Parent to next controller on click
    @IBAction func btnRecipeClicked(_ sender: UIButton) {
        let controller = Faq1VC()
        controller.faqParent = sender.tag
        print(" controller.faqParent :- \( controller.faqParent)")
        self.navigationController?.pushViewController(controller, animated: true)
    }
//MARK: passing Parent to next controller on click
    @IBAction func btnShopClicked(_ sender: UIButton) {
        let controller = Faq1VC()
        controller.faqParent = sender.tag
        print(" controller.faqParent :- \( controller.faqParent)")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//MARK: passing Parent to next controller on click
    @IBAction func btnGeneralClicked(_ sender: UIButton) {
        print(sender.titleLabel)
        let controller = Faq1VC()
        controller.faqParent = sender.tag
        print(" controller.faqParent :- \( controller.faqParent)")
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

