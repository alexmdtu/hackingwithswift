//
//  Project39_XCTestTests.swift
//  Project39-XCTestTests
//
//  Created by Alexander Tu on 01.04.20.
//  Copyright © 2020 Alexander Tu. All rights reserved.
//

@testable import Project39_XCTest
import XCTest

class Project39_XCTestTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAllWordsLoaded() {
        let playData = PlayData()
        XCTAssertEqual(playData.allWords.count, 384001, "allWords must be 384001")
    }
}
