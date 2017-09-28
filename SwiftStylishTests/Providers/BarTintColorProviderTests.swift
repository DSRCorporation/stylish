//
//  BarTintColorProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class BarTintColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.barTintColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }

    func testProviderForTabBar()
    {
        let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tabBar.barTintColor = UIColor.black
        XCTAssert(tabBar.barTintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tabBar)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(tabBar.barTintColor == UIColor.red)
    }
    
    func testProviderForNavigationBar()
    {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        navBar.barTintColor = UIColor.black
        XCTAssert(navBar.barTintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: navBar)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(navBar.barTintColor == UIColor.red)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
