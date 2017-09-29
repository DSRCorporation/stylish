//
//  TextColorProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class TextColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.textColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.textColor = UIColor.black
        XCTAssert(label.textColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: label)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(label.textColor == UIColor.red)
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.textColor = UIColor.black
        XCTAssert(textField.textColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textField)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textField.textColor == UIColor.red)
    }
    
    func testProviderForTextView()
    {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textView.textColor = UIColor.black
        XCTAssert(textView.textColor == UIColor.black)
        
        do
        {
             try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textView.textColor == UIColor.red)
    }
    
    func testProviderForButton()
    {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".button", forObject: button)
        }
        catch
        {
            XCTFail()
        }
        
        let normalColor = button.titleColor(for: .normal)
        let selectedColor = button.titleColor(for: .selected)

        XCTAssert(normalColor == UIColor.red)
        XCTAssert(selectedColor == UIColor.blue)
    }

    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
