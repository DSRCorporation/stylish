//
//  HorizontalAlignmentProviderTests.swift
//  SwiftStylish
//

import UIKit
import XCTest

@testable import SwiftStylish

class HorizontalAlignmentProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.horizontalAlignment.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForButton()
    {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.contentHorizontalAlignment = .left
        XCTAssert(button.contentHorizontalAlignment == .left)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".content-alignment", forObject: button)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(button.contentHorizontalAlignment == .right)
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.contentHorizontalAlignment = .left
        XCTAssert(textField.contentHorizontalAlignment == .left)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".content-alignment", forObject: textField)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(textField.contentHorizontalAlignment == .right)
    }
}
