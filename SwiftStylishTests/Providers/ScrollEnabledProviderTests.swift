//
//  ScrollEnabledProvider.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class ScrollEnabledProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.scrollEnabled.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForScrollView()
    {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        scrollView.isScrollEnabled = false
        XCTAssert(scrollView.isScrollEnabled == false)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: scrollView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(scrollView.isScrollEnabled == true)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
