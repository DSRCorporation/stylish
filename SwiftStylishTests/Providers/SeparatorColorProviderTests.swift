//
//  SeparatorColorProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class SeparatorColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.separatorColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForTableView()
    {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        tableView.separatorColor = UIColor.black
        XCTAssert(tableView.separatorColor == UIColor.black)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tableView)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssert(tableView.separatorColor == UIColor.red)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
