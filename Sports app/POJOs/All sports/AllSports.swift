//
//  AllSports.swift
//  Sports app
//
//  Created by marwa on 4/22/21.
//

import Foundation

// MARK: - AllSports
struct AllSports: Codable {
    let sports: [Sport]
}

// MARK: - Sport
struct Sport: Codable {
    let idSport, strSport: String
    let strFormat: String
    let strSportThumb, strSportThumbGreen: String
    let strSportDescription: String
    
    enum CodingKeys: String, CodingKey {
        case idSport = "idSport"
        case strSport = "strSport"
        case strFormat = "strFormat"
        case strSportThumb = "strSportThumb"
        case strSportThumbGreen = "strSportThumbGreen"
        case strSportDescription = "strSportDescription"
        
    }
}

//enum StrFormat: String, Codable {
//    case eventSport = "EventSport"
//    case teamvsTeam = "TeamvsTeam"
//}

