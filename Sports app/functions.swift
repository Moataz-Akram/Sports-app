//
//  internetConnection.swift
//  Sports app
//
//  Created by marwa on 4/25/21.
//

import Foundation
import Alamofire
import CoreData
class networkConnectionCheck {
   
    func isNetworkReachable() -> Bool {
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        return manager?.isReachable ?? false
    }
    
}
class getFavLeaguesFromCoreData{
    
    func getDataFromCoreData(appDelegate : AppDelegate) -> [Dictionary<String,Any>] {
        var leaguesArray : [Dictionary<String,Any>] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: URLs.entityName)
        let myLeagues = try! managedContext.fetch(fetchReq)
        for item in myLeagues {
           if let myDate = item.value(forKey: URLs.attributeName){
              if let obj = NSKeyedUnarchiver.unarchiveObject(with: myDate as! Data) as! Dictionary<String,Any>?{
                  print(obj["name"]!)
                  leaguesArray.append(obj)
            }
        }
    }
        print("=====================================\(leaguesArray.count)")
           return leaguesArray
  }
    

}
class deleteLeagueFromFav {
    
    func deleteFav(id : String,appDelegate : AppDelegate){
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: URLs.entityName)
        let managedContext = appDelegate.persistentContainer.viewContext
        let myLeagues = try! managedContext.fetch(fetchReq)
      
        for item in myLeagues{
            if let myDate = item.value(forKey: URLs.attributeName){
               if let obj = NSKeyedUnarchiver.unarchiveObject(with: myDate as! Data) as! Dictionary<String,Any>?{
                if obj["id"] as! String == id {
                    managedContext.delete(item)
                }
          }
         }
        }
        try? managedContext.save()
        print("delete done -----------------------------------------")
    }
}

class getFavLeaguesFromCoreDataForTest{
    
    func getDataFromCoreData(appDelegate : AppDelegate) -> [Dictionary<String,Any>] {
        var leaguesArray : [Dictionary<String,Any>] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: URLs.entityName)
        let myLeagues = try! managedContext.fetch(fetchReq)
        for item in myLeagues {
           if let myDate = item.value(forKey: URLs.attributeName){
              if let obj = NSKeyedUnarchiver.unarchiveObject(with: myDate as! Data) as! Dictionary<String,Any>?{
                  print(obj["name"]!)
                  leaguesArray.append(obj)
            }
        }
    }
           return leaguesArray
  }
    

}
extension Notification.Name{
    static let notifyOther = Notification.Name("notification")
}
