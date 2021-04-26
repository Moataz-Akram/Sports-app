//
//  FavLeaguesViewModel.swift
//  Sports app
//
//  Created by marwa on 4/25/21.
//

import Foundation
import CoreData
import Alamofire
class FavLeaguesViewModel: NSObject {
    var readData = getFavLeaguesFromCoreData()
    var isReachable = networkConnectionCheck()
    var deleteFavLeagues = deleteLeagueFromFav()
    var leaguesArray : [Dictionary<String,Any>] = []
    
    var FavLeaguesArray : [Dictionary<String,Any>]?{
        didSet{
            bindFavLeaguesWithView()
        }
    }
    var bindFavLeaguesWithView : (()->()) = {}
    
    func getDataFromCoreData(appDelegate : AppDelegate){
       let favArray = readData.getDataFromCoreData(appDelegate: appDelegate)
        FavLeaguesArray = favArray
        print("---------------------------------------------------\(FavLeaguesArray?.count)")
  }
    func isNetworkReachable() -> Bool {
        
        return isReachable.isNetworkReachable()
    }
    func deleteFav(id : String , appDelegate : AppDelegate){
        deleteFavLeagues.deleteFav(id: id, appDelegate: appDelegate)
    }

}

