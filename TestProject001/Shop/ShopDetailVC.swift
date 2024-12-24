//
//  ShopDetailVC.swift
//  TestProject001
// https://guides.codepath.com/ios/Scroll-View-Guide
//  Created by Mac on 01/05/24.
//

import UIKit
import Kingfisher

class ShopDetailVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var prodImg : UIImageView!
    
    @IBOutlet weak var prodId : UILabel!
    @IBOutlet weak var prodName : UILabel!
    @IBOutlet weak var prodPrice : UILabel!
    @IBOutlet weak var shippingcharges : UILabel!
    @IBOutlet weak var categoryName : UILabel!
    @IBOutlet weak var categoryId : UILabel!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var prodImgView : UIImageView!
    
    @IBOutlet weak var prodScrollView: UIScrollView!
    @IBOutlet weak var pageControl : UIPageControl!
    
  var product : Product?
 
//MARK: reset var
    func reset(){
        self.prodId.text = ""
        self.prodName.text = " "
        self.prodPrice.text = " "
        self.shippingcharges.text = " "
        self.categoryName.text = " "
        self.categoryId.text = " "
    }
//MARK: configuration
    func config(){
       // self.prodImg.image = UIImage(named: product?.assets.first) //?
        self.prodId?.text = product?.id
        self.prodName?.text = product?.name
        let price = product?.price
        self.prodPrice?.text =  String(product?.price ?? 0)
        self.shippingcharges.text = String(product?.shippingCharges ?? 0)
      
        //.....
        self.categoryName.text = product?.categories[0].name
        self.categoryId.text = product?.categories[0].id
   // ScrollView
        addImagesToScrollViewContent(prodDetail: product!)
    }
    
    
    
//MARK: moving to next page on page control selection
    @objc  func didChangePage(sender: UIPageControl) {
        //print("sender \(sender.currentPage)")
        //contentOffset is scrollView.bounds.origin
        var offset = self.prodScrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * self.prodScrollView.bounds.size.width
        self.prodScrollView.setContentOffset(offset, animated: true)
    }
//MARK: Images scrolling on scrolview on pagecontrol selction
    private func addImagesToScrollViewContent(prodDetail: Product){
        self.pageControl.numberOfPages = prodDetail.assets.count
        self.pageControl.currentPage = 0
        self.pageControl.addTarget(self, action: #selector(didChangePage(sender: )), for: .valueChanged)
     
        let scrollviewSize = self.prodScrollView.frame.size
        for i in 0..<self.pageControl.numberOfPages{
            let imageView: UIImageView = UIImageView()
            let imageURL = prodDetail.assets[i]
            imageView.kf.setImage(with: URL(string: imageURL))
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: CGFloat(Int(CGFloat(i) * scrollviewSize.width)), y: 0, width: scrollviewSize.width, height: scrollviewSize.height)
            self.prodScrollView.addSubview(imageView)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        reset()
        config()
        
    //PageControl screen scrolling for trail only
     /*   self.prodScrollView.delegate = self
        scrollViewConfige()
       // pagingConfige()
      */
    }
    
    //MARK:  3 colored uiview on pagcontrol- for trail only
    func scrollViewConfige(){
        let contentWidth = prodScrollView.bounds.width    //* 2
        let contentHeight = prodScrollView.bounds.height * 5 //scroll verticaly
        prodScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        let subviewHeight = CGFloat(100)
        var currentViewOffset = CGFloat(0);
        
        while currentViewOffset < contentHeight {
            let frame = CGRectMake(50, currentViewOffset, contentWidth, subviewHeight).insetBy(dx: 5, dy: 5)//gap
        
            let hue = currentViewOffset/contentHeight
            let subview = UIView(frame: frame)
            subview.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            prodScrollView.addSubview(subview)
            currentViewOffset += subviewHeight
        }
    }
  //MARK:  3 colored uiview on pagcontrol- for trail only
    func pagingConfige(){
        let pageWidth = prodScrollView.bounds.width
        let pageheight = prodScrollView.bounds.height
        prodScrollView.contentSize = CGSizeMake(pageWidth * 3 , pageheight)
        prodScrollView.isPagingEnabled = true
        prodScrollView.showsHorizontalScrollIndicator = false
        let view1 = UIView(frame: CGRect(x: 20, y: 20, width: pageWidth, height: pageheight))
        view1.backgroundColor = UIColor.blue
        let view2 = UIView(frame: CGRect(x:pageWidth, y: 20, width: pageWidth, height: pageheight))
        view2.backgroundColor = UIColor.orange
        let view3 = UIView(frame: CGRect(x: 2 * pageWidth, y: 20, width: pageWidth, height: pageheight))
        view3.backgroundColor = UIColor.purple
        
        prodScrollView.addSubview(view1)
        prodScrollView.addSubview(view2)
        prodScrollView.addSubview(view3)
    }
  //MARK: Action on pageCotrol
    @IBAction func pageControlDidPage(sender :AnyObject){
        let xOffset = prodScrollView.bounds.width * CGFloat(pageControl.currentPage)
        prodScrollView.setContentOffset(CGPointMake(xOffset, 0), animated: true)
    }
 
}
