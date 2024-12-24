//
//  HomeVC.swift
//  TestProject001
//
//  Created by Mac on 12/04/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var HomeVCTopCollectionView: UICollectionView!
    @IBOutlet weak var HomeVCBottomCollectionView: UICollectionView!
    
    private var homeIcons: [SideBarItems] =
    [SideBarItems(icon: UIImage(named: "recipe_book")!, name: "Recipe"),
     SideBarItems(icon: UIImage(named: "calculator")!, name: "Dosage Calc"),
     SideBarItems(icon: UIImage(named: "shopping_cart")!, name: "Shop"),
     SideBarItems(icon: UIImage(named: "video_lib")!, name: "Video Library"),
     SideBarItems(icon: UIImage(named: "help")!, name: "FAQs"),
     SideBarItems(icon: UIImage(named: "contact_support")!, name: "Contact")
    ]
    
    
    @objc func menuTapped(){
        let sideVC = SidebarVC()
        self.navigationController?.pushViewController(sideVC, animated: true)
    }
    @objc func logOutTapped(){
        APIService.shared.defaults.set(false, forKey: "isUserLogIn")
        APIService.shared.defaults.synchronize()
       
        //Removing back button text
        self.navigationItem.hidesBackButton = true //? NW
        self.navigationItem.setHidesBackButton(true, animated: true)//?NW
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(SignInVC(), animated: true)
        
    }
    func navBarSetup(){
        self.title = "Dashboard"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image:UIImage(named:"Hamburger-menu"),
            style: .plain,
            target: self,
            action: #selector(menuTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "sign-out"),
            style: .plain,
            target: self,
            action: #selector(logOutTapped))
        
      //  self.navigationController?.navigationBar.tintColor = UIColor.purple
     //   self.navigationController?.navigationBar.backgroundColor = UIColor(hexString:  "#E0C1FC") //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backBarButtonItem
        
        self.HomeVCTopCollectionView.register(UINib(nibName: "HomeTopCell", bundle: nil),forCellWithReuseIdentifier: "HomeTopCell")
        HomeVCTopCollectionView.delegate = self
        HomeVCTopCollectionView.dataSource = self
       
        
        self.HomeVCBottomCollectionView.register(UINib(nibName: "HomeBottomCell", bundle: nil),forCellWithReuseIdentifier: "HomeBottomCell")
        HomeVCBottomCollectionView.delegate = self
        HomeVCBottomCollectionView.dataSource = self
        
    }

}

extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == self.HomeVCTopCollectionView){
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.HomeVCTopCollectionView){
            return 3
        }else{
            return homeIcons.count
        }
    }
 //cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.HomeVCTopCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTopCell", for: indexPath)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBottomCell", for: indexPath) as! HomeBottomCell
            
            cell.confige(item: homeIcons[indexPath.row])
   
            return cell
        }
        
    }
  //didSelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == self.HomeVCBottomCollectionView){
        
            if (indexPath.row == 0){
                self.navigationController?.pushViewController(RecipeVC(), animated: true)//OK
            }
            if (indexPath.row == 2){
                self.navigationController?.pushViewController(ShopVC(), animated: true)
            }
            if (indexPath.row == 3){
                self.navigationController?.pushViewController(VideoVC(), animated: true)
            }
            if (indexPath.row == 4){
                self.navigationController?.pushViewController(FaqVC(), animated: true)
            }
        }
        
    }
    
    
}

extension HomeVC : UICollectionViewDelegateFlowLayout{

 //4SizeForitemAt- specify the cell width ,cell height and number of cells to be displayed in each row etc.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == self.HomeVCTopCollectionView) {
            let cellWidth = (HomeVCTopCollectionView.frame.size.width-20)
            let cellHeight = (HomeVCTopCollectionView.frame.size.height)
            return  CGSize(width: cellWidth, height: cellHeight)
  
        }else{
            let cellWidth = (HomeVCBottomCollectionView.frame.size.width-10)/2
            let cellHeight =   (HomeVCBottomCollectionView.frame.size.height)/3
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
    }
    
//1 insetForSection- used to give the insets ( distance of the section from its boundaries)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if (collectionView == self.HomeVCTopCollectionView) {
            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }else{
            return UIEdgeInsets(top: 10, left: 0.0, bottom: 10, right: 0.0)
        }
    }
//2minimumInteritemSpacingForSectionAt -inner space between each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
//3minimumLineSpacingForSectionAt -space between each Line (or row)
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if (collectionView == self.HomeVCTopCollectionView){
            return 0
        }else {
            return 10
        }
    }
    

}





