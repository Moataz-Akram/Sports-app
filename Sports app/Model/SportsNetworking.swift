//
//  SportsNetworking.swift
//  Sports app
//
//  Created by Moataz on 02/05/2021.
//

import Foundation
import Alamofire

enum SportsNetwokring {
    case getAllSport
    case getAllLeagues
    case getLeagueDetails(leagueId: String)
    case getUpcomingEvents(_ leagueId: String,_ round:String,_ season:String)
    case getPassedEvents(leagueId:String)
    case getTeamsInLeague(leagueStr:String)
}

extension SportsNetwokring: TargetType{
    var baseURL: String {
        switch self {
        default:
            return "https://www.thesportsdb.com/api/v1/json/1"
        }
    }
    
    var path: String {
        switch self{
        
        case .getAllSport:
            return "/all_sports.php"
        case .getAllLeagues:
            return "/all_leagues.php"
        case .getLeagueDetails(leagueId: let leagueId):
            return "/lookupleague.php?id=\(leagueId)"
        case .getUpcomingEvents(let id, let round, let season):
            return "/eventsround.php?id=\(id)&r=\(round)&s=\(season)"
        case .getPassedEvents(leagueId: let leagueId):
            return "/eventspastleague.php?id=\(leagueId)"
        case .getTeamsInLeague(leagueStr: let leagueStr):
            return "/search_all_teams.php?l=\(leagueStr)"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getAllSport:
            return .requestPlain
        case .getAllLeagues:
            return .requestPlain
        case .getLeagueDetails:
            return .requestPlain
        case .getUpcomingEvents:
            return .requestPlain
        case .getPassedEvents:
            return .requestPlain
        case .getTeamsInLeague:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        default:
            return [:]
        }
    }
    
    
}
