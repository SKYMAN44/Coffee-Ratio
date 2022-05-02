//
//  BaseTest.swift
//  RatiosUITests
//
//  Created by Дмитрий Соколов on 29.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import XCTest
import Foundation

class BaseTest: XCTestCase {
    lazy var app = XCUIApplication()

    open override func setUp() {
        app.launchArguments = ["enable-testing"]
        app.launch()
        continueAfterFailure = false
    }

    open override func tearDown() {
        app.terminate()
    }
    
//    override func record(_ issue: XCTIssue) {
//        let screenshot = XCUIScreen.main.screenshot()
//        let attachment = XCTAttachment(screenshot: screenshot)
//        attachment.lifetime = .deleteOnSuccess
//        attachment.name = issue.description
//        add(attachment)
//    }
}

