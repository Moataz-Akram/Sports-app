//
//  Sports_appUITests.swift
//  Sports appUITests
//
//  Created by Moataz on 20/04/2021.
//

import XCTest
import Alamofire
@testable import Sports_app
class Sports_appUITests: XCTestCase {
   // var check : networkConnectionCheck!
    
    var flag : Bool?
    override func setUpWithError() throws {
        continueAfterFailure = false
      //  check = networkConnectionCheck()
        flag = true
        
    }

    override func tearDownWithError() throws {
       
     //   check = nil
    }

    func testValidInternetConnection() throws {
       
        if(flag!/*check.isNetworkReachable()*/){
        let app = XCUIApplication()
        app.launch()
        let indicator = XCUIApplication().activityIndicators["In progress"]
        let verticalScrollBar3PagesCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 3 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar3PagesCollectionView.tap()
        XCTAssertTrue(verticalScrollBar3PagesCollectionView.exists)
        XCTAssertFalse(indicator.exists)
        XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier:"Soccer").element.tap()
            app.tables.children(matching: .searchField).element.tap()
            
     }
    }
    func testInValidInternetConnection() throws {
        if(!flag!/*!check.isNetworkReachable()*/){
        let app = XCUIApplication()
        app.launch()
        let indicator = XCUIApplication().activityIndicators["In progress"]
    
      let img = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      let labelInfo = app.staticTexts["NO INTERNET CONNECTION"]
        XCTAssertTrue(img.exists)
        XCTAssertTrue(labelInfo.exists)
        XCTAssertFalse(indicator.exists)
       
     }
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
