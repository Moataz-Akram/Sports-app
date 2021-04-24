//
//  TeamDetailsService.swift
//  Sports app
//
//  Created by marwa on 4/24/21.
//

import Foundation
import Alamofire



class TeamDetailsService{
    
    
    func fetchTeamDetailsData(completion : @escaping ([[String: String?]]?, Error?)->() , id : Int){
        
        
        AF.request("https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id=\(id)")
            .validate()
            .responseDecodable(of: TeamDetails.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let TeamDetailsData = response.value else { return }
                    
                    completion(TeamDetailsData.teams,nil)
                    
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}
