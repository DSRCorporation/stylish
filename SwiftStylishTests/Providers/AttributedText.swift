//
//  AttributedText.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class AttributedText: BaseProviderTests
{    
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.attributedText.rawValue
    }
    
    func testProviderForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.attributedText = nil
        XCTAssert(label.attributedText == nil)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: label)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        let attr = NSMutableAttributedString(string: "String1")
        let range = NSRange(location: 0, length: ("String1" as NSString).length)
        attr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
        
        XCTAssertNotNil(label.attributedText)
        XCTAssert(label.attributedText!.isEqual(to: attr))
    }
}
