//
//  CustomCells.swift
//  Sports app
//
//  Created by Moataz on 22/04/2021.
//

import UIKit


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
