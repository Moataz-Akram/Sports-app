//
//  CustomCells.swift
//  Sports app
//
//  Created by Moataz on 22/04/2021.
//

import UIKit
import SDWebImage

class LeaugeCustomCell: UITableViewCell {
    @IBOutlet weak var leaugeImage: UIImageView!
    @IBOutlet weak var leaugeName: UILabel!
    @IBOutlet weak var youtubeBtn: UIButton!
    var youtube:String!{
        didSet{
            if youtube != ""{
                youtubeBtn.isHidden = false
            }
        }
    }
    
    @IBAction func openYoutube(_ sender: Any) {
        print(youtube! as Any)
        if youtube! != ""{
            
            if let youtubeURL = URL(string: "https://\(youtube!)"),
                UIApplication.shared.canOpenURL(youtubeURL) {
                // redirect to app
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            } else if let youtubeURL = URL(string: "https://\(youtube!)") {
                // redirect through safari
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            }
        }
    }
}

class passedEventCustomCell: UICollectionViewCell {
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var awayImg: UIImageView!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var strHomeImg:String!{
        didSet{
            homeImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            homeImg.sd_setImage(with: URL(string: strHomeImg), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    var strAwayImg:String!{
        didSet{
            awayImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            awayImg.sd_setImage(with: URL(string: strAwayImg), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
}

class teamsCutsomCell: UICollectionViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
}

class upComingEventsCustomCell: UICollectionViewCell{
    
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var awayImg: UIImageView!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
}

class FavLeaguesCustomCell: UITableViewCell {
    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var youtubeBtn: UIButton!
    @IBOutlet weak var leaguesName: UILabel!
    
    var youtube:String!{
        didSet{
            if youtube != ""{
                youtubeBtn.isHidden = false
            }
        }
    }
    @IBAction func youTubePressed(_ sender: UIButton) {
       
        if youtube! != ""{
            
            if let youtubeURL = URL(string: "https://\(youtube!)"),
                UIApplication.shared.canOpenURL(youtubeURL) {
                // redirect to app
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            } else if let youtubeURL = URL(string: "https://\(youtube!)") {
                // redirect through safari
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}

