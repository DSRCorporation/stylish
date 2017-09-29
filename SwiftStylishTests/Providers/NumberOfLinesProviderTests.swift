//
//  NumberOfLinesProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class NumberOfLinesProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.numberOfLines.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForLabel()
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.numberOfLines = 1
        XCTAssert(label.numberOfLines == 1)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: label)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(label.numberOfLines == 12)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
