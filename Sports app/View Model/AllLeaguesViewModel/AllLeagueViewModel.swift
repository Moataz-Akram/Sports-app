//
//  AllLeagueViewModel.swift
//  Sports app
//
//  Created by Moataz on 23/04/2021.
//

import Foundation

class AllLeaguesViewModel{
    let isReachable = networkConnectionCheck()
    let api:SportsAPIProtocol = SportsAPI()
    var leaguesDetails = [LeaugeDetail]()
    var leagues = [League]()
    
    var errorMessage:String!{
        didSet{
            
        }
    }
    var leaguesDetailCompleted:[LeaugeDetail]!{
        didSet{
            self.bindLeaguesToView()
        }
    }
    
    var bindLeaguesToView:(()->())={}

    func isNetworkReachable() -> Bool {
        return isReachable.isNetworkReachable()
    }

    //change to network layer
    
    func getAllLeaguesDetails(){
        for league in leagues {
            if league.strLeague != nil && league.idLeague != nil{
                api.getLeagueDetails(leagueId: league.idLeague!) {[weak self] (result) in
                    switch result{
                    
                    case .success(let response):
                        guard let league = response?.leagues?[0] else {return}
                        self?.leaguesDetails.append(league)
                        self?.leaguesDetailCompleted = self?.leaguesDetails
                    case .failure( _):
                        print("error in league details api call")
                    }
                }
            }
        }
    }
    
    
    func getAllLeagues(sportName : String){
        api.getAllLeagues { [weak self] (response) in
            switch response{
            
            case .success(let result):
                if let leaguesResponse = result{
                    if let comingLeagues = leaguesResponse.leagues{
                        for league in comingLeagues{
                            if league.strSport == sportName{
                                self?.leagues.append(league)
                            }
                        }
//                        self?.getAllLeaguesDetail()
                        self?.getAllLeaguesDetails()
                    }
                }
            case .failure( _):
                print("error")
            }
        }
    }
    
    
}
