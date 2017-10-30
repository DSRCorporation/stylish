//
//  TrackTintColorProviderTests.swift
//  SwiftStylishTests
//

import Foundation

import XCTest

@testable import SwiftStylish

class TrackTintColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.trackTintColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProvider()
    {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 3))
        progressView.trackTintColor = .green
        
        XCTAssert(progressView.trackTintColor == .green)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: progressView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(progressView.trackTintColor == UIColor.red)
    }
}
