//
//  BackgroundColorProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class BackgroundColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.backgroundColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }

    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.blue
        XCTAssert(view.backgroundColor == UIColor.blue)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.backgroundColor == UIColor.red)
    }
    
    func testProviderForTableView()
    {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.backgroundColor = UIColor.blue
        XCTAssert(tableView.backgroundColor == UIColor.blue)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tableView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(tableView.backgroundColor == UIColor.red)
    }
    
    func testProviderForTableViewCell()
    {
        let tableViewCell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableViewCell.backgroundColor = UIColor.blue
        tableViewCell.contentView.backgroundColor = UIColor.blue
        XCTAssert(tableViewCell.backgroundColor == UIColor.blue && tableViewCell.contentView.backgroundColor == UIColor.blue)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tableViewCell)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssertTrue(tableViewCell.backgroundColor == UIColor.red, "TableViewCell background color is not red.")
        XCTAssertTrue(tableViewCell.contentView.backgroundColor == UIColor.red, "Cell contentView's background color is not red.")
    }
    
    func testProviderForTabBar()
    {
        let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tabBar.backgroundColor = UIColor.blue
        XCTAssert(tabBar.backgroundColor == UIColor.blue)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tabBar)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(tabBar.backgroundColor == UIColor.red)
    }
    
    func testProviderForSegmentedControl()
    {
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        segmentedControl.backgroundColor = UIColor.blue
        XCTAssert(segmentedControl.backgroundColor == UIColor.blue)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: segmentedControl)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(segmentedControl.backgroundColor == UIColor.red)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
