//
//  File.swift
//  Sports app
//
//  Created by Moataz on 28/04/2021.
//

import Foundation
import Alamofire

class AllLeaguesModel{
    
    var allLeagues = [League]()

    func getAllLeagues(sportName : String, completion : @escaping ([League]?, Error?)->()){
        AF.request(URLs.allLeaguesURL).validate().responseDecodable(of: LeagueAPI.self) { (response) in
                switch response.result {
                case .success( _):
                    guard let leagues = response.value?.leagues else { return }
                    for league in leagues {
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
