//
//  SportsAPI.swift
//  Sports app
//
//  Created by Moataz on 02/05/2021.
//

import Foundation

protocol SportsAPIProtocol{
    func getAllLeagues(completion: @escaping (Result<LeagueResponse?,NSError>) -> ())
    func getLeagueDetails(leagueId: String, completion: @escaping (Result<LeagueDetailResponse?,NSError>) -> ())
    func getUpcomingEvents(_ leagueId: String,_ round:String,_ season:String, completion: @escaping (Result<EventResponse?,NSError>) -> ())
    func getPassedEvents(leagueId:String, completion: @escaping (Result<EventResponse?,NSError>) -> ())
    func getTeamsInLeague(leagueStr:String,completion: @escaping (Result<TeamsResponse?, NSError>) -> ())
    func getAllSports(completion: @escaping (Result<AllSports?, NSError>) -> ())
}


class SportsAPI: BaseAPI<SportsNetwokring>, SportsAPIProtocol {
    func getTeamsInLeague(leagueStr: String, completion: @escaping (Result<TeamsResponse?, NSError>) -> ()) {
        self.fetchData(target: .getTeamsInLeague(leagueStr: leagueStr), responseClass: TeamsResponse.self) { (result) in
            completion(result)
        }
    }
    
    
    func getPassedEvents(leagueId: String, completion: @escaping (Result<EventResponse?, NSError>) -> ()) {
        self.fetchData(target: .getPassedEvents(leagueId: leagueId), responseClass: EventResponse.self) { (result) in
            completion(result)
        }
    }
    
    func getUpcomingEvents(_ leagueId: String, _ round: String, _ season: String, completion: @escaping (Result<EventResponse?, NSError>) -> ()) {
        self.fetchData(target: .getUpcomingEvents(leagueId, round, season), responseClass: EventResponse.self) { (result) in
            completion(result)
        }
    }
    
    func getLeagueDetails(leagueId: String, completion: @escaping (Result<LeagueDetailResponse?, NSError>) -> ()) {
        self.fetchData(target: .getLeagueDetails(leagueId: leagueId), responseClass: LeagueDetailResponse.self) { (result) in
            completion(result)
        }
    }
    
    //All requests
    func getAllLeagues(completion: @escaping (Result<LeagueResponse?, NSError>) -> ()) {
        self.fetchData(target: .getAllLeagues, responseClass: LeagueResponse.self) { (result) in
            completion(result)
        }
    }
    
    
    func getAllSports(completion: @escaping (Result<AllSports?, NSError>) -> ()) {
        self.fetchData(target: .getAllSport, responseClass: AllSports.self){
            (result) in
            completion(result)
        }
    }

    
}
