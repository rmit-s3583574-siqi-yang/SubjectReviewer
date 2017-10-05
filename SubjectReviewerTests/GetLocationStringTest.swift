//
//  GetLocationStringTest.swift
//  SubjectReviewerTests
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import XCTest
@testable import SubjectReviewer
import CoreLocation
class GetLocationStringTest: XCTestCase {
    var map: MapViewController = MapViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let lat: CLLocationDegrees = -33.0
        let lng: CLLocationDegrees = 144.0
        let result = map.getLocationString(lat,lng)
        XCTAssert(result == "location=-33.0,144.0", "The string not right")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
}
