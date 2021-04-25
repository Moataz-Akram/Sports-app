//
//  FavLeaguesViewModel.swift
//  Sports app
//
//  Created by marwa on 4/25/21.
//

import Foundation
import CoreData
class FavLeaguesViewModel: NSObject {
    
    var leaguesArray : [Dictionary<String,Any>] = []
    
    var FavLeaguesArray : [Dictionary<String,Any>]?{
        didSet{
            bindFavLeaguesWithView()
        }
    }
    var bindFavLeaguesWithView : (()->()) = {}
    
    func getDataFromCoreData(appDelegate : AppDelegate) {
   // let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
   // let entity = NSEntityDescription.entity(forEntityName: URLs.entityName, in: managedContext)
  //  var leagues  = NSManagedObject(entity: entity!, insertInto: managedContext)
    let fetchReq = NSFetchRequest<NSManagedObject>(entityName: URLs.entityName)
    let myLeagues = try! managedContext.fetch(fetchReq)
   // add_movies = []
    for item in myLeagues {
        if let myDate = item.value(forKey: URLs.attributeName){
            if let obj = NSKeyedUnarchiver.unarchiveObject(with: myDate as! Data) as! Dictionary<String,Any>?{
                print(obj["name"]!)
                leaguesArray.append(obj)
            }
        }
    }
        FavLeaguesArray = leaguesArray
  }
}

