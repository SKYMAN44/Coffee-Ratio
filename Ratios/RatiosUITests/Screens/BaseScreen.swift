//
//  BaseScreen.swift
//  RatiosUITests
//
//  Created by Дмитрий Соколов on 29.04.2022.
//  Copyright © 2022 John Peden. All rights reserved.
//

import Foundation
import XCTest

class BaseScreen {
    public let app: XCUIApplication
    
    public init(_ app: XCUIApplication) {
        self.app = app
    }
}
