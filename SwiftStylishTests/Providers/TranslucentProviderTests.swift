//
//  TranslucentProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class TranslucentProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.translucent.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForNavigationBar()
    {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        navBar.isTranslucent = false
        XCTAssert(navBar.isTranslucent == false)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: navBar)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(navBar.isTranslucent == true)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
