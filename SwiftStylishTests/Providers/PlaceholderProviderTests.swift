//
//  PlaceholderProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class PlaceholderProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.placeholder.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.placeholder = "1"
        
        XCTAssert(textField.placeholder == "1")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textField)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textField.placeholder == "test string")
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
 
}
