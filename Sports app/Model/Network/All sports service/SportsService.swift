//
//  SportsService.swift
//  Sports app
//
//  Created by marwa on 4/22/21.
//

import Foundation
import Alamofire



class SportsService{
    var allLeagues = [League]()
    
    func fetchSportsData(completion : @escaping ([Sport]?, Error?)->()){
        
        
        AF.request(URLs.getAllSportsURL)
            .validate()
            .responseDecodable(of: AllSports.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let sportsData = response.value else { return }
                    
                    completion(sportsData.sports,nil)
                    
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
    func getAllLeagues(sportName : String, completion : @escaping ([League]?, Error?)->()){
        
        AF.request(URLs.allLeaguesURL).validate().responseDecodable(of: LeagueAPI.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let leagues = response.value?.leagues else { return }
                    
                    for league in leagues {
//                        print(league.strLeague as Any)
                        if league.strSport == sportName {
                            self.allLeagues.append(league)

                        }
                    }
                    completion(self.allLeagues,nil)
                case .failure(let error):
                    completion(nil , error)
                }
            
            }
    }
    
    func getLeaugesDetail(leagueId:String,completion : @escaping (LeaugeDetail?, Error?)->()){
        let url = String("\(URLs.LeagueDetail)\(leagueId)")
        AF.request(url).validate().responseDecodable(of: LeagueDetailAPI.self) { (response) in
                switch response.result {
                case .success( _):
                    
                    guard let leagues = response.value?.leagues else { return }
                    completion(leagues[0],nil)
                case .failure(let error):
                    completion(nil , error)
                }
            }
    }

    
    

    
}
