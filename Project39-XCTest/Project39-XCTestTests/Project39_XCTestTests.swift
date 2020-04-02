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
        XCTAssertEqual(playData.allWords.count, 18440, "allWords must be 18440")
    }

    func testWordCountsAreCorrect() {
        let playData = PlayData()
        XCTAssertEqual(playData.wordCounts.count(for: "home"), 174, "Home does not appear 174 times")
        XCTAssertEqual(playData.wordCounts.count(for: "fun"), 4, "Fun does not appear 4 times")
        XCTAssertEqual(playData.wordCounts.count(for: "mortal"), 41, "Mortal does not appear 41 times")
    }

    func testWordsLoadQuickly() {
        measure {
            _ = PlayData()
        }
    }

    func testUserFilterWorks() {
        let playData = PlayData()

        playData.applyUserFilter("100")
        XCTAssertEqual(playData.filteredWords.count, 495, "There should be 495 words with more than 100 occurrences")

        playData.applyUserFilter("1000")
        XCTAssertEqual(playData.filteredWords.count, 55, "There should be 5 words with more than 100 occurrences")

        playData.applyUserFilter("10000")
        XCTAssertEqual(playData.filteredWords.count, 1, "There should only be one word with more than 10000 occurrences")

        playData.applyUserFilter("test")
        XCTAssertEqual(playData.filteredWords.count, 56, "The word test should have occured 56 times")

        playData.applyUserFilter("swift")
        XCTAssertEqual(playData.filteredWords.count, 7, "The word swift should have occurred 7 times")

        playData.applyUserFilter("objective-c")
        XCTAssertEqual(playData.filteredWords.count, 0, "The word objective-c should not have occurred at all")
    }
}
