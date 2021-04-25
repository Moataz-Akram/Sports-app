//    var idHomeTeam: String?
//    var idAwayTeam: String?
    var homeBadge: String?
//
//  Data Classes.swift
//  Sports app
//
//  Created by Moataz on 22/04/2021.
//

import Foundation

struct League : Codable {


        let idLeague : String?
        let strLeague : String?
        let strLeagueAlternate : String?
        let strSport : String?
       

        enum CodingKeys: String, CodingKey {
                case idLeague = "idLeague"
                case strLeague = "strLeague"
                case strLeagueAlternate = "strLeagueAlternate"
                case strSport = "strSport"
                
        }

}

struct LeagueAPI : Codable {
    let leagues : [League]?
}

struct LeaugeDetail : Codable {
    
    var idLeague : String?
    var strBadge : String?
    var strLeague : String?
    var strSport : String?
    var strYoutube : String?
    var strCurrentSeason : String?
}

struct LeagueDetailAPI : Codable {
    let leagues : [LeaugeDetail]?
}

struct Event : Codable {
    
    var strEvent : String?
    var strHomeTeam : String?
    var strAwayTeam : String?
    var intHomeScore : String?
    var intAwayScore : String?
    var dateEvent : String?
    var awayBadge: String?
    var strTime : String?
    var strSeason : String?
    var intRound : String?
}

struct EventAPI : Codable {
    var events : [Event]!
}

struct Teams : Codable {
    
    var strTeam : String?
    var strDescriptionEN : String?
    var strStadium : String?
    var strCountry : String?
    var strLeague : String?
    var strTeamBadge : String?
    var strStadiumThumb : String?
    var strTwitter : String?
    var strFacebook : String?
    var strInstagram : String?
}

struct TeamsAPI : Codable {
    var teams : [Teams]!
}



