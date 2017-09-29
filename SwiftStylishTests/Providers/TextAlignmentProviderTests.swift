//
//  TextAlignmentProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class TextAlignmentProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.textAlignment.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.textAlignment = NSTextAlignment.natural
        XCTAssert(label.textAlignment == NSTextAlignment.natural)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: label)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(label.textAlignment == NSTextAlignment.center)
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.textAlignment = NSTextAlignment.natural
        XCTAssert(textField.textAlignment == NSTextAlignment.natural)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textField)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textField.textAlignment == NSTextAlignment.center)
    }
    
    func testProviderForTextView()
    {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textView.textAlignment = NSTextAlignment.natural
        XCTAssert(textView.textAlignment == NSTextAlignment.natural)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textView.textAlignment == NSTextAlignment.center)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
