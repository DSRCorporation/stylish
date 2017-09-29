//
//  TextProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class TextProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.text.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = ""
        
        XCTAssert(label.text == "")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: label)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(label.text == "test string")
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.text = ""
        
        XCTAssert(textField.text == "")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textField)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textField.text == "test string")
    }
    
    func testProviderForTextView()
    {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textView.text = ""
        
        XCTAssert(textView.text == "")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textView.text == "test string")
    }
    
    func testProviderForTabBarItem()
    {
        let tabBarItem = UITabBarItem(title: "no string", image: nil, tag: 0)
        XCTAssert(tabBarItem.title == "no string")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tabBarItem)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(tabBarItem.title == "test string")
    }
    
    func testProviderForButton()
    {
        let button =  UIButton(frame:  CGRect(x: 0, y: 0, width: 100, height: 100)  )
        button.setTitle( "no string", for: .normal);

        XCTAssert(button.title(for: .normal) == "no string")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: button)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(button.title(for: .normal) == "test string")
    }

    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
