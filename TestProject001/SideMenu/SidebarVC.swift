//
//  SidebarVC.swift
//  TestProject001
//
//  Created by Mac on 16/04/24.
//

import UIKit

//1
protocol SideMenuViewControllerDelegate {
    func selectedCell(group: TableSection, rowSelected: Int)
   // func selectedHeader()
}

enum TableSection : Int,CaseIterable{
    case DashBoardGroup = 0, ShopGroup,FaqGroup,LogoutGroup
}

class SidebarVC: UIViewController {

    
    @IBOutlet weak var sideBarTableView: UITableView!
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var sideBarDelegate : SideMenuViewControllerDelegate? //2
    var defaultHighlightedCell: Int = 0
    
    private var dashboardGroup : [SideBarItems] =
    [ SideBarItems(icon: UIImage(named: "Dashboard")!, name: "Dashboard"),
      SideBarItems(icon: UIImage(named: "technology")!, name: "Connect Device"),
      SideBarItems(icon: UIImage(named: "recipe_book")!, name: "Recipe"),
      SideBarItems(icon: UIImage(named: "calculator")!, name: "Dosage Calc")
    ]
    
    private var shopGroup : [SideBarItems] =
    [ SideBarItems(icon: UIImage(named: "shopping_cart")!, name: "Shop"),
      SideBarItems(icon: UIImage(named: "video_lib")!, name: "Video Library")
    ]
    private var FAQGroup: [SideBarItems] = [
        SideBarItems(icon: UIImage(named: "help")!, name: "FAQs"),
        SideBarItems(icon: UIImage(named: "contact_support")!, name: "Contact Support"),
        SideBarItems(icon: UIImage(named: "setting")!, name: "Settings")
    ]
    
    private var logoutGroup: [SideBarItems] = [
        SideBarItems(icon: UIImage(named: "About")!, name: "About Ardent"),
        SideBarItems(icon: UIImage(named: "notification")!, name: "Notifications"),
        SideBarItems(icon: UIImage(named: "sign_out")!, name: "Log out")
    ]
    private func setTableView(){
        self.sideBarTableView.register(UINib(nibName: "SidebarItemCell", bundle: nil), forCellReuseIdentifier: "SidebarItemCell")
        sideBarTableView.delegate = self
        sideBarTableView.dataSource = self
        sideBarTableView.backgroundColor = .clear
        sideBarTableView.separatorStyle = .none
        sideBarTableView.allowsSelection = true
    }
    
    private func setUpHeaderImage() {
        self.userProfileImg.layer.borderWidth = 1
        self.userProfileImg.layer.masksToBounds = false
        self.userProfileImg.layer.borderColor = UIColor(named: "Dark3")?.cgColor
        self.userProfileImg.layer.cornerRadius = self.userProfileImg.frame.height/2
        self.userProfileImg.clipsToBounds = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeaderImage()
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideBarTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        setTableView()
        sideBarTableView.reloadData()
        
    }
}

extension SidebarVC : UITableViewDelegate, UITableViewDataSource{
   
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return  TableSection.allCases.count
    }
  
   
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section
        switch (TableSection(rawValue: section)){
            case .DashBoardGroup :
                return dashboardGroup.count
            case .ShopGroup :
                return shopGroup.count
            case .FaqGroup :
                return FAQGroup.count
            case .LogoutGroup :
                return logoutGroup.count
            case .none:
                return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50      //UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidebarItemCell", for: indexPath) as! SidebarItemCell
    
        switch (TableSection(rawValue: indexPath.section)){
            case .DashBoardGroup :
                let item = dashboardGroup[indexPath.row]
                cell.configue(item: item)
             
            case .ShopGroup:
                let item = shopGroup[indexPath.row]
                cell.configue(item: item)
                
            case .FaqGroup:
                let item = FAQGroup[indexPath.row]
                cell.configue(item: item)
            case .LogoutGroup:
                let item = logoutGroup[indexPath.row]
                cell.configue(item: item)
            case .none:
                break
        }
        
        return cell
        
    }
    
  //didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  self.navigationController?.pushViewController(RecipeVC(), animated: true)//OK
        
        //3
        if let grp = TableSection(rawValue: indexPath.section){
             print("tablegroup and row \(grp)")
               print(indexPath.row)
          //  self.delegate?.selectedCell(group: grp, rowSelected: indexPath.row)
            self.sideBarDelegate?.selectedCell(group: grp, rowSelected: indexPath.row)
            
        }
        if (TableSection(rawValue: indexPath.section) == .LogoutGroup){
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
}

