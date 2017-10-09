//
//  AttributedPlaceholderTests.swift
//  SwiftStylish
//

import Foundation
import XCTest
import UIKit

@testable import SwiftStylish

class AttributedPlaceholderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.attributedPlaceholder.rawValue
    }
    
    func testProviderForTextField()
    {
        let textField = UITextField()
        textField.attributedPlaceholder = nil
        XCTAssert(textField.attributedPlaceholder == nil)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textField)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        } 
        
        let attr = NSMutableAttributedString(string: "String1")
        let range = NSRange(location: 0, length: ("String1" as NSString).length)
        attr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
        
        XCTAssert(textField.attributedPlaceholder != nil)
        XCTAssert(textField.attributedPlaceholder!.isEqual(to: attr))
    }
}
