//
//  SSButtonTests.swift
//  SwiftStylish
//
//  Created by Zamogilin Andrey on 1/5/17.
//  Copyright © 2017 DSR. All rights reserved.
//

import XCTest

class SSButtonTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        do
        {
            SwiftStylisher.default.bundle = Bundle(for: BackgroundColorProviderTests.self)
            try SwiftStylisher.default.loadFile(filename: "SSControls", bundle: Bundle(for: BackgroundColorProviderTests.self))
        }
        catch
        {
            XCTFail()
        }
    }
    
    override func tearDown()
    {
        SwiftStylisher.default.forceClear()
        super.tearDown()
    }
    
    func testBorderColor()
    {
        let button = SSButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".border-color", forObject: button)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(button.borderColor(atControlState: .normal) == .red)
        XCTAssert(button.borderColor(atControlState: .highlighted) == .green)
        XCTAssert(button.borderColor(atControlState: .disabled) == .blue)
    }
    
    func testBorderWidth()
    {
        let button = SSButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".border-width", forObject: button)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(button.borderWidth(atControlState: .normal) == 1.0)
        XCTAssert(button.borderWidth(atControlState: .highlighted) == 2.0)
        XCTAssert(button.borderWidth(atControlState: .disabled) == 3.0)
    }
    
    func testCornerRadius()
    {
        let button = SSButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".corner-radius", forObject: button)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(button.cornerRadius(atControlState: .normal) == 1.0)
        XCTAssert(button.cornerRadius(atControlState: .highlighted) == 2.0)
        XCTAssert(button.cornerRadius(atControlState: .disabled) == 3.0)
    }
}
