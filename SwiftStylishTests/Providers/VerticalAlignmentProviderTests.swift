//
//  VerticalAlignmentProviderTests.swift
//  SwiftStylish
//

import UIKit
import XCTest

@testable import SwiftStylish

class VerticalAlignmentProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.verticalAlignment.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForButton()
    {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.contentVerticalAlignment = .top
        XCTAssert(button.contentVerticalAlignment == .top)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".content-alignment", forObject: button)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(button.contentVerticalAlignment == .bottom)
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textField.contentVerticalAlignment = .top
        XCTAssert(textField.contentVerticalAlignment == .top)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: ".content-alignment", forObject: textField)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(textField.contentVerticalAlignment == .bottom)
    }
}
