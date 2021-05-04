//
//  LeagueDetailsNetworkTest.swift
//  Sports appTests
//
//  Created by Moataz on 29/04/2021.
//

import XCTest

class LeagueDetailsNetworkTest: XCTestCase {

    var mockTeamsResponse : MockLeagueDetailNetwork!
    var mockTeamsError : MockLeagueDetailNetwork!

    override func setUpWithError() throws {
        mockTeamsResponse = MockLeagueDetailNetwork(shouldReturnError: false)
        mockTeamsError = MockLeagueDetailNetwork(shouldReturnError: true)
    }

    override func tearDownWithError() throws {
        mockTeamsResponse = nil
        mockTeamsError = nil
    }
    
    func testTeamsResopnse(){
        mockTeamsResponse.getTeamsInLeague(leagueStr: "") { (teams, error) in
            if error != nil{
                XCTFail()
            }
            if let teams = teams{
                XCTAssertTrue(teams.count==1)
            }

        }
    }
    
    func testTeamsError(){
        mockTeamsError.getTeamsInLeague(leagueStr: "") { (teams, error) in
            if error != nil{
//                XCTFail()
                XCTAssertTrue(true)
            }
            if let teams = teams{
                XCTAssertTrue(teams.count==1)
            }

        }

    }


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
