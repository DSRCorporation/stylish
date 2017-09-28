//
//  SelectableProviderTests.swift
//  SwiftStylish
//
import XCTest

@testable import SwiftStylish

class SelectableProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.selectable.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForTextView()
    {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textView.isSelectable = false
        XCTAssert(textView.isSelectable == false)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: textView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(textView.isSelectable == true)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
