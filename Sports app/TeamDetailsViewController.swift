//
//  TeamDetailsViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit
import SDWebImage
class TeamDetailsViewController: UIViewController {

    
    @IBOutlet weak var dsec: UILabel!
    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var stadiumImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var leaguesName: UILabel!
    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    let teamID : Int? = 133604
    var team = Teams()
    var twitter : String = ""
    var facebook : String = ""
    var instgram : String = ""
    var teamDetails : [[String: String?]] = [[String: String?]]()
    let teamDetailsViewModel = TeamDetailsViewModel( )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n\n\(team)\n\n\n")
        
        if team.strTeam == nil{
            self.onFailUpdateView()
        }
        else{
            self.onSuccessUpdateView()
        }
        
    }
    
    func onSuccessUpdateView(){

        dsec.text = team.strDescriptionEN
        teamName.text = team.strTeam
        stadiumName.text = team.strStadium
        countryName.text = team.strCountry
        leaguesName.text = team.strLeague
        badgeImg.sd_setImage(with: URL(string:team.strTeamBadge ?? "" ), placeholderImage: UIImage(named:"1"))
        stadiumImg.sd_setImage(with: URL(string:team.strStadiumThumb ?? "" ), placeholderImage: UIImage(named:"1"))
        twitter = team.strTwitter!
        facebook = team.strFacebook!
        instgram = team.strInstagram!
        
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: "There is no data to display", preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func instgram(_ sender: Any) {
        teamDetailsViewModel.openContacts(str: instgram)
    }
    @IBAction func facebook(_ sender: Any) {
        teamDetailsViewModel.openContacts(str: facebook)
    }
    @IBAction func twitter(_ sender: Any) {
        teamDetailsViewModel.openContacts(str: twitter)
    }
    
    
}




