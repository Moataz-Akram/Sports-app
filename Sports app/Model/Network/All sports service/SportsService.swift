//
//  SportsService.swift
//  Sports app
//
//  Created by marwa on 4/22/21.
//

import Foundation
import Alamofire



class SportsService{
    
    
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
    
}
