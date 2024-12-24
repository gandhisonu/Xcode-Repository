//
//  ShopVC.swift
//  TestProject001
//
//  Created by Mac on 25/04/24.
//

import UIKit

class ShopVC: UIViewController {

    @IBOutlet weak var shopTableView: UITableView!
    
    var shopModelData = [ShopProduct]() 
    var shopModelPagingData = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shopping"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                navigationItem.backBarButtonItem = backBarButtonItem
        
        
        //MARK: Header Cell
        self.shopTableView.register(UINib(nibName: "shopHeaderCell", bundle: nil), forCellReuseIdentifier: "shopHeaderCell")
        self.shopTableView.delegate = self
        self.shopTableView.dataSource = self
   
        //MARK: Cell
        self.shopTableView.register(UINib(nibName: "ShopCell", bundle: nil), forCellReuseIdentifier: "ShopCell")
        self.shopTableView.delegate = self
        self.shopTableView.dataSource = self
        //using API-1
       // fetchShopDataFromServer()
        //using API-2
        fetchShopDataServerPaginatedList(categoryId: "82505252-d2bd-46cd-9750-97fbc17faa6f", pageCursor: nil, pageSize: nil)
    }
    //MARK: FetchDataFromServer (product with Id and Name Only)
    public func fetchShopDataFromServer(){
       let shopEndPoint =  ShopEndPoint()
        shopEndPoint.getProductsList(apiVersion: "v0"){ resultProdList in
            print("resultProductlist \(resultProdList)")
         switch (resultProdList){
             case .success(let sucessProduct):
                 print(sucessProduct)
                 self.shopModelData.removeAll()
                 self.shopModelData.append(contentsOf: sucessProduct.products)
                 DispatchQueue.main.async {
                     self.shopTableView.reloadData()
                     return
                 }
             case .failure(let errorProduct):
                 print(errorProduct)
            }
         }
    }
//MARK: Pagination Products list
    public func fetchShopDataServerPaginatedList(categoryId:String?,pageCursor:String?,pageSize:String?){
        let shopEndPoint =  ShopEndPoint()
        shopEndPoint.getProducts(apiVersion: "v0", categoryId: categoryId,pageCursor: pageCursor,pageSize: pageSize) { resultProductList in
            switch (resultProductList){
                case .success(let productMaster):
                    print(productMaster)
                    self.shopModelPagingData.removeAll()
                    self.shopModelPagingData.append(contentsOf: productMaster.products)
                    print("ShopModelPagingData :- \(self.shopModelPagingData)")
                    DispatchQueue.main.async {
                        self.shopTableView.reloadData()
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
//MARK: FetchDataFromServer for Specific Product ID- NextDetailedScreen
    public func fetchShopDataFromServerProdDetailById(prodId: String){
        let shopEndPoint = ShopEndPoint()
        shopEndPoint.getProductById(apiVersion: "v0", productid: prodId) { resultProduct in
            
            switch (resultProduct){
                case .success(let resultProd):
                    print(resultProd)
                    DispatchQueue.main.async {
                        let shopDetail = ShopDetailVC()
                        shopDetail.product =  resultProd
                        
                        self.navigationController?.pushViewController(shopDetail, animated: true)
                    }
                case .failure(let err):
                    print(err)
            }
        }
    }
    
    
}

extension ShopVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            //using API-1 prodAPI- ID and Name only
            // return  self.shopModelData.count
            
            //using API-2 for prodAPI- full list
            print("records found :-\(shopModelPagingData.count)")
            return  self.shopModelPagingData.count //product list
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell =  shopTableView.dequeueReusableCell(withIdentifier: "shopHeaderCell", for: indexPath) as! shopHeaderCell
            // cell.configeProdHeader()
            return cell
        }else {
            let cell =  shopTableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
            //using API-1 for prodAPI that will print ID and Name only
            // cell.configProdIDName(prod: shopModelData[indexPath.row])
            
            //using API-2 for prodAPI that will print full list
            // cell.configProdPaging(prod: shopModelPagingData[indexPath.row])
            
            //using API-2 for prodAPI that will print full list and next screen by clicking detail button
            let productDetail = shopModelPagingData[indexPath.row]
            cell.configProdPaging(prod: productDetail)
            cell.didTapOnProductDetail = {[weak self] in
                let controller = ShopDetailVC()
                controller.product = productDetail
                self?.navigationController?.pushViewController(controller, animated: true)
            }
            
            return cell
            
        }
    }
    
    // use detailmore button instead of didselectrow its is working either
    /*  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print(indexPath)
     //using API 1
     //  print(shopModelData[indexPath.row])
     //fetchShopDataFromServerProdDetailById(prodId: shopModelData[indexPath.row].id)
     
     //using API 2
     print(shopModelPagingData[indexPath.row])
     fetchShopDataFromServerProdDetailById(prodId: shopModelPagingData[indexPath.row].id)
     }
     }*/
}
