//
//  allSportNetworkManager.swift
//  Sports appTests
//
//  Created by marwa on 4/29/21.
//

import Foundation
@testable import Sports_app
class AllSportNetworkManager{
    
    
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool) {
        
        self.shouldReturnError = shouldReturnError
    }
    
    var error : Error!
    
    let mockAllSportJSONResponse : Array<[String:Any]> = [
                                                            [
                                                               "idSport":"102",
                                                               "strSport":"Soccer",
                                                               "strFormat":"TeamvsTeam",
                                                               "strSportThumb":"https:www.thesportsdb.comimages/sports/soccer.jpg",
                                                               "strSportThumbGreen":"https:www.thesportsdb.com/images/sports/motorsport_green2.jpg",
                                                               "strSportDescription":"Association football, more commonly known as football or soccer, is a team sport played between two teams of eleven players with a spherical ball. It is played by 250 million players in over 200 countries and dependencies, making it the world's most popular sport. The game is played on a rectangular field with a goal at each end. The object of the game is to score by getting the ball into the opposing goal.\r\n\r\nPlayers are not allowed to touch the ball with their hands or arms while it is in play, unless they are goalkeepers (and then only when within their penalty area). Other players mainly use their feet to strike or pass the ball, but may also use any part of their body except the hands and the arms. The team that scores the most goals by the end of the match wins. If the score is level at the end of the game, either a draw is declared or the game goes into extra time or a penalty shootout depending on the format of the competition. The Laws of the Game were originally codified in England by The Football Association in 1863. Association football is governed internationally by the International Federation of Association Football (FIFA; French: Fédération Internationale de Football Association), which organises World Cups for both men and women every four years."
                                                            ],
                                                            [
                                                               "idSport":"103",
                                                               "strSport":"Motorsport",
                                                               "strFormat":"EventSport",
                                                               "strSportThumb":"https:/www.thesportsdb.com/images/sports/motorsport.jpg",
                                                               "strSportThumbGreen":"https:/www.thesportsdb.com/images/sports/motorsport_green2.jpg",
                                                               "strSportDescription":"Motorsport or motor sport is a global term used to encompass the group of competitive sporting events which primarily involve the use of motorised vehicles, whether for racing or non-racing competition. The terminology can also be used to describe forms of competition of two-wheeled motorised vehicles under the banner of motorcycle racing, and includes off-road racing such as motocross.\r\n\r\nFour- (or more) wheeled motorsport competition is globally governed by the Fédération Internationale de l'Automobile (FIA); and the Fédération Internationale de Motocyclisme (FIM) governs two-wheeled competition."
                                                            ]]
    
}
enum ResponseError : Error {
    case responseWithError
}



extension AllSportNetworkManager{
    func fetchSportsData(completion : @escaping ([Sport]?, Error?)->()) {
        var sport = [Sport]()
        do{
            
            let allSportData = try JSONSerialization.data(withJSONObject: mockAllSportJSONResponse, options: .fragmentsAllowed)
            
            
            sport = try JSONDecoder().decode([Sport].self, from: allSportData)
            
        }catch let error{
            
            print(error.localizedDescription)
            
        }
        
        
        if shouldReturnError{
            
            completion(nil , ResponseError.responseWithError)
            
        }else{
            
            completion(sport , nil)
        }
       
    }
    
    
}
