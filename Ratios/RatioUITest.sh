#!/bin/bash
echo Running RatiosUITests

xcodebuild \
 test \
 -project Ratios.xcodeproj \
 -scheme RatiosUITests \
 -destination 'platform=iOS Simulator,name=iPhone 13 mini'
