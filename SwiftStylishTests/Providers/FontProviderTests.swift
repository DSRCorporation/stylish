//
//  FontProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class FontProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.font.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.font = UIFont.systemFont(ofSize: 1)
        XCTAssert(label.font.familyName != "Arial")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: label)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(label.font == UIFont(name: "Arial", size: 12))
    }
    
    func testProviderForButton()
    {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertNotNil(button.titleLabel)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 1)
        XCTAssert(button.titleLabel?.font.familyName != "Arial")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: button)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(button.titleLabel?.font == UIFont(name: "Arial", size: 12))
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.font = UIFont.systemFont(ofSize: 1)
        XCTAssert(textField.font?.familyName != "Arial")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textField)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(textField.font == UIFont(name: "Arial", size: 12))
    }
    
    func testProviderWithSystemFontForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.font = UIFont(name: "Arial", size: 1)
        XCTAssert(label.font.familyName == "Arial")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".system-" + self.key, forObject: label)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(label.font == UIFont.systemFont(ofSize: 12))
    }
    
    // MARK: - Fonts with descriptor
    
    func testFontWithDescriptor()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.font = UIFont(name: "Arial", size: 1)
        XCTAssert(label.font.familyName == "Arial")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".fontWithDescriptor", forObject: label)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(label.font.fontDescriptor.symbolicTraits.contains(.traitItalic))
        XCTAssert(label.font.fontDescriptor.symbolicTraits.contains(.traitBold))
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
