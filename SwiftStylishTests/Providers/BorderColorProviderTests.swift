//
//  BorderColorProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class BorderColorProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.borderColor.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.borderColor = UIColor.red.cgColor
        XCTAssert(view.layer.borderColor == UIColor.red.cgColor)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.layer.borderColor == UIColor.green.cgColor)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
