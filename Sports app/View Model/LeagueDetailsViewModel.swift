//
//  LeagueDetailsViewModel.swift
//  Sports app
//
//  Created by Moataz on 25/04/2021.
//

import Foundation
import CoreData
class LeagueDetailsViewModel {
    var readData = getFavLeaguesFromCoreData()
    let network = LeagueDetailsModel()
    var deleteFavLeagues = deleteLeagueFromFav()
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
    
    
    func getPassedEvents(leagueId:String){
        network.getPassedEvents(leagueId: leagueId) { (pastEvents, error) in
            if let events:[Event] = pastEvents{
                print("old round \(events[0].intRound!)")
                self.round = String("\(Int(events[0].intRound!)!+1)")
                print("new round \(self.round)")

                self.pastEvents = events
            }else{
                
            }
        }
    }
    
    func getTeamsInLeague(leagueStr:String){
        network.getTeamsInLeague(leagueStr: leagueStr) { (teams, error) in
            if let teams:[Teams] = teams{
                self.teams = teams
            }else{
                
            }
        }
    }
    
    func getUpcomingEvents(_ leagueId: String){
        network.getUpcomingEvents(leagueId, round, season) { (events, error) in
            if let events = events{
                self.comingEvents = events
            }else{
                self.comingEventError = error?.localizedDescription
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
