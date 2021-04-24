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
    var teamDetails : [[String: String?]] = [[String: String?]]()
    let teamDetailsViewModel = TeamDetailsViewModel( )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamDetailsViewModel.bindTeamDetailsViewModelToView = {
                    
            self.onSuccessUpdateView()
            
        }
        
        teamDetailsViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
        teamDetailsViewModel.fetchTeamDetailsDataFromAPI(id2: teamID!)
        
    }
    
    func onSuccessUpdateView(){
        
        teamDetails = teamDetailsViewModel.teamDetailsData
        let x = teamDetails[0]
        print(x["strTeam"]!!)
        dsec.text = x["strDescriptionEN"]!!
        teamName.text = x["strTeam"]!!
        stadiumName.text = x["strStadium"]!!
        countryName.text = x["strCountry"]!!
        leaguesName.text = x["strLeague"]!!
        badgeImg.sd_setImage(with: URL(string: x["strTeamBadge"]!!), placeholderImage: UIImage(named:"1"))
        stadiumImg.sd_setImage(with: URL(string: x["strStadiumThumb"]!!), placeholderImage: UIImage(named:"1"))
        
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: teamDetailsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}



