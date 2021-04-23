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
        let intFormedYear : String?
        let strBadge : String?
        let strBanner : String?
        let strComplete : String?
        let strCountry : String?
        let strCurrentSeason : String?
        let strDescriptionEN : String?
        let strDescriptionFR : String?
        let strDescriptionIT : String?
        let strDivision : String?
        let strFacebook : String?
        let strFanart1 : String?
        let strFanart2 : String?
        let strFanart3 : String?
        let strFanart4 : String?
        let strGender : String?
        let strLeague : String?
        let strLeagueAlternate : String?
        let strLocked : String?
        let strLogo : String?
        let strNaming : String?
        let strPoster : String?
        let strRSS : String?
        let strSport : String?
        let strTrophy : String?
        let strTwitter : String?
        let strWebsite : String?
        let strYoutube : String?
}

struct LeagueDetailAPI : Codable {
        let leagues : [LeaugeDetail]?
}


