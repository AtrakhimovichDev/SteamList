//
//  SteamListTests.swift
//  SteamListTests
//
//  Created by Andrei Atrakhimovich on 16.11.21.
//

import XCTest
@testable import SteamList

class SteamListTests: XCTestCase {

    var sut: ModelsFactory!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ModelsFactory.shared
    }
    
    override func tearDownWithError() throws {
       sut = nil
        try super.tearDownWithError()
    }
}
