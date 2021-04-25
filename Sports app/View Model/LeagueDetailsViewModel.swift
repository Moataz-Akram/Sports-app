//
//  LeagueDetailsViewModel.swift
//  Sports app
//
//  Created by Moataz on 25/04/2021.
//

import Foundation

class LeagueDetailsViewModel {
    let network = SportsService()
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
            }
        }
    }

}
