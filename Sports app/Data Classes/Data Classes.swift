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
    var strYoutube : String?
    var strLogo : String?
    
}

struct LeagueAPI : Codable {
    let leagues : [League]?
}

struct LeaugeDetail : Codable {
    
    let idLeague : String?
    let strBadge : String?
    let strLeague : String?
    let strSport : String?
    let strYoutube : String?
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
    var idHomeTeam: String?
    var idAwayTeam: String?
    var homeBadge: String?
    var awayBadge: String?
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



