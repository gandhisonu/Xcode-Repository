//
//  ShopCell.swift
//  TestProject001
//
//  Created by Mac on 25/04/24.
//

import UIKit
import Kingfisher

class ShopCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var mainView :UIView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productId :UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var rateLabel : UILabel!
    @IBOutlet weak var shippingLabel :UILabel!
    @IBOutlet weak var costPrice :UILabel!
    @IBOutlet weak var detailButton : UIButton!
    @IBOutlet weak var prodImgView : UIImageView!
    

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    
    var didTapOnProductDetail: (() -> Void)? // ?
    var allImages = [UIImageView]()
    var offSet: CGFloat = 0
    
//MARK: product list  API with id and name only
    func reset(){
        self.productName.text = " "
        self.productId.text = " "
    }
//MARK: product list  API with id and name only
   func configProdIDName(prod: ShopProduct){
       self.productName.text = prod.name
       self.productId.text = prod.id
    }
//MARK: full product list API
    func resetProdPaging(){
        self.productName.text = " "
        self.productId.text = " "
        self.rateLabel.text = ""
        self.costPrice.text = " "
        self.shippingLabel.text = " "
        self.categoryLabel.text = " "
        
    }
//MARK: full product list API
    func configProdPaging(prod: Product){
        self.productName.text = prod.name
        self.productId.text = prod.id
        self.rateLabel.text = "$\(prod.price)"
        
        let categoryObj = prod.categories.first
        self.categoryLabel.text = categoryObj?.name
        
        self.shippingLabel.text =
        (prod.shippingCharges == 0) ? "Free Shipping" : "$\(prod.shippingCharges)"
        
        self.costPrice.text = prod.tag.components(separatedBy: ",")[0]
        self.getImagesDatatoScrollView(product: prod)
        
     }
 
//MARK: moving to next page on page control selection
    @objc  func didChangePage(sender: UIPageControl) {
        //print("sender \(sender.currentPage)")
        //contentOffset is scrollView.bounds.origin
        var offset = self.scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * self.scrollView.bounds.size.width
        self.scrollView.setContentOffset(offset, animated: true)
        //print("sender offset \(self.scrollView.contentOffset)")
    }
  
//MARK: getImages Data from server to ScrollView
    func getImagesDatatoScrollView(product:Product){
        var xOrigin :CGFloat = 0
        self.pageControl.numberOfPages = product.assets.count
        self.pageControl.currentPage = 0
        self.pageControl.addTarget(self, action: #selector(didChangePage(sender: )), for: .valueChanged)//NW
     
        for i in 0..<self.pageControl.numberOfPages{
            //setting img view frame size as scrollview fram size
            let imgView = UIImageView(frame: CGRect(origin: CGPoint(x: xOrigin, y: 0), size: CGSize(width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)))
            
            imgView.contentMode = .scaleAspectFit
            self.contentView.addSubview(imgView)
            let imgURL:URL = URL(string: product.assets[i])!
            
            DispatchQueue.global(qos:.background).async {
                let imageData:NSData = NSData(contentsOf: imgURL)!
                let image = UIImage(data: imageData as Data)
                
                DispatchQueue.main.async {
                    imgView.image = image
                    self.allImages.append(imgView)
                 //   self.scrollView.frame = self.contentView.bounds
                  //  self.scrollView.contentSize = (self.contentView.bounds.size)
                  //or
                    self.scrollView.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
                    //for scrolling horizonal set height to zero
                    self.scrollView.contentSize = CGSize(width: self.contentView.frame.width * CGFloat(self.pageControl.numberOfPages), height: 0) //self.contentView.frame.height
            
                    self.scrollView.addSubview(imgView) //(self.prodImgView)
                }
                
            }
          
            self.scrollView.addSubview(prodImgView) //(prodImgView) //(imgView)
            xOrigin = xOrigin + self.scrollView.frame.size.width
            //print("xorigin is \(xOrigin)")
        }
        //AutoScroll of content inside scrollview on each 3 sec
        let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)

    }
//MARK: Auto Scroll of scroll view content
    @objc func onTimer(){
        let totalPossibleOffset = CGFloat(self.pageControl.numberOfPages - 1) * self.scrollView.bounds.size.width //bounds size remains intact with its subviews(images)
           if offSet == totalPossibleOffset {
               offSet = 0 // come back to the first image after the last image
           }
           else {
               offSet += self.scrollView.bounds.size.width
           }
        self.scrollView.contentOffset.x = CGFloat(self.offSet)
    }
 
 /*//working without it 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(round(scrollView.contentOffset.x / self.scrollView.bounds.size.width))
        print("page ...\(page)")
        self.pageControl.currentPage = page
    }
    
    */

    override func awakeFromNib() {
        super.awakeFromNib()
       // reset()//for API prod name and ID only
        resetProdPaging() //For API full prod detail
        self.scrollView.delegate = self
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//MARK: Next Screen on Detail Button Click
    @IBAction func didTapOnDetailButton(_ sender: Any) {
        if (self.didTapOnProductDetail != nil) {
            self.didTapOnProductDetail!()
        }
    }
    
}
