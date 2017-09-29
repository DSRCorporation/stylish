//
//  TitlesProviderTests.swift
//  SwiftStylish
//

import XCTest
import UIKit

@testable import SwiftStylish

class TitlesProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.titles.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForSegmentedControl()
    {
        let segmentedControl = UISegmentedControl(items:["One","two", "three"]);
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: segmentedControl)
        }
        catch
        {
            XCTFail()
        }
        
        let title1 = segmentedControl.titleForSegment(at: 0)
        let title2 = segmentedControl.titleForSegment(at: 1)
        let title3 = segmentedControl.titleForSegment(at: 2)

        XCTAssert(title1 == "firstItem")
        XCTAssert(title2 == "secondItem")
        XCTAssert(title3 == "thirdItem")
        
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
