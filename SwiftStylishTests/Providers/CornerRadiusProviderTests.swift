//
//  CornerRadiusProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class CornerRadiusProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.cornerRadius.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.cornerRadius = 0.0
        XCTAssert(view.layer.cornerRadius == 0.0)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        let roundedString = String(format: "%.1f", view.layer.cornerRadius)
        XCTAssert(roundedString == "10.3")
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
