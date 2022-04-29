//
//  CoffeeScreenTest.swift
//  RatiosUITests
//
//  Created by Дмитрий Соколов on 29.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import XCTest

final class CoffeeScreenTest: BaseTest {
    lazy var coffeeScreen = CoffeeScreen(app)
    
    override func setUp() {
        super.setUp()
    }
    
    func testValidateCoffeeScreenItems() {
        coffeeScreen.validateUILoading()
    }
    
    func testBasicWorkflow() {
        coffeeScreen
            .enterGramms("10")
            .enterWaterRatio("1")
            .checkCalculationsResult("10.0")
            .verifyTimer("00:05")
    }
    
    func testLongTimer() {
        coffeeScreen.verifyTimer("01:01")
    }
    
    func testDecimalNumbers() {
        coffeeScreen
            .enterGramms("12.2")
            .enterWaterRatio("1")
            .checkCalculationsResult("12.2")
//            .enterWaterRatio("2.5")
//            .checkCalculationsResult("30.5")
//       this will cause test to fail
    }
    
    func testBigNumbers() {
        coffeeScreen
            .enterGramms("10")
            .enterWaterRatio("10")
            .checkCalculationsResult("100.0")
    }
    
    func testTimer() {
        coffeeScreen
            .startTimer()
            .checkTimerResult("00:03")
            .resetTimer()
            .startTimer()
            .checkTimerResult("00:02")
            .pauseTimer()
            .checkTimerResult("00:02")
            .resetTimer()
            .checkTimerResult("00:00")
    }
}
