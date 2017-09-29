//
//  SSTextFieldTests.swift
//  SwiftStylish
//
//  Created by Zamogilin Andrey on 1/5/17.
//  Copyright © 2017 DSR. All rights reserved.
//

import XCTest

class SSTextFieldTests: XCTestCase
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
        let textfield = SSTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".border-color", forObject: textfield)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textfield.borderColor(forState: .normal) == .red)
        XCTAssert(textfield.borderColor(forState: .highlighted) == .green)
        XCTAssert(textfield.borderColor(forState: .disabled) == .blue)
    }
    
    func testBorderWidth()
    {
        let textfield = SSTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".border-width", forObject: textfield)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textfield.borderWidth(forState: .normal) == 1.0)
        XCTAssert(textfield.borderWidth(forState: .highlighted) == 2.0)
        XCTAssert(textfield.borderWidth(forState: .disabled) == 3.0)
    }
    
    func testCornerRadius()
    {
        let textfield = SSTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".corner-radius", forObject: textfield)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textfield.cornerRadius(forState: .normal) == 1.0)
        XCTAssert(textfield.cornerRadius(forState: .highlighted) == 2.0)
        XCTAssert(textfield.cornerRadius(forState: .disabled) == 3.0)
    }
    
    func testBackgroundColor()
    {
        let textfield = SSTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".background-color", forObject: textfield)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textfield.backgroundColor(forState: .normal) == .red)
        XCTAssert(textfield.backgroundColor(forState: .highlighted) == .green)
        XCTAssert(textfield.backgroundColor(forState: .disabled) == .blue)
    }
}
