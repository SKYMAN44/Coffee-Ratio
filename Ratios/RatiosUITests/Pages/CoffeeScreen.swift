//
//  CoffeeScreen.swift
//  RatiosUITests
//
//  Created by Дмитрий Соколов on 29.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import Foundation
import XCTest

final class CoffeeScreen: BaseScreen {
    private lazy var startButton = app.buttons["Start"]
    private lazy var pauseButton = app.buttons["Pause"]
    private lazy var resetButton = app.buttons["Reset"]
    private lazy var keyBoardReturn = app.buttons["Return"]
    private lazy var waterRatioLabel = app.staticTexts["1"]
    private lazy var screenTitle = app.staticTexts["How much coffee?"]
    private lazy var waterTopLabel = app.staticTexts["You need"]
    private lazy var waterBottomLabel = app.staticTexts["grams of water"]
    private lazy var coffeeAmountLabel = app.staticTexts["0.0"]
    private lazy var timerLabel = app.staticTexts["00:00"]
    private lazy var ratioTitle = app.staticTexts["What ratio?"]
    
    private lazy var grammsTextField = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
    private lazy var waterTextField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
    
    // MARK: - Basic Validation
    @discardableResult
    func validateUILoading() -> Self {
        XCTAssertTrue(startButton.exists)
        XCTAssertTrue(resetButton.exists)
        XCTAssertTrue(screenTitle.exists)
        XCTAssertTrue(ratioTitle.exists)
        XCTAssertTrue(grammsTextField.exists)
        XCTAssertTrue(waterTextField.exists)
        XCTAssertTrue(coffeeAmountLabel.exists)
        XCTAssertTrue(timerLabel.exists)
        XCTAssertTrue(waterTopLabel.exists)
        XCTAssertTrue(waterBottomLabel.exists)
        XCTAssertTrue(waterRatioLabel.exists)
        
        XCTAssertFalse(pauseButton.exists)
        
        return self
    }
    
    @discardableResult
    func checkCalculationsResult(_ correctResult: String) -> Self {
        XCTAssertTrue(app.staticTexts[correctResult].exists)
        XCTAssertFalse(coffeeAmountLabel.exists)
        
        return self
    }
    
    // MARK: - TextField Manipulations
    @discardableResult
    func enterGramms(_ gramms: String) -> Self {
        grammsTextField.tap()
        grammsTextField.typeText(gramms)
        keyBoardReturn.tap()
        
        return self
    }
    
    @discardableResult
    func enterWaterRatio(_ amount: String) -> Self {
        waterTextField.tap()
        waterTextField.typeText(amount)
        keyBoardReturn.tap()
        
        return self
    }
    
    // MARK: - Timer Manipulation
    @discardableResult
    func startTimer() -> Self {
        startButton.tap()
        
        return self
    }
    
    @discardableResult
    func pauseTimer() -> Self {
        pauseButton.tap()
        
        return self
    }
    
    @discardableResult
    func resetTimer() -> Self {
        resetButton.tap()
        
        return self
    }
    
    @discardableResult
    func checkTimerResult(_ time: String) -> Self {
        let timerLabelSeconds = app.staticTexts[time]
        let seconds = convertStringToSeconds(time)
        XCTAssertTrue(timerLabelSeconds.waitForExistence(timeout: seconds))
        
        return self
    }
    
    @discardableResult
    func verifyTimer(_ time: String) -> Self {
        startButton.tap()
        
        XCTAssertFalse(startButton.exists)
        XCTAssertTrue(pauseButton.exists)
        
        pauseButton.tap()
        
        XCTAssertFalse(pauseButton.exists)
        XCTAssertTrue(startButton.exists)
        
        startButton.tap()
        
        let timerLabelFiveSeconds = app.staticTexts[time]
        let seconds = convertStringToSeconds(time)
        XCTAssertTrue(timerLabelFiveSeconds.waitForExistence(timeout: seconds))
        
        resetButton.tap()
        
        XCTAssertTrue(timerLabel.exists)
        
        return self
    }
}

// MARK: - Helper function
extension CoffeeScreen {
    private func convertStringToSeconds(_ time: String) -> Double {
        let components = time.split { $0 == ":" }.map { Double(String($0))! }
        return components[0] * 60 + components[1]
    }
}
