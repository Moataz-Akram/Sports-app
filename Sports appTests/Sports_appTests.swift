//
//  Sports_appTests.swift
//  Sports appTests
//
//  Created by Moataz on 20/04/2021.
//

import XCTest
@testable import Sports_app

class Sports_appTests: XCTestCase {
    var allSportnetworkManger : AllSportNetworkManager!
    override func setUpWithError() throws {
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
        allSportnetworkManger = AllSportNetworkManager(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        allSportnetworkManger = nil
    }
    func testGetAllSports(){
        
        allSportnetworkManger.fetchSportsData { (sport, error) in
            if let error = error{
                XCTFail()
            }else{
                XCTAssertEqual(sport?.count, 2)
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
