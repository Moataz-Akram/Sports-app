//
//  LeagueDetailsModel.swift
//  Sports app
//
//  Created by Moataz on 28/04/2021.
//

import Foundation
import Alamofire

class LeagueDetailsModel{
    func getPassedEvents(leagueId:String,completion : @escaping ([Event]?, Error?)->()){
        let url = String("\(URLs.passedEventsLeague)\(leagueId)")
        print(url)
        AF.request(url).validate().responseDecodable(of: EventAPI.self) { (response) in
            switch response.result{
            case .success( _):
                guard let events = response.value?.events else { return }
                print("response received \(events.count)")
                completion(events,nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil , error)
                
            }
        }
    }
    
    
    func getTeamsInLeague(leagueStr:String,completion : @escaping ([Teams]?, Error?)->()){
        let replaced = leagueStr.replacingOccurrences(of: " ", with: "%20")
        let url = String("\(URLs.teamsInLeague)\(replaced)")
        print(url)
        AF.request(url).validate().responseDecodable(of: TeamsAPI.self) { (response) in
            switch response.result{
            case .success( _):
                guard let teams = response.value?.teams else { return }
                print("response received")
                completion(teams,nil)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil , error)

            }
        }
    }

    func getUpcomingEvents(_ leagueId: String,_ round:String,_ season:String, completion : @escaping ([Event]?, Error?)->()){
        let url = "\(URLs.comingEventFromSeason)\(leagueId)&r=\(round)&s=\(season)"
        print(url)
        AF.request(url).validate().responseDecodable(of: EventAPI.self){(response) in
            switch response.result{
            case .success(_):
                print("coming event success")
                guard let events = response.value?.events else { return }
                completion(events,nil)
                print(events.count)
            case .failure(let error):
                print("coming event failure")
                completion(nil,error)
            }
        }
    }
    
    

}
