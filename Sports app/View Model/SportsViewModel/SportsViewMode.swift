//
//  SportsViewMode.swift
//  Sports app
//
//  Created by marwa on 4/22/21.
//

import Foundation
import Alamofire
class SportsViewModel: NSObject {
    
    var allSportsService :SportsService!
    var isReachable = networkConnectionCheck()
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
    var showConnectionError : String! {
        didSet{
            self.bindViewModelConnectionErrorToView()
        }
    }
    
    
    var bindAllSportsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    var bindViewModelConnectionErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.allSportsService = SportsService()
       // self.handleApiCall()
        
    }
    
    func handleApiCall() {
        
        if isNetworkReachable(){
            self.fetchAllSportsDataFromAPI()
        }
        else{
            self.showConnectionError = "no internet connection"
            print(self.showConnectionError!)
//            var x = "no internet connection"
//            self.showError = x
        }
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
   
    func isNetworkReachable() -> Bool {
        return isReachable.isNetworkReachable()
    }

}
