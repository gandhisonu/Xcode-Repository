//
//  RecipeCell.swift
//  TestProject001
//
//  Created by Mac on 22/04/24.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var mainView :UIView!
    @IBOutlet weak var titleLable :UILabel!
    @IBOutlet weak var creatorNameLable :UILabel!
    @IBOutlet weak var publishedByLable :UILabel!
    @IBOutlet weak var statuslable :UILabel!
    @IBOutlet weak var recipeImg : UIImageView!
    @IBOutlet weak var moreBtn :UIImageView!
    
    func confige(recipeRecived : Recipe){
        titleLable.text =  recipeRecived.title
        creatorNameLable.text = recipeRecived.creatorName
        publishedByLable.text = String(recipeRecived.publishedOn!)
        statuslable.text =  recipeRecived.state
       // recipeImg.image =  recipeRecived.assestUrl
        
        if let assetURL = recipeRecived.assestUrl {
            recipeImg.isHidden = false
           // setImage(from: assetURL)//1 way
            setImageToImageView(recipeRecived: recipeRecived)//2way
            circleImage(img: recipeImg)
          } else {
            recipeImg.isHidden = true
          }
        
        
        //Side Border
        if recipeRecived.state == "APPROVED"{
            addSideBorder(borderFrame: CGRect(x: 0, y: 0, width: 2, height: mainView.layer.bounds.height),borderColor: UIColor.green )
            /*
            self.statuslable.textColor =  UIColor(hexString: "#59BD3E")
            self.statuslable.layer.backgroundColor = UIColor(hexString: "#E9FFE3").cgColor
            self.statuslable.layer.borderColor = UIColor(hexString: "#DDFFD4").cgColor
            self.statuslable.textAlignment = .center
            self.statuslable.layer.cornerRadius = 30
           // self.statuslable.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))*/
            lblSetting(lbl: self.statuslable, lblTextColor: "#59BD3E", lblbgColor: "#E9FFE3", lblbgBorderColor: "#DDFFD4")
            
        }else  if recipeRecived.state == "REJECTED"{
            addSideBorder(borderFrame: CGRect(x: 0, y: 0, width: 2, height: mainView.layer.bounds.height),borderColor: UIColor.red )
            lblSetting(lbl: self.statuslable, lblTextColor: "#DB5858", lblbgColor: "#FFE7E7", lblbgBorderColor: "#FFDBDB")
            
        }else if recipeRecived.state == "SAVED"{
            addSideBorder(borderFrame: CGRect(x: 0, y: 0, width: 2, height: mainView.layer.bounds.height), borderColor: UIColor.darkGray)
            lblSetting(lbl: self.statuslable, lblTextColor: "#666666", lblbgColor: "#F1F2F2", lblbgBorderColor: "#EAEAEA")
        }
        else {
            addSideBorder(borderFrame: CGRect(x: 0, y: 0, width: 2, height: mainView.layer.bounds.height), borderColor: UIColor.white)
        }
        
    }
    
    
    //MARK: Side Border
    private func addSideBorder(borderFrame: CGRect,borderColor: UIColor){
        let borderSide = CALayer()
        borderSide.frame = borderFrame
        borderSide.backgroundColor = borderColor.cgColor
        mainView.layer.addSublayer(borderSide)
    }
    //MARK: label setting
    private func lblSetting(lbl:UILabel,lblTextColor:String,lblbgColor:String,lblbgBorderColor:String){
        lbl.textColor =  UIColor(hexString: lblTextColor)
        lbl.layer.backgroundColor = UIColor(hexString: "#E9FFE3").cgColor
        lbl.layer.borderColor = UIColor(hexString: "#DDFFD4").cgColor
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 30
       //lbl.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
    }
    
    //MARK: Setup Main View
    private func setUpMainView(){
        self.mainView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.mainView.layer.shadowColor = UIColor.gray.cgColor
        self.mainView.layer.shadowOpacity = 0.7
        self.mainView.layer.shadowRadius = 4
        
        self.recipeImg.layer.cornerRadius = (self.recipeImg.frame.size.width / 2)
        
    }
    //MARK: Image func
    //Setting Image from URL to ImageView -way-1
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.recipeImg.image = image
            }
        }
    }
    
    //Setting Image from URL to ImageView -way-2
    func setImageToImageView(recipeRecived : Recipe) {
        fetchImage(from: recipeRecived.assestUrl!,completionHandler: { (imageData) in
            if let data = imageData {
                DispatchQueue.main.async {
                    self.recipeImg.image = UIImage(data: data)
                }
            } else {
                print("Error loading image");
            }
        })
    }
    //MARK: capturing image from server
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)

        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image! 😢")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
    }
    
    
    //MARK: Rounding Image View
    private func circleImage(img:UIImageView){
       // img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        //img.layer.borderColor = UIColor.black.cgColor
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
        adjustContentMode(imgtoFit: img.image)
    }
    //MARK: Image ContectMode
    private func adjustContentMode(imgtoFit:UIImage?) {
            guard let image = imgtoFit else {
                return
            }
            if image.size.width > bounds.size.width ||
                image.size.height > bounds.size.height {
                contentMode = .scaleAspectFit
            } else {
                contentMode = .center
            }
        }

  
    
    func reset(){
        titleLable.text = ""
        creatorNameLable.text = ""
        publishedByLable.text = ""
        statuslable.text = ""
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        setUpMainView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
