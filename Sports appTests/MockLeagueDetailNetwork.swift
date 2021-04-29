//
//  MockLeagueDetailNetwork.swift
//  Sports appTests
//
//  Created by Moataz on 29/04/2021.
//

import XCTest
@testable import Sports_app

class MockLeagueDetailNetwork {

    var error:Error!
    var shouldReturnError:Bool
    
    init(shouldReturnError:Bool) {
        self.shouldReturnError = shouldReturnError
    }

    let mockJSONresponse : [String:Any] = ["teams":[
                                            [    "strTeam" : "Arsenal",
                                                "strDescriptionEN" : "Description",
                                                 "strStadium" : "Emirates Stadium",
                                                 "strCountry" : "England",
                                                 "strLeague" : "English Premier League",
                                                 "strTeamBadge" : "https://www.thesportsdb.com/images/media/team/badge/uyhbfe1612467038.png",
                                                 "strStadiumThumb" : "https://www.thesportsdb.com/images/media/team/stadium/w1anwa1588432105.jpg",
                                                 "strTwitter" : "twitter",
                                                 "strFacebook" : "face",
                                                 "strInstagram" : "insta"
                                            ]]]
    
    enum ResponseError : Error {
        case responseWithError
    }
    
    func getTeamsInLeague(leagueStr:String,completion : @escaping ([Teams]?, Error?)->()){
        //response type
        var teamAPI = TeamsAPI()
        //value will return in complition -> could be resopnse type then we won't need this var
        var teams = [Teams]()
        do{
            //convert the mockJSONresponse to be like a response from the API call
            let teamsData = try JSONSerialization.data(withJSONObject: mockJSONresponse, options: .fragmentsAllowed)
            //read the data as from API call
            teamAPI = try JSONDecoder().decode(TeamsAPI.self, from: teamsData)
            // collecting data needed in completion
            teams = teamAPI.teams
        } catch let error{
            print(error.localizedDescription)
        }
        //wheather I choose to return error or a value in the test result
        if shouldReturnError{
            completion(nil,ResponseError.responseWithError)
        }else{
            completion(teams,nil)
        }
        
    }



}
