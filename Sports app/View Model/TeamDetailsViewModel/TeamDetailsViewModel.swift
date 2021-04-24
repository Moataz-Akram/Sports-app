//
//  TeamDetailsViewModel.swift
//  Sports app
//
//  Created by marwa on 4/24/21.
//

import Foundation
class TeamDetailsViewModel: NSObject {
    
    var teamDetailsService :TeamDetailsService!
    
    var teamDetailsData :[[String: String?]]! {
        didSet{
            
            self.bindTeamDetailsViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindTeamDetailsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.teamDetailsService = TeamDetailsService()
       
    }
    
    
    func fetchTeamDetailsDataFromAPI(id2 : Int){
        teamDetailsService.fetchTeamDetailsData(completion: { (teamDetailsData, error) in
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.teamDetailsData = teamDetailsData
                
            }
        }, id: id2)
        
    }

}
