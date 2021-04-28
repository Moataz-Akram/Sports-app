//
//  AllLeagueViewModel.swift
//  Sports app
//
//  Created by Moataz on 23/04/2021.
//

import Foundation

class AllLeaguesViewModel{
    let sportsService = SportsService()
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

    func getAllLeagues(sportName : String){
        sportsService.getAllLeagues(sportName : sportName) { (leagues, error) in
            if let comingLeauges:[League] = leagues{
                self.leagues = comingLeauges
                print("count is \(self.leagues.count)")
                self.getAllLeaguesDetail()
            }else{
                print("NotWroking")
                print(error.debugDescription)
            }
        }
    }
    
    func getAllLeaguesDetail(){
        
        for league in leagues {
            if league.strLeague != nil {
                sportsService.getLeaugesDetail(leagueId: league.idLeague!) { (leagueDetail, error) in
                    if let detail:LeaugeDetail = leagueDetail{
                        print(detail.strLeague! as Any)
                        self.leaguesDetails.append(detail)
                        self.leaguesDetailCompleted = self.leaguesDetails
                    }
                }
            }
        }
    }
    
    
}
