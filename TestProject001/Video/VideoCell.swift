//
//  VideoCell.swift
//  TestProject001
//
//  Created by Mac on 23/05/24.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var videoImgView: UIImageView!
    
    func reset(){
        self.categoryLabel.text = ""
        self.createdByLabel.text = ""
        self.titleLabel.text = ""
        self.countLabel.text = ""
        
    }
    func config(video : Video){
        self.categoryLabel.text = video.categories?.first?.name //Decarb
        self.createdByLabel.text = video.createdBy //Ardent
        self.titleLabel.text = video.title //
        self.countLabel.text = String(video.views ?? 0)
        self.videoImgView.kf.setImage(with: URL(string: video.thumbUrl ?? ""))
 
    }

    func getImagesdatafromserver (){
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
