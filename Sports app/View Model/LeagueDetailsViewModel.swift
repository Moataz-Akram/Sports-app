//
//  LeagueDetailsViewModel.swift
//  Sports app
//
//  Created by Moataz on 25/04/2021.
//

import Foundation
import CoreData
class LeagueDetailsViewModel {
    let readData = getFavLeaguesFromCoreData()
    let isReachable = networkConnectionCheck()
    let deleteFavLeagues = deleteLeagueFromFav()
    let api = SportsAPI()
    var round = "1"
    var season = "2020-2021"
    var comingEvents : [Event]!{
        didSet{
            bindComingEventsWithView()
        }
    }
    
    var pastEvents : [Event]!{
        didSet{
            bindPassedEventsWithView()
        }
    }
    var teams : [Teams]!{
        didSet{
            bindTeamsWithView()
        }
    }
    
    var comingEventError : String!{
        didSet{
            bindComingEventsErrorWithView()
        }
    }
    
    var bindTeamsWithView:(()->()) = {}
    var bindComingEventsWithView:(()->()) = {}
    var bindPassedEventsWithView:(()->()) = {}
    var bindTeamsErrorWithView:(()->()) = {}
    var bindComingEventsErrorWithView:(()->()) = {}
    var bindPassedEventsErrorWithView:(()->()) = {}
    var bindFavCheckWithView:(()->()) = {}
    
    func isNetworkReachable() -> Bool {
        return isReachable.isNetworkReachable()
    }

    func getPassedEventsNew(leagueId:String){
        api.getPassedEvents(leagueId: leagueId) { [weak self] (result) in
            switch result{

            case .success(let response):
                guard let events = response?.events else {return}
                if let _:String = events[0].intRound{
                    print("old round \(events[0].intRound!)")
                    self?.round = String("\(Int(events[0].intRound!)!+1)")
                    print("new round \(self?.round)")
                    self?.pastEvents = events
                }else{

                }

            case .failure(let error):
                print("\(error.userInfo)")
            }
        }
    }
    
    func getTeamsInLeagueNew(leagueStr:String){
        let replaced = leagueStr.replacingOccurrences(of: " ", with: "%20")
        api.getTeamsInLeague(leagueStr: replaced) { [weak self] (result) in
            switch result{
            
            case .success(let response):
                guard let teams = response?.teams else {return}
                self?.teams = teams
            case .failure(let error):
                print("\(error.userInfo)")
            }
        }
    }
    
    func getUpcomingEventsNew(_ leagueId: String){
        api.getUpcomingEvents(leagueId, round, season) {[weak self] (result) in
            switch result{
            case .success(let response):
                guard let comingEvents = response?.events else {return}
                self?.comingEvents = comingEvents
            case .failure(let error):
                self?.comingEventError = error.localizedDescription
                print("error for coming events")
            }
        }
    }
    
    
    func addToFav(league : LeaugeDetail , appDelegate : AppDelegate){
        var DI = Dictionary<String,Any>()
        DI["name"] = league.strLeague
        DI["badge"] = league.strBadge
        DI["youtube"] = league.strYoutube
        DI["id"] = league.idLeague
       let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: URLs.entityName, in: managedContext)
               let leagues = NSManagedObject(entity: entity!, insertInto: managedContext)
            //   arr.append(obj)
        let date = NSKeyedArchiver.archivedData(withRootObject: DI)
        leagues.setValue(date, forKey: URLs.attributeName)
               do{
                   try managedContext.save()
                   print("Done")
               }
               catch let error as NSError{
                   print(error)
               }
    }
    
    func isFavLeagues( id : String ,appDelegate : AppDelegate) -> Bool{
        var allFavLeagues = readData.getDataFromCoreData(appDelegate: appDelegate)
        for item in allFavLeagues{
            if item["id"] as! String == id{
                return true
            }
        }
        return false
    }
    
    func deleteFav(id : String , appDelegate : AppDelegate){
        deleteFavLeagues.deleteFav(id: id, appDelegate: appDelegate)
    }

}
