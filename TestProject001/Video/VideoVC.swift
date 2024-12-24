//
//  VideoVC.swift
//  TestProject001
//
//  Created by Mac on 23/05/24.
//

import UIKit

class VideoVC: UIViewController {

  
    @IBOutlet weak var videoTableView: UITableView!
    var VideoModel = [Video]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Video Library"
        self.videoTableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
   
        //30e8af30-d502-4c09-911c-29b771b89e7f
        fetchVideosFromServer(category:"30e8af30-d502-4c09-911c-29b771b89e7f")
                                //"3d87e230-b82f-494c-8abe-541d32ec4cdf")
    }

    public func fetchVideosFromServer(category: String?){
        let videoEndPoint = VideoEndPoint()
        videoEndPoint.getVideosList(apiVersion: "v0",categoryIDs: category) { result in
            switch (result){
                case .success(let sucessResult):
                    print("VideosList")
                    print(sucessResult)
                    self.VideoModel.removeAll()
                    self.VideoModel.append(contentsOf: sucessResult.videos)
                    print("model data \(self.VideoModel)")
                    DispatchQueue.main.async {
                        self.videoTableView.reloadData()
                        return
                    }
                case .failure(let errorResult) :
                    print(errorResult)
            }
        }
    }
 
    
}

extension VideoVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.config(video: self.VideoModel[indexPath.row])
        return cell
        
    }
}
