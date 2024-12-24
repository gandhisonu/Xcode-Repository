//
//  FaqDetailVC.swift
//  TestProject001
//
//  Created by Mac on 03/05/24.
//

import UIKit

class FaqDetailVC: UIViewController {

    @IBOutlet weak var faqDetailTableView : UITableView!
    
    var faqQAModel = [FAQS]()
    var optionID : String = ""  //id
    var labHeading : String = " "
  
    var expandedIndexSet : IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.faqDetailTableView.register(UINib(nibName: "FaqDetailCell", bundle: nil), forCellReuseIdentifier: "FaqDetailCell")
        
        faqDetailTableView.delegate = self
        faqDetailTableView.dataSource = self
        print("Option ID is :- \(optionID)")
        self.title = labHeading //Title
        fetchFaqQADataFromServer(option: optionID)
    }
    
 
    public func fetchFaqQADataFromServer(option: String){
        let faqEndPoint =  FAQEndPoint()
        faqEndPoint.getFaqQA(apiVersion: "v0",optionId: option){ result in
        switch (result){
            case .success(let success):
                print("FAQQA")
                print(success)
                self.faqQAModel.removeAll()
                self.faqQAModel.append(contentsOf:success.faqs)
                DispatchQueue.main.async {
                    self.faqDetailTableView.reloadData()
                    return
                }
                print("faqDataModel is :- \(self.faqQAModel)")
            case .failure(let error):
                print(error)
            }
        }
    }

}
extension FaqDetailVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqQAModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaqDetailCell", for: indexPath) as! FaqDetailCell
        

        cell.configQA(faqQ: faqQAModel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        if (expandedIndexSet.contains(indexPath.row)) {
           return 180
        } else {
            return 70
        }
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // if the cell is already expanded, remove it from the indexset to contract it
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
        // if the cell is not expanded, add it to the indexset to expand it
            expandedIndexSet.insert(indexPath.row)
        }
        self.faqDetailTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
