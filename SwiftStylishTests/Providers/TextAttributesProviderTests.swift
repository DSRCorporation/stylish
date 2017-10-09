//
//  TextAttributesProviderTests.swift
//  SwiftStylish
//

import XCTest
import UIKit

@testable import SwiftStylish

class TextAttributesProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.textAttributes.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForSegmentedControl()
    {
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: segmentedControl)
        }
        catch
        {
            XCTFail()
        }
        
        let normalAttrs = segmentedControl.titleTextAttributes(for: .normal)
        let fontName1 = (normalAttrs?[NSAttributedStringKey.font] as? UIFont)?.fontName
        let color1 = (normalAttrs?[NSAttributedStringKey.foregroundColor] as? UIColor)
        
        XCTAssert(fontName1 == "ArialMT")
        XCTAssert(color1 == UIColor.red)
        
        let selectedAttrs = segmentedControl.titleTextAttributes(for: .selected)
        let fontName2 = (selectedAttrs?[NSAttributedStringKey.font] as? UIFont)?.fontName
        let color2 = (selectedAttrs?[NSAttributedStringKey.foregroundColor] as? UIColor)
        
        XCTAssert(fontName2 == "Helvetica")
        XCTAssert(color2 == UIColor.blue)
        
    }
    
    func testProviderForNavigationBar()
    {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let normalAttrs1 = navBar.titleTextAttributes
        let fontName1 = (normalAttrs1?[NSAttributedStringKey.font] as? UIFont)?.fontName
        let color1 = normalAttrs1?[NSAttributedStringKey.foregroundColor] as? UIColor
        
        XCTAssert(fontName1 != "ArialMT")
        XCTAssert(color1 != UIColor.red)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: navBar)
        }
        catch
        {
            XCTFail()
        }
        
        let normalAttrs2 = navBar.titleTextAttributes
        XCTAssertNotNil(normalAttrs2)
        let fontName2 = (normalAttrs2![NSAttributedStringKey.font] as! UIFont).fontName
        let color2 = (normalAttrs2![NSAttributedStringKey.foregroundColor] as! UIColor)
        
        XCTAssert(fontName2 == "ArialMT")
        XCTAssert(color2 == UIColor.red)
    }
    
    func testProviderForBarButtonItem()
    {
        let barButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: nil)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: barButtonItem)
        }
        catch
        {
            XCTFail()
        }
        
        let normalAttrs = barButtonItem.titleTextAttributes(for: .normal)
        let fontName1 = (normalAttrs?[NSAttributedStringKey.font.rawValue] as? UIFont)?.fontName
        let color1 = (normalAttrs?[NSAttributedStringKey.foregroundColor.rawValue] as? UIColor)
        
        XCTAssert(fontName1 == "ArialMT")
        XCTAssert(color1 == UIColor.red)
        
        let selectedAttrs = barButtonItem.titleTextAttributes(for: .selected)
        let fontName2 = (selectedAttrs?[NSAttributedStringKey.font.rawValue] as? UIFont)?.fontName
        let color2 = (selectedAttrs?[NSAttributedStringKey.foregroundColor.rawValue] as? UIColor)
        
        XCTAssert(fontName2 == "Helvetica")
        XCTAssert(color2 == UIColor.blue)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
