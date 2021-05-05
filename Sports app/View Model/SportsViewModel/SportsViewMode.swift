//
//  SportsViewMode.swift
//  Sports app
//
//  Created by marwa on 4/22/21.
//

import Foundation
import Alamofire
class SportsViewModel: NSObject {
    let api:SportsAPIProtocol = SportsAPI()
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
       // self.handleApiCall()
        self.fetchAllSportsData()
        
    }
    
    func handleApiCall() {
        
        if isNetworkReachable(){
            self.fetchAllSportsData()
        }
        else{
            self.showConnectionError = "no internet connection"
            print(self.showConnectionError!)
        }
    }
   
    func isNetworkReachable() -> Bool {
        return isReachable.isNetworkReachable()
    }
    
    func fetchAllSportsData(){
        api.getAllSports(){[weak self] (result) in
            switch result{
            
            case .success(let response):
                guard let allSports = response?.sports else {return}
                self!.sportsData = allSports
            case .failure(_):
                self!.showError = "error in all sport api call"
            }
        }
    }

}
