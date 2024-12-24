//
//  Faq1VC.swift
//  TestProject001
//
//  Created by Mac on 01/05/24.
//

import UIKit

class Faq1VC: UIViewController {

    @IBOutlet weak var  faq1TableView : UITableView!
    
    var faqDataModel = [Option]()
    var faqParent: Int = 0    //R/S/D/G
    
    var faqOptions: FAQ?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQs."
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backBarButtonItem
        
        faq1TableView.register(UINib(nibName: "Faq1Cell", bundle: nil), forCellReuseIdentifier: "Faq1Cell")
        faq1TableView.delegate = self
        faq1TableView.dataSource = self
        fetchFaqDataFromServer(level: "2", parent: String(faqParent))
      
    }
//MARK: passing Parent and level to fetch data for next screen QA
    //level:String,parent:String
    public func fetchFaqDataFromServer(level:String, parent: String){
        let faqEndPoint =  FAQEndPoint()
        faqEndPoint.getFaqLevelOption(apiVersion: "v0", level: level, parent: parent) { resultFaq in
        switch (resultFaq){
            case .success(let success):
                print(success)
                self.faqDataModel.removeAll()
                self.faqDataModel.append(contentsOf: success.options)
                DispatchQueue.main.async {
                    self.faq1TableView.reloadData()
                    return
                }
                print("faqDataModel is :- \(self.faqDataModel)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

extension Faq1VC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqDataModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Faq1Cell", for: indexPath) as! Faq1Cell
        
        cell.config(faqOption: faqDataModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = FaqDetailVC()
        controller.optionID =  self.faqDataModel[indexPath.row].id
        print("contoller optionid :- \(controller.optionID)")
        controller.labHeading = self.faqDataModel[indexPath.row].label
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
