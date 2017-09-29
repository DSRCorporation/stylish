//
//  TintColorProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class TintColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.tintColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForSwitch()
    {
        let switchView = UISwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        switchView.onTintColor = UIColor.black
        switchView.tintColor = UIColor.black
        
        XCTAssert(switchView.tintColor == UIColor.black)
        XCTAssert(switchView.onTintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".switch", forObject: switchView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(switchView.tintColor == UIColor.green)
        XCTAssert(switchView.onTintColor == UIColor.blue)
    }
    
    func testProviderForPageControl()
    {
        let pageControlView = UIPageControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        pageControlView.currentPageIndicatorTintColor = UIColor.black
        pageControlView.pageIndicatorTintColor = UIColor.black
        
        
        XCTAssert(pageControlView.currentPageIndicatorTintColor == UIColor.black)
        XCTAssert(pageControlView.pageIndicatorTintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".page-control", forObject: pageControlView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(pageControlView.currentPageIndicatorTintColor == UIColor.red)
        XCTAssert(pageControlView.pageIndicatorTintColor == UIColor.blue)
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.tintColor = UIColor.black
        XCTAssert(view.tintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.tintColor == UIColor.red)
    }
    
    func testProviderForTabBar()
    {
        let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tabBar.tintColor = UIColor.black
        XCTAssert(tabBar.tintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tabBar)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(tabBar.tintColor == UIColor.red)
    }
    
    func testProviderForNavigationBar()
    {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        navBar.tintColor = UIColor.black
        XCTAssert(navBar.tintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: navBar)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(navBar.tintColor == UIColor.red)
    }
    
    func testProviderForBarButtonItem()
    {
        let barButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.black
        XCTAssert(barButtonItem.tintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: barButtonItem)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(barButtonItem.tintColor == UIColor.red)
    }

    
    func testProviderForSegmentedControl()
    {
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        segmentedControl.tintColor = UIColor.black
        XCTAssert(segmentedControl.tintColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: segmentedControl)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(segmentedControl.tintColor == UIColor.red)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
