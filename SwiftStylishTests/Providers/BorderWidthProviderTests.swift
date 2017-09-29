//
//  BorderWidthProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class BorderWidthProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.borderWidth.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.borderWidth = 0.0
        XCTAssert(view.layer.borderWidth == 0.0)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        let roundedBorderWidthString = String(format: "%.1f", view.layer.borderWidth)
        XCTAssert(roundedBorderWidthString == "8.3")
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
