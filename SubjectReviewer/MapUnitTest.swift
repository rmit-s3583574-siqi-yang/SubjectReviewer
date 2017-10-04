//
//  MapUnitTest.swift
//  SubjectReviewer
//
//  Created by siqi yang on 4/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import XCTest
@testable import SubjectReviewer


class MapUnitTest: XCTestCase {
    var map: MapViewController = MapViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testType() {
        let request = URLRequest(url: URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?&rankby=distance&location=-37.808148,144.962692&type=library&keyword=library&key=AIzaSyAMJlmar1bnGJza-mpBFgSg0CBNgOI-jC0")!)
        let element = "results"
        
        map.initialiseTaskForGettingData(request, element: element)
        
        let name = map.TYPE
        
        
        XCTAssert (name == "&type=library&keyword=library","incorrect location input")

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
