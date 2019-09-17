//
//  ProgressTintColorProviderTests.swift
//  SwiftStylishTests
//

import XCTest

@testable import SwiftStylish

class ProgressTintColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.progressTintColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProvider()
    {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 3))
        progressView.progressTintColor = .green
        
        XCTAssert(progressView.progressTintColor == .green)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: progressView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(progressView.progressTintColor == UIColor.red)
    }
}
