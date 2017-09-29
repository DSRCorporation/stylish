//
//  OpacityProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class OpacityProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.opacity.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.opacity = 1.0
        XCTAssert(view.layer.opacity == 1.0)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        let roundedString = String(format: "%.2f", view.layer.opacity)
        XCTAssert(roundedString == "0.45")
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
