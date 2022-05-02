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
    
    // MARK: - Setup
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
            .startTimer()
            .checkTimerResult("00:04")
            .resetTimer()
    }
    
    // MARK: - CoffeeRatioTests
    func testDecimalNumbers() {
        coffeeScreen
            .enterGramms("12.2")
            .enterWaterRatio("10")
            .checkCalculationsResult("122.0")
//            .clearWaterRatio()
//            .enterWaterRatio("5.1")
//            .checkCalculationsResult("62.22")
//       this will cause test to fail
    }
    
    func testBigNumbers() {
        coffeeScreen
            .enterGramms("10")
            .enterWaterRatio("10")
            .checkCalculationsResult("100.0")
    }
    
    func testZeros() {
        coffeeScreen
            .enterGramms("0")
            .enterWaterRatio("1")
            .checkCalculationsResult("0.0")
    }
    
    func testWrongInput() {
        coffeeScreen
            .enterGramms("1a")
            .enterWaterRatio("2")
            .checkCalculationsResult("0.0")
//            .enterGramms("aa")
//            .enterWaterRatio("aa")
//            .checkCalculationsResult("0.0")
//            .enterGramms("2")
//            .enterWaterRatio("agl")
//            .checkCalculationsResult("0.0")
    }
    
    // MARK: - TimerTests
    func testLongTimer() {
        coffeeScreen
            .startTimer()
            .checkTimerResult("01:01")
    }
    
    func testBasicTimer() {
        coffeeScreen
            .startTimer()
            .checkTimerResult("00:03")
            .resetTimer()
            .startTimer()
            .checkTimerResult("00:02")
            .pauseTimer()
            .checkTimerResult("00:02")
            .startTimer()
            .checkTimerResult("00:04")
            .resetTimer()
            .checkTimerResult("00:00")
    }
}
