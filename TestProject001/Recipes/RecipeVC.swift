//
//  RecipeVC.swift
//  TestProject001
//
//  Created by Mac on 22/04/24.
//

import UIKit
import SwiftyJSON

class RecipeVC: UIViewController {

    @IBOutlet weak var btnCollectionView :UICollectionView!
    @IBOutlet weak var recipeTableView : UITableView!
    @IBOutlet private var recipesSegmentedController : UISegmentedControl!
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem! //Added
    
    let menuItems = [["All" ,"By Me", "Ardent"],["SUBMITTED","SAVED", "APPROVED","REJECTED" ]]
    
    var recipeModelData = [Recipe]()
    let recipeEndPoint =  RecipeEndPoint()
    
    
    var selectedIndexPath: IndexPath?
    var selectedMenuItem : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print("sg control \(recipesSegmentedController.selectedSegmentIndex)")
        self.recipesSegmentedController.backgroundColor = UIColor(hexString: "FAF5FF")
        navBarItemSetup()
        setupCollectionView()
        self.setUpTableView()
        self.title = "Recipes"
        fetchRecipesfromServer()
        //addNewRecipe()// under test not working yet
        
    }
    
//MARK: Action- SegmentControl
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        if recipesSegmentedController.selectedSegmentIndex == 0  {
            
            self.recipesSegmentedController.setTitleTextAttributes([.foregroundColor: UIColor(hexString: "6C4199"), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)], for: .selected)
            btnCollectionView.reloadData()
            recipeTableView.reloadData()
        }else {
            self.recipesSegmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hexString: "666666")], for: .normal)
            btnCollectionView.reloadData()
            recipeTableView.reloadData()
        }
        recipeTableView.reloadData()
    }
//MARK: Registering collectionviewCell
    private func setupCollectionView(){
        //ListingView
        btnCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecipeCollectionViewCell")
        btnCollectionView.delegate = self
        btnCollectionView.dataSource = self
    }
//MARK: Adding Bar Button Items
    private func navBarItemSetup(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image:UIImage(named:"Hamburger-menu"),
            style: .plain,
            target: self,
            action: #selector(menuTapped)
        )
        //right Bar Item
        let filter = UIBarButtonItem(
            image: UIImage(named: "ic_play_circle_outline_24px"),
            style: .plain,
            target: self,
            action: #selector(filterTapped))
        
        let search = UIBarButtonItem(
            image: UIImage(named: "ic_search_24px"),
            style: .plain,
            target: self,
            action: #selector(searchTapped))
        navigationItem.rightBarButtonItems = [filter, search]

    }
    @objc func menuTapped(){
        let sideVC = SidebarVC()
        self.navigationController?.pushViewController(sideVC, animated: true)
    }
    @objc func searchTapped(){
        
    }
    @objc func filterTapped(){
        
    }
    
    
    //MARK: Registering TableViewCell
    private func setUpTableView(){
        self.recipeTableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        self.recipeTableView.rowHeight = UITableView.automaticDimension
        recipeTableView.reloadData()
    }
    
    public func fetchRecipesfromServer(){
        var creatorId :String? = nil
        var categoryId :String? = nil
        var isArdent = false
        var state :String? = nil
        
        if recipesSegmentedController.selectedSegmentIndex == 0 {
            print("Ex recipe ..\(selectedIndexPath)")
            
            if (selectedIndexPath == [0,1]){
                creatorId = "5f07af46-ae1f-4a87-9b95-dfb2b135440b"//me??
            }else if (selectedIndexPath == [0,2]){
                isArdent = true
            }
        }else if recipesSegmentedController.selectedSegmentIndex == 1  {
                state = menuItems[recipesSegmentedController.selectedSegmentIndex][selectedMenuItem] //[0][1]
                 print("State :\(state)")
        }
        
        let recipeEndPoint =  RecipeEndPoint()
        recipeEndPoint.getAllRecipes(apiVersion: "v0", state: state, categoryId: categoryId, creatorId: creatorId,ardentRecipes: isArdent) { result in
            
            switch(result) {
                case .success(let resultRecipe):
                    print("Sucess : \(resultRecipe)")
                    self.recipeModelData.removeAll()
                    self.recipeModelData.append(contentsOf: resultRecipe.recipes)
                    DispatchQueue.main.async {
                        self.recipeTableView.reloadData()
                        return
                    }
                    print("recipemodelData \(self.recipeModelData)")
                case .failure(let resultError):
                    print("Failure : \(resultError)")
            }
        }
    }
   
//Create New Recipe
    public func addNewRecipe(){
        let recipeEndPoint =  RecipeEndPoint()
        
        
        var recipeObj = AddRecipeMaster(title: "Delicious Pasta", categoryIDs: ["345a6789-bcde-01fg-234h-567890123456","456e7890-12ab-34cd-56ef-789012345678"], deviceID: "123e4567-e89b-12d3-a456-426614174001", ingredients: "Pasta, Tomato Sauce, Cheese", equipments: "Pot, Oven, Knife", steps: [AddRecipeSteps(info: AddRecipeInfo(mode: "", temp: "", tempUnit: "", time: "", description: ""), assets: [AddRecipeAsset(assetType: "image/png", assetURL: "https://s3.example.com/step1_image.png")], uploadAssets: ["image/jpeg","image/png","video/mp4"])], uploadAsset: "image/jpeg")
        
       
        
        recipeEndPoint.createNewRecipe(apiVersion: "v0",recipeId: nil,recipeObj: recipeObj) { Result in
            switch (Result){
                case .success(let recipe):
                    print("new created :\(recipe)")
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    
}

extension RecipeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        menuItems[self.recipesSegmentedController.selectedSegmentIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        if (self.selectedIndexPath == indexPath){
            cell.confige(menuItems[self.recipesSegmentedController.selectedSegmentIndex][indexPath.row],btnBgColor:"#EEDEFC",btnTextColor:"#6C4199")
            
            self.selectedMenuItem = indexPath.row
            print("selectedMenuItem \(selectedMenuItem)")
            fetchRecipesfromServer()
            self.recipeTableView.reloadData()
        } else {
            cell.confige(menuItems[self.recipesSegmentedController.selectedSegmentIndex][indexPath.row],btnBgColor: "#FFFFFF",btnTextColor: "#6C4199")
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedIndexPath = indexPath //
        btnCollectionView.reloadData()
        recipeTableView.reloadData()
    }

}


extension RecipeVC :UICollectionViewDelegateFlowLayout{
    
//4 SizeForitemAt- specify the cell width ,cell height and number of cells to be displayed in each row etc.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = self.menuItems[ self.recipesSegmentedController.selectedSegmentIndex][indexPath.row]
        let TextWidth = text.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12 )]).width + 50
        return CGSize(width: TextWidth, height: 40)
    }
}

extension RecipeVC :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeModelData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  recipeTableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
            
        cell.confige(recipeRecived: recipeModelData[indexPath.row])
        return cell
    }
    
    
}
