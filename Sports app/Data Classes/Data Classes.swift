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
        let strYoutube : String?
        let strLogo : String?

        enum CodingKeys: String, CodingKey {
                case idLeague = "idLeague"
                case strLeague = "strLeague"
                case strLeagueAlternate = "strLeagueAlternate"
                case strSport = "strSport"
                case strYoutube = "strYoutube"
                case strLogo = "strLogo"
        }
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

struct EventAPI : Codable{
    var events : [Event]!
}


