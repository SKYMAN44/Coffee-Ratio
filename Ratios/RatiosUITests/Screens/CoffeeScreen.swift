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
    private enum Identifier: String, CaseIterable {
        case startPause = "StartPauseButton"
        case reset = "ResetButton"
        case grammsInput = "gramsTextField"
        case waterInput = "waterTextField"
        case waterRatioLabel = "1"
        case screenTopLabel = "How much coffee?"
        case waterTopLabel = "You need"
        case waterBottomLabel = "grams of water"
        case ratioTopLabel = "What ratio?"
        case waterAmountLabel = "WaterNeededLabel"
        case timerLabel = "TimerLabel"
    }

    private enum KeyboardIdentifier: String {
        case keyboardReturn = "Return"
        case keyboardDelete = "delete"
    }
    
    private func elementById(_ id: Identifier) -> XCUIElement {
        switch id {
        case .startPause, .reset:
            return app.buttons[id.rawValue]
        case .grammsInput, .waterInput:
            return app.textFields[id.rawValue]
        case .waterRatioLabel, .screenTopLabel, .waterTopLabel, .waterBottomLabel, .ratioTopLabel, .waterAmountLabel, .timerLabel:
            return app.staticTexts[id.rawValue]
        }
    }
    
    private func keyboardElement(_ id: KeyboardIdentifier) -> XCUIElement {
        app.keyboards.buttons[id.rawValue]
    }
    
    // MARK: - Basic Validation
    @discardableResult
    func validateUILoading() -> Self {
        Identifier.allCases.forEach {
            XCTAssertTrue(elementById($0).exists, "Object must exist: \($0.rawValue)")
        }
        XCTAssertTrue(elementById(.startPause).label == "Start", "Button must have Start label on launch")
        XCTAssertTrue(elementById(.timerLabel).label == "00:00", "Timer default value must be 00:00")
        
        return self
    }
    
    // MARK: - TextField Manipulations
    @discardableResult
    func enterGramms(_ gramms: String) -> Self {
        let grammsTextField = elementById(.grammsInput)
        grammsTextField.tap()
        grammsTextField.typeText(gramms)
        keyboardElement(.keyboardReturn).tap()
        
        return self
    }
    
    @discardableResult
    func enterWaterRatio(_ amount: String) -> Self {
        let waterTextField = elementById(.waterInput)
        waterTextField.tap()
        waterTextField.typeText(amount)
        keyboardElement(.keyboardReturn).tap()
        
        return self
    }
    
    @discardableResult
    func checkCalculationsResult(_ correctResult: String) -> Self {
        let value = elementById(.waterAmountLabel).label
        let isEqual = value.elementsEqual(correctResult)
        XCTAssertEqual(isEqual, true, "gramms of water must be equal \(correctResult)")
        
        return self
    }
    
    // MARK: - Timer Manipulations
    @discardableResult
    func startTimer() -> Self {
        // avoid boilerplate code
        timerButtonsValidation(elementById(.startPause), "Start", "Pause")
        
        return self
    }
    
    @discardableResult
    func pauseTimer() -> Self {
        timerButtonsValidation(elementById(.startPause), "Pause", "Start")
        
        return self
    }
    
    @discardableResult
    func resetTimer() -> Self {
        timerButtonsValidation(elementById(.reset), "Reset", "Reset")

        return self
    }
    
    @discardableResult
    func checkTimerResult(_ time: String) -> Self {
        let timerLabelSeconds = app.staticTexts[time]
        let seconds = convertStringToSeconds(time)
        XCTAssertTrue(timerLabelSeconds.waitForExistence(timeout: seconds), "Timer must show \(time)")
        
        return self
    }
    
    private func timerButtonsValidation(_ element: XCUIElement, _ before: String, _ after: String) {
        XCTAssertTrue(element.exists, "Button Must Always Exists")
        XCTAssertEqual(element.label, before, "Button must be labeled before tap as \(before)")
        
        element.tap()
        
        XCTAssertEqual(element.label, after, "Button must be labeled after tap as \(after)")
    }
}

// MARK: - Helper function
extension CoffeeScreen {
    private func convertStringToSeconds(_ time: String) -> Double {
        let components = time.split { $0 == ":" }.map { Double(String($0))! }
        return components[0] * 60 + components[1]
    }
}
