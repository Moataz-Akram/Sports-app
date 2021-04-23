//
//  SportsViewMode.swift
//  Sports app
//
//  Created by marwa on 4/22/21.
//

import Foundation

class SportsViewModel: NSObject {
    
    var allSportsService :SportsService!
    
    var sportsData :[Sport]! {
        didSet{
            
            self.bindAllSportsViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindAllSportsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.allSportsService = SportsService()
        self.fetchAllSportsDataFromAPI()
    }
    
    
    func fetchAllSportsDataFromAPI(){
        allSportsService.fetchSportsData { (sportData, error) in
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.sportsData = sportData
                
            }
        }
        
    }

}
