//
//  URLs.swift
//  Sports app
//
//  Created by Moataz on 22/04/2021.
//

import Foundation

struct URLs{

    public static var getAllSportsURL : String = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"

    public static let allLeaguesURL = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php?id=4328"
    public static let LeagueDetail = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="/*4346*/
    public static let teamsInLeague = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="/*...English%20Premier%20League...*/
    public static let passedEventsLeague = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="//4328 // the last 15 event in a leauge
    public static let comingEventFromSeason = "https://www.dddthesportsdb.com/api/v1/json/1/eventsround.php?id="//4328&r=38&s=2014-2015


}
