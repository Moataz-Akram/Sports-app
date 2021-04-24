//
//  TeamDetailsViewController.swift
//  Sports app
//
//  Created by Moataz on 20/04/2021.
//

import UIKit

class TeamDetailsViewController: UIViewController {
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
        var x = teamDetails[0]
        print(x["strTeam"]!!)
        
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: teamDetailsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}



